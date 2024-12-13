public class AttackStartState : SubState, IObserver
{
    private StateSubject stateSubject;

    private AttackDelayState attackdelayState;

    public AttackStartState(SubStateMachine subStateMachine, AIController aIController, StateSubject stateSubject)
        : base(subStateMachine, aIController)
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

    public override void Update()
    {
        if (controller == null) return;


    }

    public void AnimationEventAttackStartEnd()
    {
        subStateMachine.ChangeState(attackdelayState);
    }

    public void ObserverUpdate()
    {
        attackdelayState = stateSubject.AttackDelayState;
    }
}
