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
