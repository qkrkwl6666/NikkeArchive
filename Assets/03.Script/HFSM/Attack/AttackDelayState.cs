using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackDelayState : State
{
    public AttackDelayState(StateMachine stateMachine, AIController aIController) 
        : base(stateMachine, aIController)
    {
    }

    public override void Enter()
    {
        controller.AnimationPlay(AnimationStrings.ATTACK_DELAY);
    }

    public override void Exit()
    {

    }

    public override void Execute()
    {
        if (controller == null) return;


    }
}
