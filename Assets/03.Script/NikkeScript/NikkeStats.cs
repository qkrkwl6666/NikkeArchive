using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NikkeStats
{
    public int Hp {  get; private set; } // ü��
    public int MaxHp {  get; private set; } // �ִ� ü��
    public int Defence { get; private set; } // ����
    public float Attack { get; private set; } // ���ݷ�
    public BustType BustType { get; set; } // ����Ʈ 
    public CodeChip Category { get; set; } // �Ӽ�
    public Weapon Weapon { get; set; } // ����

    // �� ����
    public float AttackSpeed { get; private set; } = 1.0f; // �Ѿ� �ִϸ��̼� ���� ���
    public float RotateSpeed { get; private set; } = 0.4f;
    public float DelayTime {  get; private set; } // shot �� ���� shot ��� �ð�
    public float ReloadTime { get; private set; } // ������ �ð� �ִϸ��̼� ����
    public float MoveSpeed { get; private set; } // �̵� �ӵ�
    public int MaxAmmo { get; private set; } // �ִ� ź��
    public int CurrentAmmo { get; private set; } // ���� ź��
    public float AttackRange { get; private set; } // ���� ��Ÿ�
    public int AttackCount { get; private set; } // ���� Ƚ��
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
    FIRE = 0,     // �ۿ�
    WIND = 1,     // ǳ��
    IRON = 2,     // ö��
    ELECTRIC = 3, // ����
    WATER = 4,    // ����

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
