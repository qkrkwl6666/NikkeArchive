using UnityEngine;

public class MoveCoverState : SubState, IObserver
{
    private StateSubject stateSubject;

    private MoveEndState moveEndState;
    private MovingState movingState;

    public MoveCoverState(SubStateMachine subStateMachine, AIController aIController, 
        StateSubject stateSubject) : base(subStateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.SubState = Sub_State.MOVE_COVER;

        if(!controller.CoverDetection())
        {
            subStateMachine.ChangeState(movingState);
            return;
        }

        controller.SetAgentDestination(controller.CoverObject.CoverPoint.position);

        switch (controller.CoverObject.CoverType)
        {
            case CoverType.Stand:
                controller.CurrentAnimationState = Animation_State.STAND;
                break;
            case CoverType.Kneel:
                controller.CurrentAnimationState = Animation_State.KNEEL;
                break;
        }

        AnimatorStateInfo stateInfo = controller.Animator.GetCurrentAnimatorStateInfo(0);
        if (stateInfo.IsName(AnimationStrings.MOVE_ING)) return;
        controller.AnimationPlay(AnimationStrings.MOVE_ING);

    }
    public override void Execute()
    {
        // CoverObject ∞° null ¿Ã∞Ì 
        if(controller.CoverObject == null)
        {
            subStateMachine.ChangeState(movingState);
        }

        IsDestinationReached();
    }

    public override void Exit() 
    {
        controller.StopAgent();
    }

    public void IsDestinationReached()
    {
        if (controller.NavMeshAgent.pathPending) return;

        if(controller.NavMeshAgent.remainingDistance <= controller.NavMeshAgent.stoppingDistance)
        {
            if(!controller.NavMeshAgent.hasPath || controller.NavMeshAgent.velocity.sqrMagnitude == 0f)
            {
                subStateMachine.ChangeState(moveEndState);
            }
        }
    }

    public void ObserverUpdate()
    {
        moveEndState = stateSubject.MoveEndState;
        movingState = stateSubject.MovingState;
    }
}
