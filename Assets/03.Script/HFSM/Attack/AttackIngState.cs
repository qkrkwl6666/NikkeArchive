using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackIngState : State
{
    private AttackDelayState attackDelayState;
    private AttackEndState attackEndState;

    public AttackIngState(StateMachine stateMachine, AIController aIController) 
        : base(stateMachine, aIController)
    {
        
    }

    public void StateInit(AttackDelayState attackDelayState, AttackEndState attackEndState)
    {
        this.attackDelayState = attackDelayState;
        this.attackEndState = attackEndState;
    }

    public override void Enter()
    {
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
}
