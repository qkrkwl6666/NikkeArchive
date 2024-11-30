using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

public abstract class AIController : MonoBehaviour
{
    protected Animator animator;
    public Animation_State CurrentAnimationState { get; set; } = Animation_State.NORMAL;

    private Dictionary<(string, Animation_State), string> animationCache = new ();
    public Creature TargetEnemy { get; private set; }

    public NikkeStats NikkeStats { get; private set; }
    public LinkedList<Creature> enemies = new ();

    protected virtual void Start()
    {
        animator = GetComponent<Animator>();
    }

    public void AnimationPlay(string name)
    {
        if (AnimationStringException(name))
        {
            animator.Play(name);
            return;
        }

        if (!animationCache.TryGetValue((name, CurrentAnimationState), out string fullName))
        {
            fullName = $"{name}_{GetAnimationStateString()}";
            animationCache.Add((name, CurrentAnimationState), fullName);
        }

        animator.Play(fullName);
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

    public bool EnemyDetection()
    {
        TargetEnemy = null;

        float frevDistance = float.MaxValue;

        foreach (var enemy in enemies)
        {
            float distance = Vector3.Distance(enemy.transform.position, transform.position);

            if (distance <= NikkeStats.AttackRange && distance < frevDistance)
            {
                frevDistance = distance;
                TargetEnemy = enemy;
            }
        }

        if (TargetEnemy == null) return false;

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

    public virtual void MoveFront() 
    {

    }

    public void SetNikkeData(NikkeStats nikkeStats)
    {
        NikkeStats = nikkeStats;
    }

    public bool HasAmmo()
    {
        if(NikkeStats.CurrentAmmo > 0)
        {
            return true;
        }   
        
        return false;
    }

}

public enum Animation_State
{
    NORMAL,
    STAND,
    KNEEL,
}
