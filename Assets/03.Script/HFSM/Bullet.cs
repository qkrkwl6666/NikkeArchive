using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bullet : MonoBehaviour
{
    private AIController controller; // 타겟 

    private float targetDistance = 0.3f;
    private float damage = 10;
    private float yPos = 1f;
    private float moveSpeed = 20f;
    private float rotateSpeed = 20f;
    Vector3 dir = Vector3.zero;

    public void Init(Vector3 initPos, AIController controller)
    {
        transform.position = initPos;
        this.controller = controller;

        TargetPosReferesh();
    }

    private void Update()
    {

    }

    private void FixedUpdate()
    {
        // 임시 테스트용 파괴 나중에는 오브젝트 풀 
        if (controller == null)
        {
            Destroy(gameObject);
            return;
        }


        TargetPosReferesh();

        //transform.Translate(moveSpeed * Time.deltaTime * transform.forward);



        float distance = Vector3.Distance(controller.transform.position, transform.position);

        if (distance <= targetDistance)
        {
            controller.TakeDamage(damage);
            Destroy(gameObject);
            return;
        }
    }

    public void TargetPosReferesh()
    {
        dir = controller.transform.position - transform.position;
        dir.Normalize();
        transform.forward = dir;
        transform.position += moveSpeed * Time.deltaTime * transform.forward;
    }
}
