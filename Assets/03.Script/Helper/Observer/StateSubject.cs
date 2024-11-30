using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StateSubject : ISubject
{
    private List<IObserver> observers = new List<IObserver>();

    // MainStateMachine
    public StateMachine MainStateMachine { get; private set; }

    // AttackState
    public AttackState AttackState { get; private set; } // Main
    public AttackStartState AttackStartState { get; private set; } // Sub
    public AttackReloadState AttackReloadState { get; private set; } // Sub
    public AttackIngState AttackIngState { get; private set; } // Sub
    public AttackEndState AttackEndState { get; private set; } // Sub
    public AttackDelayState AttackDelayState { get; private set; } // Sub

    // MoveState
    public MoveState MoveState { get; private set; } // Main
    public MoveFrontState MoveFrontState { get; private set; } // Sub

    public void StateInit(AttackState attackState, MoveState moveState)
    {
        this.AttackState = attackState;
        this.AttackStartState = attackState.AttackStartState;
        this.AttackReloadState = attackState.AttackReloadState;
        this.AttackIngState = attackState.AttackIngState;
        this.AttackEndState = attackState.AttackEndState;
        this.AttackDelayState = attackState.AttackDelayState;

        this.MoveState = moveState;
        this.MoveFrontState = moveState.MoveFrontState;

        this.MainStateMachine = attackState.GetStateMachine();
    }

    public void RegisterObserver(IObserver observer)
    {
        if (observers.Contains(observer))
            return;

        observers.Add(observer);
    }
            
    public void RemoveObserver(IObserver observer)
    {
        observers.Remove(observer);
    }

    public void NotifyObserver()
    {
        foreach (IObserver observer in observers)
        {
            observer.Update();
        }
    }

}
