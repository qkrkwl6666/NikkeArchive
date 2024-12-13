public class InGameNikkeStats
{
    public float Hp { get; set; } // ü��
    public float MaxHp { get; set; } // �ִ� ü��
    public int Defence { get; set; } // ����
    public float Attack { get; set; } // ���ݷ�
    public float AttackRange { get; set; } // ���� ��Ÿ�
    public int CurrentAmmo { get; set; }  
    public int MaxAmmo { get; set; }
    public int AttackCount { get; set; }
    public float MoveSpeed { get; set; }

    public void InitData(NikkeStats nikkeStats)
    {
        this.Hp = nikkeStats.Hp;
        this.MaxHp = nikkeStats.MaxHp;
        this.Defence = nikkeStats.Defence;
        this.Attack = nikkeStats.Attack;
        this.AttackRange = nikkeStats.AttackRange;
        this.CurrentAmmo = nikkeStats.CurrentAmmo;
        this.MaxAmmo = nikkeStats.MaxAmmo;
        this.AttackCount = nikkeStats.AttackCount;
        this.MoveSpeed = nikkeStats.MoveSpeed;
    }


}
