using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SequenceNode : IBTNode
{
    private List<IBTNode> children;

    public SequenceNode(List<IBTNode> children)
    {
        this.children = children;
    }

    public IBTNode.BTNodeState Execute()
    {
        if (children == null || children.Count == 0) 
            return IBTNode.BTNodeState.Failure;

        foreach (var node in children) 
        {
            switch(node.Execute())
            {
                case IBTNode.BTNodeState.Success:
                    continue;

                case IBTNode.BTNodeState.Running:
                    return IBTNode.BTNodeState.Running;

                case IBTNode.BTNodeState.Failure:
                    return IBTNode.BTNodeState.Failure;
            }
        }

        return IBTNode.BTNodeState.Success;
    }
}
