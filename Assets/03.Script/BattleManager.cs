using System.Collections.Generic;
using UnityEngine;

public class BattleManager : MonoBehaviour
{
    // �� 
    [field: SerializeField]
    public List<Creature> Enemies { get; private set; } = new(); // �׽�Ʈ�� List ��� ���߿� ���� ����Ʈ��
    [field: SerializeField]
    public List<CoverObject> CoverObjects { get; private set; } = new();


}
