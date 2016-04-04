-- �����䷽�ű� ����ʹ�ü���������Ʒ
-- *******
-- ���� 4 ��
-- �ýű������������ر����ܺ�����
-- x700921_AbilityCheck ��������ʹ�ü�麯��
-- x700921_AbilityConsume �����ϳɽ����������������
-- x700921_AbilityProduce �����ϳɳɹ���������Ʒ

--------------------------------------------------------------------------------
-- ���²�����Ҫ��д
--------------------------------------------------------------------------------
--�ű�������
--2��ñ�䷽ ������Ʒ

-- �ű���
x700921_g_ScriptId = 700921

-- ����ܺ�
x700921_g_AbilityID = ABILITY_FENGREN

-- ��������ܵ���󼶱�
x700921_g_AbilityMaxLevel = 12

-- �䷽��
x700921_g_RecipeID = 83

-- �䷽�ȼ�(�����ܵĵȼ�)
x700921_g_RecipeLevel = 1

-- ���ϱ�
x700921_g_CaiLiao = {
	{ID = 20105004, Count = 2},
	{ID = 20107004, Count = 1},
	{ID = 20308084, Count = 1},
}

-- ��Ʒ��
x700921_g_ChanPin = {
	{ID = 10212009, Odds = 3333},
	{ID = 10212010, Odds = 6666},
	{ID = 10212011, Odds = 10000},
}
--------------------------------------------------------------------------------
-- ���ϲ�����Ҫ��д
--------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	����ʹ�ü�麯��
----------------------------------------------------------------------------------------
function x700921_AbilityCheck(sceneId, selfId)
	-- �����������
	VigorValue = x700921_g_RecipeLevel * 2 + 1
	if GetHumanVigor(sceneId, selfId) < VigorValue then
		return OR_NOT_ENOUGH_VIGOR
	end

	-- ����Ƿ�����㹻
	StartPos = LuaFnGetMaterialStartBagPos(sceneId, selfId)
	EndPos = LuaFnGetMaterialEndBagPos(sceneId, selfId)

	for idx, Mat in x700921_g_CaiLiao do
		nCount = Mat.Count

		ret = GetItemCount(sceneId, selfId, Mat.ID)
		if ret < nCount then
			return OR_STUFF_LACK
		end
	end

	return OR_OK
end

----------------------------------------------------------------------------------------
--	�ϳɽ����������������
----------------------------------------------------------------------------------------
function x700921_AbilityConsume(sceneId, selfId)
	-- ���Ƚ�����������
	VigorCost = x700921_g_RecipeLevel * 2 + 1
	VigorValue = GetHumanVigor(sceneId, selfId) - VigorCost
	SetHumanVigor(sceneId, selfId, VigorValue)

	-- Ȼ����в�������
	StartPos = LuaFnGetMaterialStartBagPos(sceneId, selfId)
	EndPos = LuaFnGetMaterialEndBagPos(sceneId, selfId)

	for idx, Mat in x700921_g_CaiLiao do
		nCount = Mat.Count

		ret = DelItem(sceneId, selfId, Mat.ID, nCount)
		if ret ~= 1 then
			return 0
		end
	end

	return 1
end

----------------------------------------------------------------------------------------
--	�ϳɳɹ���������Ʒ
----------------------------------------------------------------------------------------
function x700921_AbilityProduce(sceneId, selfId)
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x700921_g_AbilityID)

	-- �����һ���� [1, 10000]
	rand = random(10000)

	for i, item in x700921_g_ChanPin do
		if item.Odds >= rand then
			Quality = CallScriptFunction( ABILITYLOGIC_ID, "CalcQuality", x700921_g_RecipeLevel, AbilityLevel, x700921_g_AbilityMaxLevel )

			if LuaFnTryRecieveItem(sceneId, selfId, item.ID, Quality) < 0 then
				return OR_ERROR
			end

			LuaFnSendAbilitySuccessMsg( sceneId, selfId, x700921_g_AbilityID, x700921_g_RecipeID, item.ID )
			return OR_OK
		end
	end

	return OR_ERROR
end