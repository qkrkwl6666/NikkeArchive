public class AttackStartState : State, IObserver
{
    private StateSubject stateSubject;

    private AttackDelayState attackdelayState;

    public AttackStartState(StateMachine stateMachine, AIController aIController, StateSubject stateSubject)
        : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.ATTACK_START);
        controller.SubState = Sub_State.ATTACK_START;
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;


    }

    public void AnimationEventAttackStartEnd()
    {
        stateMachine.ChangeState(attackdelayState);
    }

    public void ObserverUpdate()
    {
        attackdelayState = stateSubject.AttackDelayState;
    }
}
