using UnityEngine;

public class AttackAnimationTest : MonoBehaviour
{
    private int MaxAmmo;
    private int currentAmmo;
    private int attackAmmo;

    private float attackSpeed; // 공격 속도 애니메이션 연동

    public AttackAnimationTest()
    {
        MaxAmmo = 10;
        currentAmmo = MaxAmmo;
        attackAmmo = 1;
    }

    public void Attack()
    {

    }
}
