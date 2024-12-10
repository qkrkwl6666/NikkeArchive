public class AttackReloadState : SubState, IObserver
{
    private StateSubject stateSubject;

    private MainStateMachine mainStateMachine;

    private MoveState moveState; // Main
    private IdleState idleState; // Main
    private AttackStartState attackStartState; // Sub
    private AttackDelayState attackDelayState; // Sub

    public AttackReloadState(SubStateMachine subStateMachine, AIController aIController,
        StateSubject stateSubject) : base(subStateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.ATTACK_RELOAD);
        controller.SubState = Sub_State.ATTACK_RELOAD;
    }

    public override void Exit()
    {
        controller.NikkeStats.ReloadAmmo();
    }

    public override void Execute()
    {

    }

    public void AnimationEventAttackReloadEnd()
    {

        if (!controller.EnemyDetection())
        {
            mainStateMachine.ChangeState(moveState);
            return;
        }

        subStateMachine.ChangeState(attackStartState);
    }

    public void ObserverUpdate()
    {
        attackStartState = stateSubject.AttackStartState;
        attackDelayState = stateSubject.AttackDelayState;
        mainStateMachine = stateSubject.MainStateMachine;
        moveState = stateSubject.MoveState;
        idleState = stateSubject.IdleState;
    }
}
