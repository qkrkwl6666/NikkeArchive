public class MoveState : State, IObserver
{
    private StateSubject stateSubject;

    public StateMachine SubStateMachine { get; private set; }

    // Move State
    public MovingState MovingState { get; private set; }
    public MoveEndState MoveEndState { get; private set; }
    public MoveCoverState MoveCoverState { get; private set; }

    // Attack State
    private AttackState attackState;

    public MoveState(StateMachine stateMachine, AIController aIController, StateSubject stateSubject)
        : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);

        SubStateMachine = new StateMachine();

        MovingState = new MovingState(stateMachine, aIController, stateSubject);
        MoveEndState = new MoveEndState(stateMachine, aIController, stateSubject);
        MoveCoverState = new MoveCoverState(stateMachine, aIController, stateSubject);
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
    public void ChangeMainState(State state)
    {
        stateMachine.ChangeState(state);
    }

    public void ObserverUpdate()
    {
        attackState = stateSubject.AttackState;
        MovingState = stateSubject.MovingState;
    }

    #region 애니메이션 이벤트

    public void AnimationMoveEndEvent()
    {
        MoveEndState.AnimationEventMoveEnd();
    }

    #endregion
}
