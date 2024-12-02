using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class AttackReloadState : State, IObserver
{
    private StateSubject stateSubject;

    private AttackStartState attackStartState; // Sub
    private MoveState moveState; // Main
    private StateMachine mainStateMachine;

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
        // TODO : 적 있으면 StartState 적 없으면 MoveState이동
        if (!controller.EnemyDetection())
        {
            mainStateMachine.ChangeState(moveState);
            return;
        }

        stateMachine.ChangeState(attackStartState);
    }

    public void ObserverUpdate()
    {
        attackStartState = stateSubject.AttackStartState;
        mainStateMachine = stateSubject.MainStateMachine;
        moveState = stateSubject.MoveState;
    }
}
