using System.Collections.Generic;

public class StateSubject : ISubject
{
    private List<IObserver> observers = new List<IObserver>();

    // MainStateMachine
    public MainStateMachine MainStateMachine { get; private set; }

    // AttackState
    public AttackState AttackState { get; private set; } // Main
    public AttackStartState AttackStartState { get; private set; } // Sub
    public AttackReloadState AttackReloadState { get; private set; } // Sub
    public AttackIngState AttackIngState { get; private set; } // Sub
    public AttackEndState AttackEndState { get; private set; } // Sub
    public AttackDelayState AttackDelayState { get; private set; } // Sub

    // MoveState
    public MoveState MoveState { get; private set; } // Main
    public MovingState MovingState { get; private set; } // Sub
    public MoveCoverState MoveCoverState { get; private set; } // Sub
    public MoveEndState MoveEndState { get; private set; } // Sub

    // IdleState
    public IdleState IdleState { get; private set; } // Main

    public void StateInit(AttackState attackState, MoveState moveState, IdleState idleState)
    {
        this.AttackState = attackState;
        this.AttackStartState = attackState.AttackStartState;
        this.AttackReloadState = attackState.AttackReloadState;
        this.AttackIngState = attackState.AttackIngState;
        this.AttackEndState = attackState.AttackEndState;
        this.AttackDelayState = attackState.AttackDelayState;

        this.MoveState = moveState;
        this.MovingState = moveState.MovingState;
        this.MoveEndState = moveState.MoveEndState;
        this.MoveCoverState = moveState.MoveCoverState;

        this.IdleState = idleState;

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
            observer.ObserverUpdate();
        }
    }

}
