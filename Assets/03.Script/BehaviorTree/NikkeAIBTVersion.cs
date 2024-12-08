using System.Collections.Generic;
using UnityEngine;

public class NikkeAIBTVersion : MonoBehaviour
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

    public NikkeAIBTVersion(LinkedList<GameObject> enemys)
    {
        currentAnimationState = Animation_State.NORMAL;
        this.enemys = enemys;
    }

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
        switch (currentAnimationState)
        {
            case Animation_State.NORMAL:
                if (IsAnimationRunning(AnimationStrings.ATTACK_ING_NORMAL)) return IBTNode.BTNodeState.Running;
                break;
            case Animation_State.STAND:
                if (IsAnimationRunning(AnimationStrings.ATTACK_ING_STAND)) return IBTNode.BTNodeState.Running;
                break;
            case Animation_State.KNEEL:
                if (IsAnimationRunning(AnimationStrings.ATTACK_ING_KNEEL)) return IBTNode.BTNodeState.Running;
                break;
        }

        return IBTNode.BTNodeState.Success;
    }

    private IBTNode.BTNodeState CheckAttackRange()
    {
        targetEnemy = null;

        float frevDistance = float.MaxValue;

        foreach (var enemy in enemys)
        {
            float distance = Vector3.Distance(enemy.transform.position, transform.position);

            if (distance <= attackRange && distance < frevDistance)
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
        if (targetEnemy == null) return;

        // 적 방향으로 회전
        Vector3 enemyDir = (targetEnemy.transform.position - transform.position);
        enemyDir.y = 0;
        enemyDir.Normalize();

        transform.rotation =
            Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(enemyDir), rotationSpeed * Time.deltaTime);


    }

    private bool IsAnimationRunning(string animationName)
    {
        if (animator == null) return false;

        if (animator.GetCurrentAnimatorStateInfo(0).IsName(animationName)) return true;

        return false;
    }
}
