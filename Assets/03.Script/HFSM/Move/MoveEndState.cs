public class MoveEndState : SubState, IObserver
{
    private StateSubject stateSubject;

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
        movingState = stateSubject.MovingState;
    }

    public void AnimationEventMoveEnd()
    {
        moveState.ChangeMainState(attackState);
    }
}
