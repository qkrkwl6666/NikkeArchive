public class MoveState : MainState, IObserver
{
    private StateSubject stateSubject;

    public SubStateMachine SubStateMachine { get; private set; }

    // Move State
    public MovingState MovingState { get; private set; }
    public MoveEndState MoveEndState { get; private set; }
    public MoveCoverState MoveCoverState { get; private set; }

    // Attack State
    private AttackState attackState;

    public MoveState(MainStateMachine mainStateMachine, AIController aIController,
        StateSubject stateSubject) : base(mainStateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);

        SubStateMachine = new SubStateMachine();

        MovingState = new MovingState(SubStateMachine, aIController, stateSubject);
        MoveEndState = new MoveEndState(SubStateMachine, aIController, stateSubject);
        MoveCoverState = new MoveCoverState(SubStateMachine, aIController, stateSubject);
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.MOVE_ING);

        if(controller.CoverObject == null)
        {
            SubStateMachine.Initialize(MovingState);
        }
        else
        {
            SubStateMachine.Initialize(MoveCoverState);
        }  
    }
        
    public override void Exit()
    {
        SubStateMachine.CurrentStateExit();
    }

    public override void Execute()
    {
        SubStateMachine.Update();


    }
    public void ChangeMainState(MainState mainState)
    {
        mainStateMachine.ChangeState(mainState);
    }

    public void ObserverUpdate()
    {
        attackState = stateSubject.AttackState;
        MovingState = stateSubject.MovingState;
    }

    #region �ִϸ��̼� �̺�Ʈ

    public void AnimationMoveEndEvent()
    {
        MoveEndState.AnimationEventMoveEnd();
    }

    #endregion
}
