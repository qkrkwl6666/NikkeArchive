using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class FormationFickUp : MonoBehaviour
{
    private bool isPickUp = false;

    private FormationAnimationTest formationAnimationTest = null;
    private Vector3 characterPos = Vector3.zero;

    private void Update()
    {
        if(isPickUp)
        {
            Vector3 mousePosition = Input.mousePosition;

            mousePosition.z = 10;

            Vector3 pos = Camera.main.ScreenToWorldPoint(mousePosition);
            pos.z = 0;
            Debug.Log(pos);
            formationAnimationTest.transform.position = pos;
        }

        if (Input.GetMouseButtonUp(0) && isPickUp) 
        {
            Debug.Log("IsPickUpDown");
            isPickUp = false;
            formationAnimationTest.transform.position = characterPos;
            formationAnimationTest.AnimationPlay("Idle");
            formationAnimationTest = null;
        }
    }

    private void FixedUpdate()
    {
        if (isPickUp) return;

        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;

        if (Physics.Raycast(ray, out hit, 100))
        {
            if (hit.collider.CompareTag("Nikke") && Input.GetMouseButtonDown(0))
            {
                isPickUp = true;
                formationAnimationTest = hit.collider.gameObject.GetComponent<FormationAnimationTest>();
                formationAnimationTest.AnimationPlay("PickUp");
                characterPos = hit.collider.transform.position;
            }
        }
    }
}
