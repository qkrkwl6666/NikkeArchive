public class AttackReloadState : SubState, IObserver
{
    private StateSubject stateSubject;

    private MainStateMachine mainStateMachine;

    private MoveState moveState; // Main
    private IdleState idleState; // Main

    private AttackStartState attackStartState; // Sub
    private AttackDelayState attackDelayState; // Sub
    private MovingState movingState;
    private MoveJumpState moveJumpState;

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
            if (controller.CoverObject == null)
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

        subStateMachine.ChangeState(attackStartState);
    }

    public void ObserverUpdate()
    {
        attackStartState = stateSubject.AttackStartState;
        attackDelayState = stateSubject.AttackDelayState;
        mainStateMachine = stateSubject.MainStateMachine;
        moveState = stateSubject.MoveState;
        movingState = stateSubject.MovingState;
        moveJumpState = stateSubject.MoveJumpState;
        idleState = stateSubject.IdleState;
    }
}
