using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackStartState : State
{
    private AttackIngState attackIngState;

    public AttackStartState(StateMachine stateMachine, AttackIngState attackIngState, AIController aIController) 
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

        if (controller.TargetEnemy == null)
        {
            controller.EnemyDetection();
        }
    }

    public void AnimationEventAttackStartEnd()
    {
        stateMachine.ChangeState(attackIngState);
    }

}
