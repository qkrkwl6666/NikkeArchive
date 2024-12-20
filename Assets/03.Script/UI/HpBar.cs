using Cysharp.Threading.Tasks;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HpBar : MonoBehaviour
{
    private SpriteRenderer hpBarSprite;
    private float initScaleX = 2f;
    private float initScaleY = 1f;
    private float duration = 0.1f;

    private Camera mainCamera;

    private void Start()
    {
        hpBarSprite = GetComponent<SpriteRenderer>();

        initScaleX = hpBarSprite.size.x;
        initScaleY = hpBarSprite.size.y;

        mainCamera = Camera.main;
    }

    private void FixedUpdate()
    {
        transform.LookAt(transform.position + mainCamera.transform.rotation 
            * Vector3.forward, mainCamera.transform.rotation * Vector3.up);
    }   

    public void HpUpdate(float currentHp, float maxHp)
    {
        //await CoHpBarEffect(currentHp, maxHp);
        float hpRatio = currentHp / maxHp;
        hpBarSprite.size = new Vector2(hpRatio * initScaleX, initScaleY);
    }

    //public async void HpUpdate(float currentHp, float maxHp)
    //{
    //    await CoHpBarEffect(currentHp, maxHp);
    //    //hpBarSprite.size.Set(hpRatio * initScaleX, initScaleY);
    //}

    public async UniTask CoHpBarEffect(float currentHp, float maxHp)
    {
        float elapsedTime = 0f;
        float targetHp = currentHp / maxHp * initScaleX;
        float initSizeX = hpBarSprite.size.x;

        while (elapsedTime < duration) 
        {
            if (hpBarSprite == null) return;

            elapsedTime += Time.deltaTime;

            float hp = Mathf.Lerp(initSizeX, targetHp, hpBarSprite.size.x);
            Debug.Log(hp);

            hpBarSprite.size = new Vector2 (hp, initScaleY);
            //Debug.Log(hpBarSprite.size);

            await UniTask.Yield();
        }
    }
}
