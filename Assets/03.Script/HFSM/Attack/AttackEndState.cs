using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackEndState : State
{

    public AttackEndState(StateMachine stateMachine, AIController aIController) : base(stateMachine, aIController)
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
