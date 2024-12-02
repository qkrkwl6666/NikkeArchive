using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class MoveEndState : State, IObserver
{
    private StateSubject stateSubject;
    
    private AttackState attackState; 
    private MoveState moveState; 

    private MoveIngState moveIngState; 

    public MoveEndState(StateMachine stateMachine, AIController aIController, StateSubject stateSubject) : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;

        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.MOVE_END);
        controller.SubState = Sub_State.MOVE_END;
    }

    public override void Exit()
    {
        
    }

    public override void Execute()
    {

    }

    public void ObserverUpdate()
    {
        attackState = stateSubject.AttackState;
        moveState = stateSubject.MoveState;
        moveIngState = stateSubject.MoveIngState;
    }

    public void AnimationEventMoveEnd()
    {
        moveState.ChangeMainState(attackState);
    }
}
