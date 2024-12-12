using UnityEngine;

public class CoverObject : MonoBehaviour
{
    [field: SerializeField]
    public Transform CoverPoint { get; private set; }

    public bool IsEmpty { get; private set; } = true;

    public CoverType coverType = CoverType.Stand;

    private AIController controller;

    public bool UseCover(AIController controller) 
    {
        if (!IsEmpty) return false;

        this.controller = controller;
        IsEmpty = false;

        return true;
    }

    public void UnCover()
    {
        IsEmpty = true;
        controller = null;
    }

    public void CoverDestory()
    {
        // controller.CoverObject = null
        // controller 애니메이션 Normal 로 변경
        if(controller != null)
            controller.CoverDestory();
        Destroy(gameObject); // 임시로 파괴
    }    


}

public enum CoverType
{
    Stand,
    Kneel,
}
