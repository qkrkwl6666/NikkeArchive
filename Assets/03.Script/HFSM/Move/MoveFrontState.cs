using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveFrontState : State
{
    private AttackState attackState;
    private MoveState moveState;

    private float time = 0f;
    private float enemyDetectTime = 0.1f;

    public MoveFrontState(StateMachine stateMachine, AIController aIController) : base(stateMachine, aIController)
    {

    }

    public void StateInit(AttackState attackState, MoveState moveState)
    {
        this.attackState = attackState;
        this.moveState = moveState;
    }

    public override void Enter()
    {
        time = 0f;
    }

    public override void Exit()
    {
        time = 0f;
    }

    public override void Execute()
    {
        controller.MoveFront();

        time += Time.deltaTime;

        if (time >= enemyDetectTime)
        {

            if (controller.EnemyDetection())
            {
                moveState.ChangeMainState(attackState);
                return;
            }

            time = 0f;
        }
    }
}
