using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveState : State, IObserver
{
    private StateSubject stateSubject;

    public StateMachine SubStateMachine { get; private set; }

    // Move State
    public MoveIngState MoveIngState { get; private set; }
    public MoveEndState MoveEndState { get; private set; }

    // Attack State
    private AttackState attackState;

    public MoveState(StateMachine stateMachine, AIController aIController, StateSubject stateSubject) 
        : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);

        SubStateMachine = new StateMachine();

        MoveIngState = new MoveIngState(stateMachine, aIController, stateSubject);
        MoveEndState = new MoveEndState(stateMachine, aIController, stateSubject);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.MOVE_ING);

        // TODO : COVER 감지 후 있으면 COVER 없으면 Front
        SubStateMachine.Initialize(MoveIngState);
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

    public void ObserverUpdate()
    {
        attackState = stateSubject.AttackState;
        MoveIngState = stateSubject.MoveIngState;
    }

    #region 애니메이션 이벤트

    public void AnimationMoveEndEvent()
    {
        MoveEndState.AnimationEventMoveEnd();
    }

    #endregion
}
