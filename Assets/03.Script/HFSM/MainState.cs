public class MainState : IState
{
    protected MainStateMachine mainStateMachine;
    protected AIController controller;

    protected MainState(MainStateMachine mainStateMachine, AIController aIController)
    {
        this.mainStateMachine = mainStateMachine;
        this.controller = aIController;
    }

    public MainStateMachine GetStateMachine()
    {
        return mainStateMachine;
    }

    public virtual void Enter() { }

    public virtual void Execute() { }

    public virtual void Exit() { }
}
