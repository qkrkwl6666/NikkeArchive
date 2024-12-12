using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public abstract class AIController : MonoBehaviour
{
    public Animator Animator { get; private set; }

    public Animation_State CurrentAnimationState { get; set; } = Animation_State.NORMAL;

    private Dictionary<(string, Animation_State), string> animationCache = new();
    public AIController TargetEnemy { get; private set; }

    public NikkeStats NikkeStats { get; private set; }
    public List<AIController> enemies;
    public List<CoverObject> coverObjects;

    public NavMeshAgent NavMeshAgent { get; private set; }

    public Transform TargetPosition; // 테스트 용도
    public float DetectMargin { get; private set; } = -2f;

    public Sub_State SubState { get; set; }

    public CoverObject CoverObject { get; set; }

    // BattleManager
    private BattleManager battleManager;

    // TEST
    public GameObject shotEffect;
    public Transform muzzlePosition;


    protected virtual void Start()
    {
        Animator = GetComponent<Animator>();
        NavMeshAgent = GetComponent<NavMeshAgent>();
        battleManager = GameObject.FindWithTag("BattleManager").GetComponent<BattleManager>();

        enemies = battleManager.Enemies;
        coverObjects = battleManager.CoverObjects;

        // NavMeshAgent 초기화
        NavMeshAgent.speed = NikkeStats.MoveSpeed;
    }

    public void AnimationPlay(string name)
    {

        if (AnimationStringException(name))
        {
            Animator.SetTrigger(name);
            return;
        }

        if (!animationCache.TryGetValue((name, CurrentAnimationState), out string fullName))
        {
            fullName = $"{name}_{GetAnimationStateString()}";
            animationCache.Add((name, CurrentAnimationState), fullName);
        }

        Animator.SetTrigger(fullName);
    }

    private bool AnimationStringException(string name)
    {
        if (name == AnimationStrings.MOVE_ING || name == AnimationStrings.MOVE_JUMP) return true;

        return false;
    }


    private string GetAnimationStateString()
    {
        switch (CurrentAnimationState)
        {
            case Animation_State.NORMAL:
                return "Normal";
            case Animation_State.STAND:
                return "Stand";
            case Animation_State.KNEEL:
                return "Kneel";
            default:
                return string.Empty;
        }
    }

    public bool EnemyDetection(float detectionMargin = 0f)
    {
        TargetEnemy = null;

        float frevDistance = float.MaxValue;

        foreach (var enemy in enemies)
        {
            if(enemy == null) continue; 

            float distance = Vector3.Distance(enemy.transform.position, transform.position);

            if (distance <= NikkeStats.AttackRange + detectionMargin && distance < frevDistance)
            {
                frevDistance = distance;
                TargetEnemy = enemy;
            }
        }

        if (TargetEnemy == null) return false;

        return true;
    }

    public bool CoverEnemyDetection(Transform pos)
    {
        float frevDistance = float.MaxValue;

        foreach (var enemy in enemies)
        {
            if (enemy == null) continue;

            float distance = Vector3.Distance(enemy.transform.position, pos.position);

            if (distance <= NikkeStats.AttackRange + DetectMargin && distance < frevDistance)
            {
                frevDistance = distance;
                return true;
            }
        }

        return false;
    }

    public bool CoverDetection()
    {
        float frevDistance = float.MaxValue;

        foreach (var cover in coverObjects)
        {
            if (cover == null || !cover.IsEmpty) continue;

            float distance = Vector3.Distance(cover.transform.position, transform.position);
            if (distance <= NikkeStats.CoverRange && distance < frevDistance 
                && CoverEnemyDetection(cover.transform))
            {
                frevDistance = distance;
                CoverObject = cover;
            }
        }
        
        if(CoverObject == null) return false;

        CoverObject.UseCover(this);

        return true;
    }

    public void RotateEnemy()
    {
        if (TargetEnemy == null) return;

        // 적 방향으로 회전
        Vector3 enemyDir = (TargetEnemy.transform.position - transform.position);
        enemyDir.y = 0;
        enemyDir.Normalize();

        transform.rotation =
            Quaternion.Slerp(transform.rotation,
            Quaternion.LookRotation(enemyDir), NikkeStats.RotateSpeed
            * Time.deltaTime);
    }

    public void RotateFornt()
    {
        // 정면으로 회전
        Vector3 forntDir = Vector3.forward;

        forntDir.Normalize();

        transform.rotation =
            Quaternion.Slerp(transform.rotation,
            Quaternion.LookRotation(forntDir), NikkeStats.RotateSpeed
            * Time.deltaTime);
    }

    public void SetNikkeData(NikkeStats nikkeStats)
    {
        NikkeStats = nikkeStats;
    }

    // 테스트용 코드 나중에 오브젝트 풀 사용
    public void GunShot()
    {
        if (TargetEnemy == null) return;
        var go = Instantiate(shotEffect).GetComponent<Bullet>();
        go.Init(muzzlePosition.position, TargetEnemy, NikkeStats.Attack);
    }

    public bool HasAmmo()
    {
        if (NikkeStats.CurrentAmmo > 0)
        {
            return true;
        }

        return false;
    }

    public void SetAgentDestination(Vector3 pos)
    {
        NavMeshAgent.isStopped = false;
        NavMeshAgent.SetDestination(pos);
    }

    public void StopAgent()
    {
        NavMeshAgent.isStopped = true;
        NavMeshAgent.ResetPath();
    }

    // CoverDestory 호출 메서드
    public void CoverDestory()
    {
        CoverObject = null;
        CurrentAnimationState = Animation_State.NORMAL;
    }

    // 데미지 관련 처리 테스트용
    public void TakeDamage(float damage)
    {
        if (NikkeStats == null) return;

        NikkeStats.Hp -= damage;

        if(NikkeStats.Hp < 0)
        {
            NikkeStats.Hp = 0;
            // 죽음 처리 임시로 파괴
            Destroy(gameObject);
        }
    }
}

public enum Animation_State
{
    NORMAL,
    STAND,
    KNEEL,
}

// Sub 상태
public enum Sub_State
{
    // ATTACK
    ATTACK_START,
    ATTACK_ING,
    ATTACK_DELAY,
    ATTACK_END,
    ATTACK_RELOAD,

    // MOVE
    MOVE_ING,
    MOVE_END,
    MOVE_COVER,
}
