using UnityEngine;

public class BehaviorTree : MonoBehaviour
{
    private IBTNode root;

    public BehaviorTree(IBTNode root)
    {
        this.root = root;
    }

    public void Operate()
    {
        root.Execute();
    }
}
