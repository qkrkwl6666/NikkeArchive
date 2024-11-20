using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackStartState : State
{
    private AttackIngState attackIngState;

    public AttackStartState(StateMachine stateMachine, AIController aIController, 
        AttackIngState attackIngState) 
        : base(stateMachine, aIController)
    {
        this.attackIngState = attackIngState;
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.ATTACK_START);
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;


    }

    public void AnimationEventAttackStartEnd()
    {
        // enemy null
        if (controller.TargetEnemy == null || !controller.EnemyDetection())
        {
            // Todo : Delay 상태 이동
            return;
        }
        stateMachine.ChangeState(attackIngState);
    }

}
