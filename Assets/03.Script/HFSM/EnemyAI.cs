public class EnemyAI : AIController
{
    private void Awake()
    {
        // �ӽ� ���� ����
        NikkeStats stats = new NikkeStats();
        stats.Hp = 100;
        stats.MaxHp = 100;

        SetNikkeData(stats);
    }

    protected override void Start()
    {
        
        
    }
}
