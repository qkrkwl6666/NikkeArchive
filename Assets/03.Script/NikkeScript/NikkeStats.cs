using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NikkeStats
{
    public int Hp {  get; private set; } // 체력
    public int MaxHp {  get; private set; } // 최대 체력
    public int Defence { get; private set; } // 방어력
    public float Attack { get; private set; } // 공격력
    public BustType BustType { get; set; } // 버스트 
    public CodeChip Category { get; set; } // 속성
    public Weapon Weapon { get; set; } // 무기

    // 상세 스텟
    public float AttackSpeed { get; private set; } = 1.0f; // 총알 애니메이션 연동 배속
    public float RotateSpeed { get; private set; } = 0.4f;
    public float DelayTime {  get; private set; } // shot 후 다음 shot 대기 시간
    public float ReloadTime { get; private set; } // 재장전 시간 애니메이션 연동
    public float MoveSpeed { get; private set; } // 이동 속도
    public int MaxAmmo { get; private set; } // 최대 탄약
    public int CurrentAmmo { get; private set; } // 현재 탄약
    public float AttackRange { get; private set; } // 공격 사거리
    public int AttackCount { get; private set; } // 공격 횟수
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
