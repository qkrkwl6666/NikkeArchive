using UnityEngine;

public class MovingState : SubState, IObserver
{
    private StateSubject stateSubject;

    // MainState
    private AttackState attackState;
    private MoveState moveState;

    // SubState
    private MoveEndState moveEndState;
    private MoveCoverState moveCoverState;

    private float time = 0f;
    private float enemyDetectTime = 0.1f;

    public MovingState(SubStateMachine subStateMachine, AIController aIController,
        StateSubject stateSubject) : base(subStateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.SubState = Sub_State.MOVE_ING;
        time = 0f;
        controller.CurrentAnimationState = Animation_State.NORMAL;
        controller.SetAgentDestination(controller.TargetPosition.position);
    }

    public override void Exit()
    {
        time = 0f;
        controller.StopAgent();
    }

    public override void Execute()
    {
        //controller.MoveFront();

        time += Time.deltaTime;

        if (time >= enemyDetectTime)
        {

            if (controller.EnemyDetection(controller.DetectMargin))
            {
                CheckAndMoveToCover();
                
                return;
            }

            time = 0f;
        }
    }

    public void CheckAndMoveToCover()
    {
        if(controller.CoverDetection())
        {
            Debug.Log("moveCoverState");
            subStateMachine.ChangeState(moveCoverState);
            return;
        }

        Debug.Log("moveEndState");
        subStateMachine.ChangeState(moveEndState);   
    }


    public void ObserverUpdate()
    {
        attackState = stateSubject.AttackState;
        moveState = stateSubject.MoveState;
        moveEndState = stateSubject.MoveEndState;
        moveCoverState = stateSubject.MoveCoverState;
    }
}
