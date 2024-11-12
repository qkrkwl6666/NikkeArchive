using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor.SceneTemplate;
using UnityEngine;
using UnityEngine.PlayerLoop;

public class FormationAnimationTest : MonoBehaviour
{
    private Animator animator;
    private FormationAnimationState currentState = FormationAnimationState.IDLE;

    private static List<string> animationNames = new ();

    private float time = 0f;
    private float duration = 5f;

    private void Start()
    {
        animator = GetComponent<Animator>();

        animationNames.Add("Idle");
        animationNames.Add("PickUp");
    }

    private void Update()
    {
        time += Time.deltaTime;

        if (time >= duration)
        {
            time = 0f;

            currentState++;

            if(currentState >= FormationAnimationState.COUNT)
            {
                currentState = FormationAnimationState.IDLE;
            }

            animator.Play(animationNames[(int)currentState]);
        }
    }
}

public enum FormationAnimationState
{
    IDLE,
    PICK_UP,
    COUNT,
}
