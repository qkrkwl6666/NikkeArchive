    using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor.SceneTemplate;
using UnityEngine;

public class AttackState : State, IObserver
{
    private StateSubject stateSubject;

    public StateMachine SubStateMachine { get; private set; }

    public AttackStartState AttackStartState { get; private set; }
    public AttackIngState AttackIngState { get; private set; }
    public AttackDelayState AttackDelayState { get; private set; }
    public AttackReloadState AttackReloadState { get; private set; }
    public AttackEndState AttackEndState { get; private set; }

    // Move
    private MoveState moveState;

    public Attack_State CurrentAttackState { get; set; }


    public AttackState(StateMachine stateMachine, AIController controller, StateSubject stateSubject) 
        : base(stateMachine, controller)
    {
        this.stateSubject = stateSubject;

        stateSubject.RegisterObserver(this);

        SubStateMachine = new StateMachine();   

        AttackStartState = new AttackStartState(SubStateMachine, controller, stateSubject);
        AttackIngState = new AttackIngState(SubStateMachine, controller, stateSubject);
        AttackDelayState = new AttackDelayState(SubStateMachine, controller, stateSubject);
        AttackReloadState = new AttackReloadState(SubStateMachine, controller, stateSubject);

        //AttackStartState.StateInit(AttackIngState, AttackDelayState);
        //AttackIngState.StateInit(AttackDelayState, AttackEndState);
        //AttackDelayState.StateInit(AttackEndState, AttackIngState, stateMachine, moveState);
    }

    //public void StateInit(MoveState moveState)
    //{
    //    this.moveState = moveState;
    //}

    public override void Enter()
    {
        
        if (!controller.HasAmmo())
        {
            SubStateMachine.Initialize(AttackReloadState);
            return;
        }

        SubStateMachine.Initialize(AttackStartState);
    }

    public override void Exit() 
    {
        // SubState Exit 처리
        SubStateMachine.CurrentStateExit();
    }
    public override void Execute()
    {
        if (controller == null) return;

        if(controller.TargetEnemy != null)
        {
            controller.RotateEnemy();
        }
        
        SubStateMachine.Update();
    }


    #region 애니메이션 이벤트
    public void AnimationAttackStartEvent()
    {
        AttackStartState.AnimationEventAttackStartEnd();
    }
    public void AnimationAttackIngEvent()
    {
        AttackIngState.AnimationEventAttackIngEnd();
    }
    public void AnimationAttackReloadEvent() 
    {
        AttackReloadState.AnimationEventAttackReloadEnd();
    }

    public void AnimationAttackEndEvent()
    {
        
    }

    public void Update()
    {
        moveState = stateSubject.MoveState;
    }

    #endregion

}

public enum Attack_State
{
    ATTACK_START,
    ATTACK_ING,
    ATTACK_DELAY,
    ATTACK_END,
}