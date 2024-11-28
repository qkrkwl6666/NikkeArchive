    using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class AttackState : State
{
    public StateMachine SubStateMachine { get; private set; }

    private AttackStartState attackStartState;
    private AttackIngState attackIngState;
    private AttackDelayState attackDelayState;
    private AttackEndState attackEndState;

    public Attack_State CurrentAttackState { get; set; }

    public AttackState(StateMachine stateMachine, AIController controller) 
        : base(stateMachine, controller)
    {
        SubStateMachine = new StateMachine();   

        attackStartState = new AttackStartState(SubStateMachine, controller);
        attackIngState = new AttackIngState(SubStateMachine, controller);
        attackDelayState = new AttackDelayState(SubStateMachine, controller);

        attackStartState.StateInit(attackIngState, attackDelayState);
        attackIngState.StateInit(attackDelayState, attackEndState);
        attackDelayState.StateInit(attackEndState, attackIngState);
    }

    public override void Enter()
    {
        CurrentAttackState = Attack_State.ATTACK_START;

        SubStateMachine.Initialize(attackStartState);
    }

    public override void Exit() 
    {

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
}

public enum Attack_State
{
    ATTACK_START,
    ATTACK_ING,
    ATTACK_DELAY,
    ATTACK_END,
}