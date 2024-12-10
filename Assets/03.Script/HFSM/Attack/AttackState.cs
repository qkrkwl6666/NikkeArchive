public class AttackState : MainState, IObserver
{
    private StateSubject stateSubject;

    public SubStateMachine SubStateMachine { get; private set; }

    public AttackStartState AttackStartState { get; private set; }
    public AttackIngState AttackIngState { get; private set; }
    public AttackDelayState AttackDelayState { get; private set; }
    public AttackReloadState AttackReloadState { get; private set; }
    public AttackEndState AttackEndState { get; private set; }

    // Move
    private MoveState moveState;

    public Attack_State CurrentAttackState { get; set; } = Attack_State.ATTACK_START;


    public AttackState(MainStateMachine mainStateMachine, AIController controller, StateSubject stateSubject)
        : base(mainStateMachine, controller)
    {
        this.stateSubject = stateSubject;

        stateSubject.RegisterObserver(this);

        SubStateMachine = new SubStateMachine();

        AttackStartState = new AttackStartState(SubStateMachine, controller, stateSubject);
        AttackIngState = new AttackIngState(SubStateMachine, controller, stateSubject);
        AttackDelayState = new AttackDelayState(SubStateMachine, controller, stateSubject);
        AttackReloadState = new AttackReloadState(SubStateMachine, controller, stateSubject);
        AttackEndState = new AttackEndState(SubStateMachine, controller, stateSubject);
    }

    public override void Enter()
    {
        if (!controller.EnemyDetection())
        {
            UnityEngine.Debug.Log("AttackState Enter !controller.EnemyDetection()");
            mainStateMachine.ChangeState(moveState);
            return;
        }


        if (!controller.HasAmmo())
        {
            SubStateMachine.Initialize(AttackReloadState);
            return;
        }

        SubStateMachine.Initialize(AttackStartState);
    }

    public override void Exit()
    {
        // SubState Exit 처리
        SubStateMachine.CurrentStateExit();

        if(controller.CoverObject != null)
        {
            controller.CoverObject.UnCover();
            controller.CoverObject = null;
        }
    }

    public override void Execute()
    {
        if (controller == null) return;

        if (controller.TargetEnemy != null)
        {
            controller.RotateEnemy();
        }

        SubStateMachine.Update();
    }


    #region 애니메이션 이벤트
    public void AnimationAttackStartEvent()
    {
        AttackStartState.AnimationEventAttackStartEnd();
    }
    public void AnimationAttackIngEvent()
    {
        AttackIngState.AnimationEventAttackIngEnd();
    }
    public void AnimationAttackReloadEvent()
    {
        AttackReloadState.AnimationEventAttackReloadEnd();
    }

    public void AnimationAttackEndEvent()
    {
        AttackEndState.AnimationAttackEndEvent();
    }

    public void ObserverUpdate()
    {
        moveState = stateSubject.MoveState;
    }

    #endregion

}

public enum Attack_State
{
    ATTACK_START,
    ATTACK_ING,
    ATTACK_DELAY,
    ATTACK_END,
    ATTACK_RELOAD,
}