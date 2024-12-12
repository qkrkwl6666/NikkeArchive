using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class MoveJumpState : SubState, IObserver
{
    private StateSubject stateSubject;

    private MainStateMachine mainStateMachine;

    private MovingState movingState;
    private AttackState attackState;

    private float jumpSpeed = 2f; 
    
    public MoveJumpState(SubStateMachine subStateMachine, AIController aIController,
        StateSubject stateSubject) : base(subStateMachine, aIController)
    {
        this.stateSubject = stateSubject;

        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.NavMeshAgent.enabled = false;
        controller.AnimationPlay(AnimationStrings.MOVE_JUMP);

    }
    public override void Exit()
    {
        controller.NavMeshAgent.enabled = true;
    }
    public override void Execute()
    {
        // 점프 임시 움직이기
        controller.transform.Translate(jumpSpeed * Time.deltaTime * Vector3.forward);
    }

    public void AnimationMoveJumpEvent()
    {
        subStateMachine.ChangeState(movingState);
    }

    public void ObserverUpdate()
    {
        mainStateMachine = stateSubject.MainStateMachine;
        movingState = stateSubject.MovingState;
        attackState = stateSubject.AttackState;
    }
}
