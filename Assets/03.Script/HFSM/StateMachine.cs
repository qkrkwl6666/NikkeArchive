using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class StateMachine
{
    public State CurrentState {  get; private set; }

    
    public void Initialize(State startState)
    {
        CurrentState = startState;
        CurrentState.Enter();
    }
    public void ChangeState(State newState) 
    {
        CurrentState.Exit();
        CurrentState = newState;
        CurrentState.Enter();
    }

    public void Update()
    {
        if (CurrentState == null) return;

        CurrentState.Execute();
    }
}
