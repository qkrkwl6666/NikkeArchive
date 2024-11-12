using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NikkeStats
{
    public int Hp {  get; private set; } // ü��
    public int MaxHp {  get; private set; } // �ִ� ü��
    public int Defence { get; private set; } // ����
    public int Attack { get; private set; } // ���ݷ�
    public BustType BustType { get; set; } // ����Ʈ 
    public CodeChip Category { get; set; } // �Ӽ�
    public Weapon Weapon { get; set; } // ����

    // �� ����
    public float AttackTime {  get; private set; } // �ѹ� ��� �ð� �ִϸ��̼� ����
    public float ReloadTime { get; private set; } // ������ �ð� �ִϸ��̼� ����
    public float MoveSpeed { get; private set; }
    public int MaxAmmo { get; private set; } // �ִ� ź��
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
