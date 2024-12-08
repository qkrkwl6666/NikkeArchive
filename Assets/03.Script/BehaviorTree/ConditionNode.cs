using System;

public class ConditionNode : IBTNode
{
    private Func<bool> condition;

    public ConditionNode(Func<bool> condition)
    {
        this.condition = condition;
    }

    public IBTNode.BTNodeState Execute()
    {
        return condition() ? IBTNode.BTNodeState.Success : IBTNode.BTNodeState.Failure;
    }
}
