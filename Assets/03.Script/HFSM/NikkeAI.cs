using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NikkeAI : AIController
{

    private AttackState attackState;

    protected override void Start()
    {
        base.Start();


    }

    public override void MoveFront()
    {
        // TODO : ���߿� ����Ž� �����ؼ� ���� �� ������ 

        transform.Translate(Vector3.right * NikkeStats.MoveSpeed * Time.deltaTime);
    }

}
