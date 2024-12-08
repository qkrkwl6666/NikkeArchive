using UnityEditor;

public class AttackEndState : State, IObserver
{
    private StateSubject stateSubject;

    private StateMachine mainStateMachine;

    private MoveState moveState;
    private IdleState idleState;

    public AttackEndState(StateMachine stateMachine, AIController aIController,
        StateSubject stateSubject) : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;

        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.ATTACK_END);
        controller.SubState = Sub_State.ATTACK_END;
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;


    }
    public void AnimationAttackEndEvent()
    {
        // Move ���� �̵�
        mainStateMachine.ChangeState(moveState);
    }

    public void ObserverUpdate()
    {
        moveState = stateSubject.MoveState;
        idleState = stateSubject.IdleState;
        mainStateMachine = stateSubject.MainStateMachine;
    }
}
