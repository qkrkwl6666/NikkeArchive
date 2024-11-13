using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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
