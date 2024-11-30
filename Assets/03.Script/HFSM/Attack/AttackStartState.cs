using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackStartState : State, IObserver
{
    private StateSubject stateSubject;

    private AttackDelayState attackdelayState;

    public AttackStartState(StateMachine stateMachine, AIController aIController, StateSubject stateSubject) 
        : base(stateMachine, aIController)
    {
        this.stateSubject = stateSubject;
        stateSubject.RegisterObserver(this);
    }

    public override void Enter()
    {
        Debug.Log(controller.TargetEnemy);
        controller.AnimationPlay(AnimationStrings.ATTACK_START);
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;


    }

    public void AnimationEventAttackStartEnd()
    {
        Debug.Log($"AnimationEventAttackStartEnd : {controller.TargetEnemy}");

        bool isEnemyDetected = controller.EnemyDetection();

        // enemy null
        if (controller.TargetEnemy == null || !isEnemyDetected)
        {
            Debug.Log("controller.TargetEnemy == null || !isEnemyDetected");

            return;
            // Todo : Move State¿Ãµø
            //stateMachine.ChangeState(attackdelayState);
        }

        stateMachine.ChangeState(attackdelayState);
    }                   

    public void Update()
    {
        attackdelayState = stateSubject.AttackDelayState;
    }
}
