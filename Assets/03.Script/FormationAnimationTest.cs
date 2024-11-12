using JetBrains.Annotations;
using System.Collections;
using System.Collections.Generic;
using System.Xml.Schema;
using Unity.VisualScripting;
using UnityEditor.SceneTemplate;
using UnityEngine;
using UnityEngine.Animations.Rigging;
using UnityEngine.PlayerLoop;

public class FormationAnimationTest : MonoBehaviour
{
    private Animator animator;
    private FormationAnimationState currentState = FormationAnimationState.IDLE;
    private TwoBoneIKConstraint twoBoneIKConstraint;

    private static List<string> animationNames = new ();

    private Vector3 pos = Vector3.zero;

    private float time = 0f;
    private float duration = 5f;

    private void Start()
    {
        animator = GetComponent<Animator>();
        twoBoneIKConstraint = GetComponentInChildren<TwoBoneIKConstraint>();

        animationNames.Add("Idle");
        animationNames.Add("PickUp");

        pos = transform.position;
    }

    private void Update()
    {
        

        //time += Time.deltaTime;

        //if (time >= duration)
        //{
        //    time = 0f;

        //    currentState++;

        //    if(currentState >= FormationAnimationState.COUNT)
        //    {
        //        currentState = FormationAnimationState.IDLE;
        //    }

        //    animator.Play(animationNames[(int)currentState]);

        //    if(currentState == FormationAnimationState.IDLE && twoBoneIKConstraint != null)
        //    {
        //        twoBoneIKConstraint.weight = 1f;
        //    }
        //    else if (twoBoneIKConstraint != null)
        //    {
        //        twoBoneIKConstraint.weight = 0f;
        //    }
        //}
    }

    public void AnimationPlay(string name)
    {
        animator.Play(name);
    }

}

public enum FormationAnimationState
{
    IDLE,
    PICK_UP,
    COUNT,
}
