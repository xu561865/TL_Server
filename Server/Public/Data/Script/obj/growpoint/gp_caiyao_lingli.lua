--������
--��Ӧ����ܣ���ҩ	�ɿ��ܵı��8
--��ľ��
--�ű���710529
--��ľ��100%  ç�����10%
--�ȼ�1

--ÿ�δ򿪱ض���õĲ�Ʒ
x710529_g_MainItemId = 20101030
--���ܵõ��Ĳ�Ʒ
x710529_g_SubItemId = 20304016
--��Ҫ����Id
x710529_g_AbilityId = 8
--��Ҫ���ܵȼ�
x710529_g_AbilityLevel = 12


--���ɺ�����ʼ************************************************************************
--ÿ��ItemBox�����10����Ʒ
function 		x710529_OnCreate(sceneId,growPointType,x,y)
	--����ItemBoxͬʱ����һ����Ʒ
	targetId  = ItemBoxEnterScene(x,y,growPointType,sceneId,1,x710529_g_MainItemId)	--ÿ�������������ܵõ�һ����Ʒ,����ֱ�ӷ���itembox��һ��
	--���1~3�������,�����1����Ҫ����,�������1����AddItemToBox������Ʒ
	ItemCount = random(1,3)
	if ItemCount ~= 1 then
		for i=1, (ItemCount - 1) do
			AddItemToBox(sceneId,targetId,1,x710529_g_MainItemId)
		end
	end
	--�����Ҫ��Ʒ
	if random(1,10) == 1 then
		AddItemToBox(sceneId,targetId,1,x710529_g_SubItemId)
	end	
end
--���ɺ�������**********************************************************************


--��ǰ������ʼ&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x710529_OnOpen(sceneId,selfId,targetId)
--��������
-- 0 ��ʾ�򿪳ɹ�
	ABilityID		=	GetItemBoxRequireAbilityID(sceneId,targetId)
	AbilityLevel = QueryHumanAbilityLevel(sceneId,selfId,ABilityID)
	res = x710529_OpenCheck(sceneId,selfId,ABilityID,AbilityLevel)
	return res
	end
--��ǰ��������&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--���պ�����ʼ########################################################################
function	 x710529_OnRecycle(sceneId,selfId,targetId)
	-- ����������
		ABilityID	=	GetItemBoxRequireAbilityID(sceneId,targetId)
	CallScriptFunction(ABILITYLOGIC_ID, "GainExperience", sceneId, selfId, ABilityID, x710529_g_AbilityLevel)
	--���ľ���
	CallScriptFunction(ABILITYLOGIC_ID, "EnergyCostCaiJi", sceneId, selfId, ABilityID, x710529_g_AbilityLevel)
		--����1�����������
		return 1
end
--���պ�������########################################################################



--�򿪺�����ʼ@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x710529_OnProcOver(sceneId,selfId,targetId)
	return 0
end
--�򿪺�������@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x710529_OpenCheck(sceneId,selfId,AbilityId,AblityLevel)
	--�������ܵȼ�
	if AbilityLevel<x710529_g_AbilityLevel then
		return OR_NO_LEVEL
	end
	--��龫��
	if GetHumanEnergy(sceneId,selfId)< floor(x710529_g_AbilityLevel * 1.5 +2) then
		return OR_NOT_ENOUGH_ENERGY
	end
	return OR_OK
end