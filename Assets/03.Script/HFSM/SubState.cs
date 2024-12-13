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
    public virtual void Update() { }
    public virtual void FixedUpdate() { }
    public virtual void Exit() { }
}
