using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NikkeAI : AIController
{
    private AttackState attackState;
    private MoveState moveState;

    private StateMachine mainStateMachine; // MainState

    // 테스트 
    public Creature enemyTest1;

    private void Awake()
    {
        // 임시 니케 스텟
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
        // TODO : 나중에 내비매쉬 생각해서 뭐가 더 좋은지 

        transform.Translate(Vector3.forward * NikkeStats.MoveSpeed * Time.deltaTime);
    }

    #region 애니메이션 이벤트
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
