public class EnemyAI : AIController
{
    private void Awake()
    {
        // 임시 니케 스텟
        NikkeStats stats = new NikkeStats();
        stats.Hp = 1000;
        stats.MaxHp = 1000;

        SetNikkeData(stats);
    }

    protected override void Start()
    {

        hpBar = GetComponentInChildren<HpBar>();
    }
}
