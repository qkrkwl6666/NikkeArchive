public class AttackEndState : SubState, IObserver
{
    private StateSubject stateSubject;

    private MainStateMachine mainStateMachine;

    private MoveState moveState;
    private IdleState idleState;

    private MovingState movingState;
    private MoveJumpState moveJumpState;

    public AttackEndState(SubStateMachine subStateMachine, AIController aIController,
        StateSubject stateSubject) : base(subStateMachine, aIController)
    {
        this.stateSubject = stateSubject;

        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.ATTACK_END);
        controller.SubState = Sub_State.ATTACK_END;
    }

    public override void Exit()
    {

    }

    public override void Update()
    {
        if (controller == null) return;


    }
    public void AnimationAttackEndEvent()
    {
        // Move 상태 이동
        if(controller.CoverObject == null)
        {
            mainStateMachine.ChangeState(moveState, movingState);
            return;
        }
        else
        {
            switch (controller.CurrentAnimationState)
            {
                case Animation_State.NORMAL:
                case Animation_State.STAND:
                    mainStateMachine.ChangeState(moveState, movingState);
                    break;
                case Animation_State.KNEEL:
                    mainStateMachine.ChangeState(moveState, moveJumpState);
                    break;
            }
            return;
        }
    }

    public void ObserverUpdate()
    {
        moveState = stateSubject.MoveState;
        movingState = stateSubject.MovingState;
        idleState = stateSubject.IdleState;
        mainStateMachine = stateSubject.MainStateMachine;
        moveJumpState = stateSubject.MoveJumpState;
    }
}
