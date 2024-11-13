using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface IBTNode
{
    public enum BTNodeState
    {
        Success,
        Failure,
        Running,
    }

    public IBTNode.BTNodeState Execute();
}
