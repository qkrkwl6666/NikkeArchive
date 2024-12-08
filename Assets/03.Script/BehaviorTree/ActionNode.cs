using System;

public sealed class ActionNode : IBTNode
{
    private Func<IBTNode.BTNodeState> action = null;

    public ActionNode(Func<IBTNode.BTNodeState> action)
    {
        this.action = action;
    }

    public IBTNode.BTNodeState Execute()
    {
        return action?.Invoke() ?? IBTNode.BTNodeState.Failure;
    }
}
