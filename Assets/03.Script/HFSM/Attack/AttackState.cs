    using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class AttackState : State
{
    public StateMachine SubStateMachine { get; private set; }

    private AttackStartState startState;
    private AttackIngState ingState;
    private AttackDelayState delayState;
    private AttackEndState endState;

    public Attack_State CurrentAttackState { get; set; }

    public AttackState(StateMachine stateMachine, StateMachine subStateMachine, AIController controller) 
        : base(stateMachine, controller)
    {
        SubStateMachine = subStateMachine;

        startState = new AttackStartState(SubStateMachine, controller, ingState);
    }

    public override void Enter()
    {
        CurrentAttackState = Attack_State.ATTACK_START;

        SubStateMachine.Initialize(startState);
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