public class MoveState : MainState, IObserver
{
    private StateSubject stateSubject;

    // Move State
    public MovingState MovingState { get; private set; }
    public MoveEndState MoveEndState { get; private set; }
    public MoveCoverState MoveCoverState { get; private set; }
    public MoveJumpState MoveJumpState { get; private set; }

    // Attack State
    private AttackState attackState;

    public MoveState(MainStateMachine mainStateMachine, AIController aIController,
        StateSubject stateSubject) : base(mainStateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);

        MovingState = new MovingState(SubStateMachine, aIController, stateSubject);
        MoveEndState = new MoveEndState(SubStateMachine, aIController, stateSubject);
        MoveCoverState = new MoveCoverState(SubStateMachine, aIController, stateSubject);
        MoveJumpState = new MoveJumpState(SubStateMachine, aIController, stateSubject);
    }

    public override void Enter()
    {



    }
        
    public override void Exit()
    {
        SubStateMachine.CurrentStateExit();
    }

    public override void Update()
    {
        SubStateMachine.Update();


    }

    public void ObserverUpdate()
    {
        attackState = stateSubject.AttackState;
        MovingState = stateSubject.MovingState;
    }

    #region 애니메이션 이벤트

    public void AnimationMoveEndEvent()
    {
        MoveEndState.AnimationMoveEndEvent();
    }

    public void AnimationMoveJumpEvent()
    {
        MoveJumpState.AnimationMoveJumpEvent();
    }

    #endregion
}
