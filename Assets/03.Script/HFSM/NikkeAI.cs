using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NikkeAI : AIController
{
    private AttackState attackState;
    private MoveState moveState;

    private StateMachine mainStateMachine; // MainState

    // �׽�Ʈ 
    public Creature enemyTest1;

    // StateSubject
    private StateSubject stateSubject;

    private void Awake()
    {
        // �ӽ� ���� ����
        NikkeStats stats = new NikkeStats();

        SetNikkeData(stats);

    }

    protected override void Start()
    {
        base.Start();

        stateSubject = new StateSubject();

        mainStateMachine = new StateMachine();

        attackState = new AttackState(mainStateMachine, this, stateSubject);
        moveState = new MoveState(mainStateMachine, this, stateSubject);

        stateSubject.StateInit(attackState, moveState);

        //attackState.StateInit(moveState);
        //moveState.StateInit(attackState);

        stateSubject.NotifyObserver();

        mainStateMachine.Initialize(moveState);

        enemies.AddFirst(enemyTest1);
    }

    private void Update()
    {
        mainStateMachine.Update();

        if (Input.GetKeyUp(KeyCode.F1)) 
        {
            CurrentAnimationState = Animation_State.NORMAL;
        }
        if (Input.GetKeyUp(KeyCode.F2))
        {
            CurrentAnimationState = Animation_State.STAND;
        }
        if (Input.GetKeyUp(KeyCode.F3))
        {
            CurrentAnimationState = Animation_State.KNEEL;
        }

    }

    public override void MoveFront()
    {
        // TODO : ���߿� ����Ž� �����ؼ� ���� �� ������ 

        transform.Translate(Vector3.forward * NikkeStats.MoveSpeed * Time.deltaTime);
    }

    #region �ִϸ��̼� �̺�Ʈ
    public void AnimationAttackStartEvent()
    {
        attackState.AnimationAttackStartEvent();
    }

    public void AnimationAttackIngEvent()
    {
        attackState.AnimationAttackIngEvent();
    }

    public void AnimationAttackEndEvent()
    {
        attackState.AnimationAttackEndEvent();
    }
    public void AnimationAttackReloadEvent()
    {
        attackState.AnimationAttackReloadEvent();
    }

    public void AnimationMoveEndEvent()
    {
        moveState.AnimationMoveEndEvent();
    }

    #endregion
}
