using System.Collections.Generic;

public class SelectorNode : IBTNode
{
    private List<IBTNode> children;

    public SelectorNode(List<IBTNode> children)
    {
        this.children = children;
    }

    public IBTNode.BTNodeState Execute()
    {
        if (children == null || children.Count == 0)
            return IBTNode.BTNodeState.Failure;

        foreach (var node in children)
        {
            switch (node.Execute())
            {
                case IBTNode.BTNodeState.Success:
                    return IBTNode.BTNodeState.Success;

                case IBTNode.BTNodeState.Running:
                    return IBTNode.BTNodeState.Running;
            }
        }

        return IBTNode.BTNodeState.Failure;
    }
}
