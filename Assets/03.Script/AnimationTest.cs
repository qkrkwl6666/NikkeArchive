using System.Collections.Generic;
using UnityEngine;

public class AnimationTest : MonoBehaviour
{
    private Animator animator;
    private RuntimeAnimatorController runtimeAnimator;
    private List<AnimationClip> animatorClips = new();

    private float duration = 5f;
    private float time = 5f;
    private int index = 0;

    public void Start()
    {
        animator = GetComponent<Animator>();

        runtimeAnimator = animator.runtimeAnimatorController;

        foreach (AnimationClip clip in runtimeAnimator.animationClips)
        {
            animatorClips.Add(clip);
        }

    }

    private void Update()
    {
        time += Time.deltaTime;

        if (time >= duration)
        {
            time = 0;

            animator.Play(animatorClips[index].name);
            Debug.Log($"Change {animatorClips[index].name}");

            index++;

            if (index >= animatorClips.Count)
            {
                index = 0;
            }
        }
    }
}
