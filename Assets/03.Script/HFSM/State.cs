public abstract class State : IState
{
    protected StateMachine stateMachine;
    protected AIController controller;

    protected State(StateMachine stateMachine, AIController aIController)
    {
        this.stateMachine = stateMachine;
        this.controller = aIController;
    }

    public StateMachine GetStateMachine()
    {
        return stateMachine;
    }

    public virtual void Enter() { }
    public virtual void Execute() { }
    public virtual void Exit() { }
}
