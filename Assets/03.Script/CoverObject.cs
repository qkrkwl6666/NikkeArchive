using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CoverObject : MonoBehaviour
{
    [field: SerializeField]
    public Transform CoverPoint { get; private set; }
}

public enum CoverType
{
    Stand,
    Kneel,
}
