using UnityEngine;

public class AttackDelayState : SubState, IObserver
{
    private StateSubject stateSubject;

    private AttackEndState attackEndState;
    private AttackIngState attackIngState;
    private AttackReloadState attackReloadState;

    private float time = 0f;

    // Main State Machine
    private MainStateMachine mainStateMachine;
    // Move State
    private MoveState moveState;
    private MoveCoverState moveCoverState;

    public AttackDelayState(SubStateMachine subStateMachine, AIController aIController, 
        StateSubject stateSubject): base(subStateMachine, aIController)
    {
        this.stateSubject = stateSubject;

        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.ATTACK_DELAY);
        controller.SubState = Sub_State.ATTACK_DELAY;
        time = 0f;
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;

        time += Time.deltaTime;

        if (time >= controller.NikkeStats.DelayTime)
        {
            time = 0f;

            ChangeStateEnemy();
        }
    }


    public void ChangeStateEnemy()
    {
        if (!controller.EnemyDetection())
        {
            // 적 없으면 attackEndState 이동
            subStateMachine.ChangeState(attackEndState);
            return;
        }

        if (controller.CoverObject == null && controller.CoverDetection()) 
        {
            mainStateMachine.ChangeState(moveState, moveCoverState);
            //moveState.SubStateMachine.Initialize(MoveCoverState)
            return;
        }

        SubState state = controller.HasAmmo() ? attackIngState : attackReloadState;
        subStateMachine.ChangeState(state);
    }

    public void ObserverUpdate()
    {
        attackEndState = stateSubject.AttackEndState;
        attackIngState = stateSubject.AttackIngState;
        attackReloadState = stateSubject.AttackReloadState;
        mainStateMachine = stateSubject.MainStateMachine;
        moveState = stateSubject.MoveState;
        moveCoverState = stateSubject.MoveCoverState;
    }
}
