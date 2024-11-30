using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveState : State, IObserver
{
    private StateSubject stateSubject;

    public StateMachine SubStateMachine { get; private set; }

    // Move State
    public MoveFrontState MoveFrontState { get; private set; }

    // Attack State
    private AttackState attackState;

    public MoveState(StateMachine stateMachine, AIController aIController, StateSubject stateSubject) 
        : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);

        SubStateMachine = new StateMachine();

        MoveFrontState = new MoveFrontState(stateMachine, aIController, stateSubject);
    }

    //public void StateInit(AttackState attackState)
    //{
    //    this.attackState = attackState;

    //    // TODO : 순서 주의 ATTACK -> MOVE
    //    MoveFrontState.StateInit(attackState, this);
    //}

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.MOVE_ING);

        // TODO : COVER 감지 후 있으면 COVER 없으면 Front
        SubStateMachine.Initialize(MoveFrontState);
    }

    public override void Exit()
    {
        SubStateMachine.CurrentStateExit();
    }

    public override void Execute()
    {
        SubStateMachine.Update();


    }
    public void ChangeMainState(State state)
    {
        stateMachine.ChangeState(state);
    }

    public void Update()
    {
        attackState = stateSubject.AttackState;
        MoveFrontState = stateSubject.MoveFrontState;
    }
}
