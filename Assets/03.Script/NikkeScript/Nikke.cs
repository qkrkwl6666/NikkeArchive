using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Nikke : MonoBehaviour
{
    public NikkeStats stats;

    public Nikke(NikkeStats stats)
    {
        this.stats = stats;
    }
}
