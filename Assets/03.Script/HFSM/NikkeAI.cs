using UnityEngine;

public class NikkeAI : AIController
{
    public AttackState AttackState { get; private set; }
    public MoveState MoveState { get; private set; }
    public IdleState IdleState { get; private set; }

    public MainStateMachine MainStateMachine { get; private set; } // MainState

    // StateSubject
    private StateSubject stateSubject;

    private void Awake()
    {
        // 임시 니케 스텟
        NikkeStats stats = new NikkeStats();

        stats.ShotAnimationTime.Add(0.03f);
        stats.ShotAnimationTime.Add(0.06f);
        stats.ShotAnimationTime.Add(0.11f);

        SetNikkeData(stats);
    }

    protected override void Start()
    {
        base.Start();

        stateSubject = new StateSubject();

        MainStateMachine = new MainStateMachine();

        AttackState = new AttackState(MainStateMachine, this, stateSubject);
        MoveState = new MoveState(MainStateMachine, this, stateSubject);
        IdleState = new IdleState(MainStateMachine, this, stateSubject);

        stateSubject.StateInit(AttackState, MoveState, IdleState);

        stateSubject.NotifyObserver();

        MainStateMachine.Initialize(MoveState, MoveState.MovingState);

        //enemies.AddFirst(enemyTest1);
    }

    private void Update()
    {
        MainStateMachine.Update();

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

    #region 애니메이션 이벤트
    public void AnimationAttackStartEvent()
    {
        AttackState.AnimationAttackStartEvent();
    }

    public void AnimationAttackIngEvent()
    {
        AttackState.AnimationAttackIngEvent();
    }

    public void AnimationAttackEndEvent()
    {
        AttackState.AnimationAttackEndEvent();
    }
    public void AnimationAttackReloadEvent()
    {
        AttackState.AnimationAttackReloadEvent();
    }

    public void AnimationMoveEndEvent()
    {
        MoveState.AnimationMoveEndEvent();
    }

    public void AnimationMoveJumpEvent()
    {
        MoveState.AnimationMoveJumpEvent();
    }

    public void AnimationAttackIngGunShot()
    {
        GunShot();
    }

    #endregion

}
