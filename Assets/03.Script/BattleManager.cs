using System.Collections.Generic;
using UnityEngine;

public class BattleManager : MonoBehaviour
{
    // 적 
    [field: SerializeField]
    public List<Creature> Enemies { get; private set; } = new(); // 테스트로 List 사용 나중에 연결 리스트로
    [field: SerializeField]
    public List<CoverObject> CoverObjects { get; private set; } = new();


}
