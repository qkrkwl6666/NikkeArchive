public class StateMachine
{
    public State CurrentState { get; private set; }


    public void Initialize(State state)
    {
        CurrentState = state;
        CurrentState?.Enter();
    }
    public void ChangeState(State state)
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
