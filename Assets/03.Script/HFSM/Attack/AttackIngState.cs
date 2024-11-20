using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackIngState : State
{
    private AttackDelayState attackDelayState;

    public AttackIngState(StateMachine stateMachine, AIController aIController
        , AttackDelayState attackDelayState, AttackEndState attackEndState) 
        : base(stateMachine, aIController)
    {
        this.attackDelayState = attackDelayState;   
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.ATTACK_DELAY);


    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;

        if(controller.TargetEnemy == null || controller.EnemyDetection())
        {
            stateMachine.ChangeState(attackDelayState);
        }

        controller.RotateEnemy();
    }

    public void AnimationEventAttackIngEnd()
    {
        stateMachine.ChangeState(attackDelayState);
    }
}
