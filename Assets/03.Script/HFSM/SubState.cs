public class SubState : IState
{
    protected SubStateMachine subStateMachine;
    protected AIController controller;
    protected SubState(SubStateMachine subStateMachine, AIController aIController)
    {
        this.subStateMachine = subStateMachine;
        this.controller = aIController;
    }

    public virtual void Enter() { }
    public virtual void Execute() { }
    public virtual void Exit() { }
}
