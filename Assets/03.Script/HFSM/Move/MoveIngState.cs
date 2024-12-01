using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveIngState : State, IObserver
{
    private StateSubject stateSubject;

    // MainState
    private AttackState attackState;
    private MoveState moveState;

    // SubState
    private MoveEndState moveEndState;

    private float time = 0f;
    private float enemyDetectTime = 0.1f;

    public MoveIngState(StateMachine stateMachine, AIController aIController, 
        StateSubject stateSubject) : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);
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
                stateMachine.ChangeState(moveEndState);
                return;
            }

            time = 0f;
        }
    }


    public void ObserverUpdate()
    {
        attackState = stateSubject.AttackState;
        moveState = stateSubject.MoveState;
        moveEndState = stateSubject.MoveEndState;
    }
}
