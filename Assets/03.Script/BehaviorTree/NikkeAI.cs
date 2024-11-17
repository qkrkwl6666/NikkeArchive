using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NikkeAI : MonoBehaviour
{
    private BehaviorTree tree;
    private Animator animator;

    private Animation_State currentAnimationState;

    private LinkedList<GameObject> enemys;

    private float attackRange = 5f;
    private float attackCooldown = 2f;
    private float attackSpeed = 1f; // 공격 속도
    private int maxAmmo = 10;
    private float rotationSpeed = 1f; // 회전 속도

    private GameObject targetEnemy = null;

    public NikkeAI(LinkedList<GameObject> enemys)
    {
        currentAnimationState = Animation_State.NORMAL;
        this.enemys = enemys;
    }

    #region 애니메이션 STRING

    // IDLE 애니메이션 STRING
    private static readonly string IDLE_NORMAL = "Idle_Normal";
    private static readonly string IDLE_STAND = "Idle_Stand";
    private static readonly string IDLE_KNEEL = "Idle_Kneel";

    private static readonly string CALLSIGN_NORMAL = "Callsign_Normal";

    // MOVE 애니메이션 STRING
    private static readonly string MOVE_JUMP = "Move_Jump";
    private static readonly string MOVE_ING = "Move_Ing";
    private static readonly string MOVE_END_STAND = "Move_End_Stand";
    private static readonly string MOVE_END_KNEEL = "Move_End_Kneel";
    private static readonly string MOVE_END_NORMAL = "Move_End_Normal";

    // ATTACK_STAND 애니메이션 STRING
    private static readonly string ATTACK_START_STAND = "Attack_Start_Stand";
    private static readonly string ATTACK_ING_STAND = "Attack_ING_Stand";
    private static readonly string ATTACK_END_STAND = "Attack_End_Stand";
    private static readonly string ATTACK_DELAY_STAND = "Attack_Delay_Stand";
    private static readonly string ATTACK_RELOAD_STAND = "Attack_Reload_Stand";

    // ATTACK_NORMAL 애니메이션 STRING
    private static readonly string ATTACK_START_NORMAL = "Attack_Start_Normal";
    private static readonly string ATTACK_ING_NORMAL = "Attack_Ing_Normal";
    private static readonly string ATTACK_END_NORMAL = "Attack_End_Normal";
    private static readonly string ATTACK_DELAY_NORMAL = "Attack_Delay_Normal";
    private static readonly string Attack_RELOAD_Normal = "Attack_Reload_Normal";

    // ATTACK_KNEEL 애니메이션 STRING
    private static readonly string ATTACK_START_KNEEL = "Attack_Start_Kneel";
    private static readonly string ATTACK_ING_KNEEL = "Attack_Ing_Kneel";
    private static readonly string ATTACK_END_KNEEL = "Attack_End_Kneel";
    private static readonly string ATTACK_DELAY_KNEEL = "Attack_Delay_Kneel";
    private static readonly string Attack_RELOAD_KNEEL = "Attack_Reload_Kneel";

    #endregion

    private void Awake()
    {
        
    }

    private void Start()
    {
        animator = GetComponent<Animator>();
    }

    //private BehaviorTree SetttingBT()
    //{
    //    SelectorNode selectorNode = new SelectorNode();
    //}

    private IBTNode.BTNodeState CheckAttacking()
    {
        // TODO : RUNNING 에서 공격 업데이트 
        switch(currentAnimationState)
        {
            case Animation_State.NORMAL:
                if (IsAnimationRunning(ATTACK_ING_NORMAL)) return IBTNode.BTNodeState.Running;
                break;
            case Animation_State.STAND:
                if (IsAnimationRunning(ATTACK_ING_STAND)) return IBTNode.BTNodeState.Running;
                break;
            case Animation_State.KNEEL:
                if (IsAnimationRunning(ATTACK_ING_KNEEL)) return IBTNode.BTNodeState.Running;
                break;
        }

        return IBTNode.BTNodeState.Success;
    }

    private IBTNode.BTNodeState CheckAttackRange()
    {
        targetEnemy = null;

        float frevDistance = float.MaxValue;

        foreach(var enemy in enemys)
        {
            float distance = Vector3.Distance(enemy.transform.position, transform.position);

            if (distance <= attackCooldown && distance < frevDistance)
            {
                frevDistance = distance;
                targetEnemy = enemy;
            }
        }

        if (targetEnemy == null) return IBTNode.BTNodeState.Failure;

        return IBTNode.BTNodeState.Success;
    }

    private void Attack()
    {
        if(targetEnemy == null) return;

        // 적 방향으로 회전
        Vector3 enemyDir = (targetEnemy.transform.position - transform.position);
        enemyDir.y = 0;
        enemyDir.Normalize();

        transform.rotation = 
            Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(enemyDir), rotationSpeed * Time.deltaTime);


    }

    private bool IsAnimationRunning(string animationName)
    {
        if(animator == null) return false;

        if(animator.GetCurrentAnimatorStateInfo(0).IsName(animationName)) return true;
        
        return false;
    }
}

public enum Animation_State
{
    NORMAL,
    STAND,
    KNEEL,
}
