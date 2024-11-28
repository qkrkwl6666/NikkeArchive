using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackStartState : State
{
    private AttackIngState attackIngState;
    private AttackDelayState attackdelayState;

    public AttackStartState(StateMachine stateMachine, AIController aIController) 
        : base(stateMachine, aIController)
    {

    }

    public void StateInit(AttackIngState attackIngState, AttackDelayState attackdelayState)
    {
        this.attackIngState = attackIngState;
        this.attackdelayState = attackdelayState;
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
            stateMachine.ChangeState(attackdelayState);
            return;
        }
        stateMachine.ChangeState(attackIngState);
    }

}
