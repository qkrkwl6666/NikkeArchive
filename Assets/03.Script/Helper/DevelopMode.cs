using TMPro;
using UnityEngine;

public class DevelopMode : MonoBehaviour
{
    public TextMeshProUGUI mainStateText;
    public TextMeshProUGUI subStateText;
    public TextMeshProUGUI targetEnemyText;

    public NikkeAI nikkeAi1;

    public void Update()
    {
        mainStateText.text = $"{nikkeAi1?.MainStateMachine?.CurrentState}";
        subStateText.text = $"{nikkeAi1.SubState}";
        targetEnemyText.text = $"{nikkeAi1.TargetEnemy}";
    }

    //static public string GetSubStateString(Sub_State state)
    //{
    //    string str = state.ToString();

    //    switch (state) 
    //    {
    //        case Sub_State.ATTACK_DELAY:
    //            break;
    //        case Sub_State.ATTACK_END:
    //            break;
    //        case Sub_State.ATTACK_ING:
    //            break;
    //        case Sub_State.ATTACK_RELOAD:
    //            break;
    //        case Sub_State.ATTACK_START:
    //            break;
    //        case Sub_State.MOVE_END:
    //            break;
    //        case Sub_State.MOVE_ING:
    //            break;
    //    }
    //}
}
