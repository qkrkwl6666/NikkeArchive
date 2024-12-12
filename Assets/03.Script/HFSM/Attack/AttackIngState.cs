using Unity.VisualScripting;
using UnityEngine;

public class AttackIngState : SubState, IObserver
{
    StateSubject stateSubject;

    private AttackDelayState attackDelayState;

    // TEST
    private int currentAttackCount = 0;
    private float time = 0f;

    public AttackIngState(SubStateMachine subStateMachine, AIController aIController, StateSubject stateSubject)
        : base(subStateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        controller.NikkeStats.CurrentAmmo--;
        controller.AnimationPlay(AnimationStrings.ATTACK_ING);
        
        controller.SubState = Sub_State.ATTACK_ING;
        currentAttackCount = 0;
        time = 0f;
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;

        //if(controller.TargetEnemy == null)
        //{
        //    subStateMachine.ChangeState(attackDelayState);
        //}


        // 애니메이션 이벤트 방식으로 변경
        //AnimatorStateInfo animatorStateInfo;
        //animatorStateInfo = controller.Animator.GetCurrentAnimatorStateInfo(0);
        
        //time = animatorStateInfo.length * animatorStateInfo.normalizedTime;

        //if (currentAttackCount < controller.NikkeStats.AttackCount 
        //    && time >= controller.NikkeStats.ShotAnimationTime[currentAttackCount])
        //{
        //    Debug.Log(time);
        //    Debug.Log(currentAttackCount);
        //    // Shot 메서드
        //    controller.GunShot();
        //    currentAttackCount++;
        //}

        //if(controller.TargetEnemy == null || !controller.EnemyDetection())
        //{
        //    Debug.Log("controller.TargetEnemy == null || !controller.EnemyDetection()");
        //    stateMachine.ChangeState(attackDelayState);
        //    return;
        //}

    }

    public void AnimationEventAttackIngEnd()
    {
        Debug.Log("AnimationEventAttackIngEnd");
        subStateMachine.ChangeState(attackDelayState);
    }

    public void ObserverUpdate()
    {
        attackDelayState = stateSubject.AttackDelayState;
    }
}
