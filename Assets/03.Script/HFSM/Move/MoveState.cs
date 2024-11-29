using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveState : State
{
    public StateMachine SubStateMachine { get; private set; }

    // Move State
    private MoveFrontState moveFrontState;

    // Attack State
    private AttackState attackState;

    public MoveState(StateMachine stateMachine, AIController aIController) 
        : base(stateMachine, aIController)
    {
        SubStateMachine = new StateMachine();

        moveFrontState = new MoveFrontState(stateMachine, aIController);
    }

    public void StateInit(AttackState attackState)
    {
        this.attackState = attackState;

        // TODO : ���� ���� ATTACK -> MOVE
        moveFrontState.StateInit(attackState, this);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.MOVE_ING);

        // TODO : COVER ���¿� ���� COVER �̵�
        SubStateMachine.Initialize(moveFrontState);
    }

    public override void Exit()
    {
        
    }

    public override void Execute()
    {
        SubStateMachine.Update();


    }
    public void ChangeMainState(State state)
    {
        stateMachine.ChangeState(state);
    }
}
