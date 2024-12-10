public class MainStateMachine
{
    public MainState CurrentState { get; private set; }

    public void Initialize(MainState state)
    {
        CurrentState = state;
        CurrentState?.Enter();
    }
    public void ChangeState(MainState state)
    {
        CurrentState?.Exit();
        CurrentState = state;
        CurrentState?.Enter();
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
