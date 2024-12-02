using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IdleState : State, IObserver
{
    private StateSubject stateSubject; 
    private StateMachine mainStateMachine; // Main

    private AttackState attackState;
    private MoveState moveState;

    private float time;
    private float idleDuration = 2f;

    public IdleState(StateMachine stateMachine, AIController aIController, 
        StateSubject stateSubject) : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;

        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        if (controller.EnemyDetection())
        {
            mainStateMachine.ChangeState(attackState);
        }

        controller.AnimationPlay(AnimationStrings.IDLE);
        time = 0f;
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        time += Time.deltaTime;
        
        // �ӽ÷� ���� �ð� ������ moveState �̵�
        // ���߿��� ��Ʋ �Ŵ����� ���� ��Ű��
        if (time >= idleDuration) 
        {
            // MoveState �̵�
            mainStateMachine.ChangeState(moveState);
        }
    }

    public void ObserverUpdate()
    {
        moveState = stateSubject.MoveState;
        mainStateMachine = stateSubject.MainStateMachine;
        attackState = stateSubject.AttackState;
    }
}
