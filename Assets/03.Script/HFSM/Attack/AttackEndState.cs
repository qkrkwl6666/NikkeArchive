public class AttackEndState : SubState, IObserver
{
    private StateSubject stateSubject;

    private MainStateMachine mainStateMachine;

    private MoveState moveState;
    private IdleState idleState;

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

    public override void Execute()
    {
        if (controller == null) return;


    }
    public void AnimationAttackEndEvent()
    {
        // Move 상태 이동
        mainStateMachine.ChangeState(moveState);
    }

    public void ObserverUpdate()
    {
        moveState = stateSubject.MoveState;
        idleState = stateSubject.IdleState;
        mainStateMachine = stateSubject.MainStateMachine;
    }
}
