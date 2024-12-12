using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyAI : AIController
{
    private void Awake()
    {
        // 임시 니케 스텟
        NikkeStats stats = new NikkeStats();
        stats.Hp = 100;
        stats.MaxHp = 100;

        SetNikkeData(stats);
    }

    protected override void Start()
    {
        
        
    }
}
