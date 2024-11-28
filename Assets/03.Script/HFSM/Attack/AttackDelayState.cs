using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackDelayState : State
{
    private AttackEndState attackEndState;
    private AttackIngState attackIngState;

    public bool IsReloading { get; private set; } = false;

    private float time = 0f;

    public AttackDelayState(StateMachine stateMachine, AIController aIController) 
        : base(stateMachine, aIController)
    {

    }

    public void StateInit(AttackEndState attackEndState, AttackIngState attackIngState)
    {
        this.attackEndState = attackEndState;
        this.attackIngState = attackIngState;
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

        if (time >= controller.NikkeStats.DelayTime && controller.TargetEnemy != null)
        {
            stateMachine.ChangeState(attackIngState);
        }
    }
}
