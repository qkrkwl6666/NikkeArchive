public class MainStateMachine
{
    public MainState CurrentState { get; private set; }

    public void Initialize(MainState mainState, SubState subState)
    {
        CurrentState = mainState;
        CurrentState?.Enter();

        CurrentState?.SubStateMachine.Initialize(subState);
    }
    public void ChangeState(MainState mainState, SubState subState = null)
    {

        CurrentState?.Exit();
        CurrentState = mainState;
        CurrentState?.Enter();

        if(subState != null) 
            mainState?.SubStateMachine?.ChangeState(subState);
    }

    public void CurrentStateExit()
    {
        CurrentState?.Exit();
    }

    public void Update()
    {
        if (CurrentState == null) return;

        CurrentState?.Execute();
    }
}
