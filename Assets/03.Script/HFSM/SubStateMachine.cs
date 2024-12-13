public class SubStateMachine
{
    public SubState CurrentState { get; private set; }

    public void Initialize(SubState state)
    {
        CurrentState = state;
        CurrentState?.Enter();
    }
    public void ChangeState(SubState state)
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

        CurrentState?.Update();
    }

    public void FixedUpdate()
    {
        if (CurrentState == null) return;

        CurrentState?.FixedUpdate();
    }
}
