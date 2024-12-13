public class InGameNikkeStats
{
    public float Hp { get; set; } // 체력
    public float MaxHp { get; set; } // 최대 체력
    public int Defence { get; set; } // 방어력
    public float Attack { get; set; } // 공격력
    public float AttackRange { get; set; } // 공격 사거리
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
