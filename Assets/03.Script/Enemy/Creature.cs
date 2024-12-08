using UnityEngine;

public class Creature : MonoBehaviour
{
    public float Hp { get; private set; }


    public void TakeDamage(float damage)
    {
        Hp -= damage;

        if (Hp < 0)
        {
            Destroy(gameObject);
        }
    }
}
