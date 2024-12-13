public class MainState : IState
{
    protected MainStateMachine mainStateMachine;
    protected AIController controller;
    public SubStateMachine SubStateMachine { get; private set; }

    protected MainState(MainStateMachine mainStateMachine, AIController aIController)
    {
        this.mainStateMachine = mainStateMachine;
        this.controller = aIController;
        SubStateMachine = new SubStateMachine();
    }

    public MainStateMachine GetStateMachine()
    {
        return mainStateMachine;
    }

    public virtual void Enter() { }

    public virtual void Update() { }
    public virtual void FixedUpdate() { }

    public virtual void Exit() { }
}
