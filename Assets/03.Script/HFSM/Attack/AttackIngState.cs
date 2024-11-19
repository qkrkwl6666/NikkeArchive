using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackIngState : State
{
    public AttackIngState(StateMachine stateMachine, AIController aIController) : base(stateMachine, aIController)
    {

    }

    public override void Enter()
    {
        
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;


    }
}
