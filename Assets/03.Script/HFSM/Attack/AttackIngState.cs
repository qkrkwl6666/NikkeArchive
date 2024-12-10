public class AttackIngState : SubState, IObserver
{
    StateSubject stateSubject;

    private AttackDelayState attackDelayState;

    public AttackIngState(SubStateMachine subStateMachine, AIController aIController, StateSubject stateSubject)
        : base(subStateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.NikkeStats.CurrentAmmo--;
        controller.AnimationPlay(AnimationStrings.ATTACK_ING);
        controller.SubState = Sub_State.ATTACK_ING;
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;

        //if(controller.TargetEnemy == null || !controller.EnemyDetection())
        //{
        //    Debug.Log("controller.TargetEnemy == null || !controller.EnemyDetection()");
        //    stateMachine.ChangeState(attackDelayState);
        //    return;
        //}

    }

    public void AnimationEventAttackIngEnd()
    {
        subStateMachine.ChangeState(attackDelayState);
    }

    public void ObserverUpdate()
    {
        attackDelayState = stateSubject.AttackDelayState;
    }
}
