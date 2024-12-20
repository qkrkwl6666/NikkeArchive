using UnityEngine;

public class Bullet : MonoBehaviour
{
    private float targetDistance = 0.3f;
    private float damage = 10;
    private float yPos = 1f;
    private float moveSpeed = 20f;
    private float rotateSpeed = 20f;

    private float time = 0f;
    private float destoryTime = 5f;

    Vector3 dir = Vector3.zero;

    public void Init(Vector3 initPos, Vector3 targetDir , float damage)
    {
        transform.position = initPos;
        dir = targetDir;
        this.damage = damage;

        TargetPosReferesh();
    }

    private void Update()
    {
        time += Time.deltaTime;

        if(time >= destoryTime)
        {
            Destroy(gameObject);
        }
    }

    private void FixedUpdate()
    {
        TargetPosReferesh();
        // �ӽ� �׽�Ʈ�� �ı� ���߿��� ������Ʈ Ǯ 
        //if (controller == null)
        //{
        //    Destroy(gameObject);
        //    return;
        //}


        //TargetPosReferesh();

        //transform.Translate(moveSpeed * Time.deltaTime * transform.forward);



        //float distance = Vector3.Distance(controller.transform.position, transform.position);

        //if (distance <= targetDistance)
        //{
        //    controller.TakeDamage(damage);
        //    Destroy(gameObject);
        //    return;
        //}
    }

    public void TargetPosReferesh()
    {
        transform.forward = dir;
        transform.position += moveSpeed * Time.deltaTime * transform.forward;
    }

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log(other.gameObject.name);
        if(other.gameObject.CompareTag("Enemy"))
        {
            other.GetComponent<AIController>().TakeDamage(damage);
            Destroy(gameObject);
        }
    }
}
