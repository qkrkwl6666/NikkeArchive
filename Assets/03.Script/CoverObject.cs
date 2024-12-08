using UnityEngine;

public class CoverObject : MonoBehaviour
{
    [field: SerializeField]
    public Transform CoverPoint { get; private set; }

    public bool IsEmpty { get; private set; } = true;

    public CoverType CoverType { get; private set; } = CoverType.Kneel;

    public bool UseCover() 
    {
        if (!IsEmpty) return false;

        IsEmpty = false;

        return true;
    }

    public void UnCover()
    {
        IsEmpty = true;
    }


}

public enum CoverType
{
    Stand,
    Kneel,
}
