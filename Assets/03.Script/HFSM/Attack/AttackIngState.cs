using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackIngState : State, IObserver
{
    StateSubject stateSubject;

    private AttackDelayState attackDelayState;

    public AttackIngState(StateMachine stateMachine, AIController aIController, StateSubject stateSubject) 
        : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.NikkeStats.CurrentAmmo--;
        controller.AnimationPlay(AnimationStrings.ATTACK_ING);
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;

        if(controller.TargetEnemy == null)
        {
            stateMachine.ChangeState(attackDelayState);
        }

    }

    public void AnimationEventAttackIngEnd()
    {
        stateMachine.ChangeState(attackDelayState);
    }

    public void ObserverUpdate()
    {
        attackDelayState = stateSubject.AttackDelayState;
    }
}
