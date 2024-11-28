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
        // TODO : 나중에 내비매쉬 생각해서 뭐가 더 좋은지 

        transform.Translate(Vector3.right * NikkeStats.MoveSpeed * Time.deltaTime);
    }

}
