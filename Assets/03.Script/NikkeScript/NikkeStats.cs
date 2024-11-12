using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NikkeStats
{
    public int Hp {  get; private set; } // 체력
    public int MaxHp {  get; private set; } // 최대 체력
    public int Defence { get; private set; } // 방어력
    public int Attack { get; private set; } // 공격력
    public BustType BustType { get; set; } // 버스트 
    public CodeChip Category { get; set; } // 속성
    public Weapon Weapon { get; set; } // 무기

    // 상세 스텟
    public float AttackTime {  get; private set; } // 한발 쏘는 시간 애니메이션 연동
    public float ReloadTime { get; private set; } // 재장전 시간 애니메이션 연동
    public float MoveSpeed { get; private set; }
    public int MaxAmmo { get; private set; } // 최대 탄약
}

public enum BustType
{
    BUST_1 = 0,
    BUST_2 = 1,
    BUST_3 = 2,

    COUNT,
}
public enum CodeChip
{
    FIRE = 0,     // 작열
    WIND = 1,     // 풍압
    IRON = 2,     // 철갑
    ELECTRIC = 3, // 전격
    WATER = 4,    // 수냉

    COUNT,    
}

public enum Weapon
{
    AR = 0,
    SMG = 1,
    SG = 2,
    SR = 3,
    RL = 4,
    MG = 5,

    COUNT,
}
