using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackState : State
{
    public StateMachine SubStateMachine { get; private set; }

    public AttackState(StateMachine stateMachine, StateMachine subStateMachine) : base(stateMachine)
    {
        SubStateMachine = subStateMachine;
    }

    public override void Enter()
    {

    }

    public override void Exit() 
    {

    }
    public override void Execute()
    {
        
    }
}
