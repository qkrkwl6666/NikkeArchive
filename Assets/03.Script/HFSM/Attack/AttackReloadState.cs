using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackReloadState : State, IObserver
{
    private StateSubject stateSubject;

    private AttackStartState attackStartState;

    public AttackReloadState(StateMachine stateMachine, AIController aIController, 
        StateSubject stateSubject) : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.ATTACK_RELOAD);
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

        stateMachine.ChangeState(attackStartState);
    }

    public void ObserverUpdate()
    {
        attackStartState = stateSubject.AttackStartState;
    }
}
