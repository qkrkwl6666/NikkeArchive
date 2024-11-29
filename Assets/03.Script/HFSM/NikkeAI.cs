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

    private void Awake()
    {
        // �ӽ� ���� ����
        NikkeStats stats = new NikkeStats();

        SetNikkeData(stats);

    }

    protected override void Start()
    {
        base.Start();

        mainStateMachine = new StateMachine();

        attackState = new AttackState(mainStateMachine, this);
        moveState = new MoveState(mainStateMachine, this);

        attackState.StateInit(moveState);
        moveState.StateInit(attackState);

        mainStateMachine.Initialize(moveState);

        enemies.AddFirst(enemyTest1);
    }

    private void Update()
    {
        mainStateMachine.Update();

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
    #endregion
}
