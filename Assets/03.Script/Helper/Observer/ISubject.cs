using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface ISubject 
{
    public void RegisterObserver(IObserver observer);
    public void RemoveObserver(IObserver observer);
    public void NotifyObserver();
}
