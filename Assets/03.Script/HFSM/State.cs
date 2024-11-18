using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class State : IState
{
    protected StateMachine stateMachine;

    protected State(StateMachine stateMachine)
    { 
        this.stateMachine = stateMachine; 
    }

    public virtual void Enter() { }
    public virtual void Execute() { }
    public virtual void Exit() { }
}   
