using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveState : State
{
    public StateMachine SubStateMachine { get; private set; }

    private AttackState attackState;

    private float time = 0f;
    private float enemyDetectTime = 0.1f;

    public MoveState(StateMachine stateMachine, StateMachine subStateMachine, AIController aIController,
        AttackState attackState) : base(stateMachine, aIController)
    {
        this.SubStateMachine = subStateMachine;
        this.attackState = attackState;
    }

    public override void Enter()
    {
        time = 0f;
        controller.AnimationPlay(AnimationStrings.MOVE_ING);
    }

    public override void Exit()
    {
        time = 0f;
    }

    public override void Execute()
    {
        controller.MoveFront();

        time += Time.deltaTime;

        if(time >= enemyDetectTime)
        {
            if(controller.EnemyDetection())
            {
                stateMachine.ChangeState(attackState);
            }

            time = 0f;
        }
    }
}
