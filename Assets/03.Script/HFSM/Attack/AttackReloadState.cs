using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class AttackReloadState : State, IObserver
{
    private StateSubject stateSubject;

    private StateMachine mainStateMachine;

    private MoveState moveState; // Main
    private IdleState idleState; // Main
    private AttackStartState attackStartState; // Sub
    
    

    public AttackReloadState(StateMachine stateMachine, AIController aIController, 
        StateSubject stateSubject) : base(stateMachine, aIController)
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
        // TODO : IDLE 상태로 이동
        if (!controller.EnemyDetection())
        {
            mainStateMachine.ChangeState(idleState);
            return;
        }

        stateMachine.ChangeState(attackStartState);
    }

    public void ObserverUpdate()
    {
        attackStartState = stateSubject.AttackStartState;
        mainStateMachine = stateSubject.MainStateMachine;
        moveState = stateSubject.MoveState;
        idleState = stateSubject.IdleState;
    }
}
