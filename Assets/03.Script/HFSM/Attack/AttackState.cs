using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class AttackState : State
{
    public StateMachine SubStateMachine { get; private set; }

    private AttackStartState attackStartState;

    public Attack_State CurrentAttackState { get; set; }

    public AttackState(StateMachine stateMachine, StateMachine subStateMachine, AIController controller) 
        : base(stateMachine, controller)
    {
        SubStateMachine = subStateMachine;
    }

    public override void Enter()
    {
        CurrentAttackState = Attack_State.ATTACK_START;
    }

    public override void Exit() 
    {

    }
    public override void Execute()
    {
        if (controller == null) return;

        //if(controller.TargetEnemy == null)
        //{
        //    switch(CurrentAttackState)
        //    {
        //        case Attack_State.ATTACK_START:

        //            break;
        //        case Attack_State.ATTACK_ING:

        //            break;
        //        case Attack_State.ATTACK_DELAY:

        //            break;
        //        case Attack_State.ATTACK_END:

        //            break;
        //    }
        //}
    }
}

public enum Attack_State
{
    ATTACK_START,
    ATTACK_ING,
    ATTACK_DELAY,
    ATTACK_END,
}