public class MoveEndState : SubState, IObserver
{
    private StateSubject stateSubject;
    
    private MainStateMachine mainStateMachine;

    private AttackState attackState;
    private MoveState moveState;

    private MovingState movingState;

    public MoveEndState(SubStateMachine subStateMachine, AIController aIController
        , StateSubject stateSubject) : base(subStateMachine, aIController)
    {
        this.stateSubject = stateSubject;

        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.SetRigDefault();
        controller.AnimationPlay(AnimationStrings.MOVE_END);
        controller.SubState = Sub_State.MOVE_END;
    }

    public override void Exit()
    {

    }

    public override void Update()
    {

    }

    public void ObserverUpdate()
    {
        attackState = stateSubject.AttackState;
        moveState = stateSubject.MoveState;
        movingState = stateSubject.MovingState;
        mainStateMachine = stateSubject.MainStateMachine;
    }

    public void AnimationMoveEndEvent()
    {
        mainStateMachine.ChangeState(attackState);
    }
}
