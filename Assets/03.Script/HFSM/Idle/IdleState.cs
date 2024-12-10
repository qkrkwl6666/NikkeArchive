using UnityEngine;

public class IdleState : MainState, IObserver
{
    private StateSubject stateSubject;
    //private StateMachine mainStateMachine; // Main

    private AttackState attackState;
    private MoveState moveState;
    private MovingState movingState;

    private float time;
    private float idleDuration = 2f;

    public IdleState(MainStateMachine mainStateMachine, AIController aIController,
        StateSubject stateSubject) : base(mainStateMachine, aIController)
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
            mainStateMachine.ChangeState(moveState, movingState);
        }
    }

    public void ObserverUpdate()
    {
        moveState = stateSubject.MoveState;
        mainStateMachine = stateSubject.MainStateMachine;
        attackState = stateSubject.AttackState;
        movingState = stateSubject.MovingState;
    }
}
