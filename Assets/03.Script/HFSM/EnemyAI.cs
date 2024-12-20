public class EnemyAI : AIController
{
    private void Awake()
    {
        // �ӽ� ���� ����
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
