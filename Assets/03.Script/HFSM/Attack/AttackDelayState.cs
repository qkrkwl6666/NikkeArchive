using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackDelayState : State, IObserver
{
    private StateSubject stateSubject;

    private AttackEndState attackEndState;
    private AttackIngState attackIngState;
    private AttackReloadState attackReloadState;

    private float time = 0f;

    // Main State Machine
    private StateMachine mainStateMachine;
    // Move State
    private MoveState moveState;

    public AttackDelayState(StateMachine stateMachine, AIController aIController, StateSubject stateSubject) 
        : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;

        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.ATTACK_DELAY);

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
        if (controller.TargetEnemy == null || !controller.EnemyDetection())
        {
            mainStateMachine.ChangeState(moveState);

            return;
        }

        State state = controller.HasAmmo() ? attackIngState : attackReloadState;
        stateMachine.ChangeState(state);
    }

    public void ObserverUpdate()
    {
        attackEndState = stateSubject.AttackEndState;
        attackIngState = stateSubject.AttackIngState; 
        attackReloadState = stateSubject.AttackReloadState;
        mainStateMachine = stateSubject.MainStateMachine;
        moveState = stateSubject.MoveState;
    }
}
