--���㼼��ѧϰ

--�ű���
x713510_g_ScriptId = 713510

--��npc������������ߵȼ�
nMaxLevel = 5

--ѧϰ����Ҫ˵�Ļ�
x713510_g_MessageStudy = "�����ﵽ10�����ҿϻ���1�����ӾͿ���ѧ����㼼�ܡ������ѧϰô��"


--**********************************
--������ں���
--**********************************
function x713510_OnDefaultEvent( sceneId, selfId, targetId, ButtomNum,g_Npc_ScriptId )
	--��Ҽ��ܵĵȼ�
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_DIAOYU)
	--��Ҽӹ����ܵ�������
	ExpPoint = GetAbilityExp(sceneId, selfId, ABILITY_DIAOYU)
	--�����ж�

	--�ж��Ƿ��Ѿ�ѧ���˵���,���ѧ����,����ʾ�Ѿ�ѧ����
	if AbilityLevel >= 1 then
		BeginEvent(sceneId)
        	AddText(sceneId,"���Ѿ�ѧ����㼼����");
        	EndEvent(sceneId)
        DispatchMissionTips(sceneId,selfId)
		return
	end

	--���������ǡ�ѧϰ���ܡ���������=0��
	if ButtomNum == 0 then
		
		BeginEvent(sceneId)
		AddText(sceneId,x713510_g_MessageStudy)
		--ȷ��ѧϰ��ť
				AddNumText(sceneId,x713510_g_ScriptId,"��ȷ��Ҫѧϰ", -1, 2)
		--ȡ��ѧϰ��ť
				AddNumText(sceneId,x713510_g_ScriptId,"��ֻ��������", -1, 3)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif ButtomNum == 2 then			--���������ǡ���ȷ��Ҫѧϰ��
	--�������Ƿ���һ�����ҵ��ֽ�
	if GetMoney(sceneId,selfId) <= 100 then			
		BeginEvent(sceneId)
			AddText(sceneId,"��Ľ�Ǯ����");
			EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--�����ҵȼ��Ƿ�ﵽҪ��
	if GetLevel(sceneId,selfId) < LEVELUP_ABILITY[1].HumanLevelLimit then
		BeginEvent(sceneId)
			AddText(sceneId,"��ĵȼ�����");
			EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--ɾ����Ǯ
	CostMoney(sceneId,selfId,100)
	--����������1
	SetHumanAbilityLevel(sceneId,selfId,ABILITY_DIAOYU,1)
	--��npc���촰��֪ͨ����Ѿ�ѧ����
	BeginEvent(sceneId)
		AddText(sceneId,"��ѧ���˵��㼼��")
	EndEvent( )
	DispatchEventList(sceneId,selfId,targetId)
	else --����������ֻ����������
		CallScriptFunction( g_Npc_ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
end

--**********************************
--�о��¼�
--**********************************
function x713510_OnEnumerate( sceneId, selfId, targetId )
		--��������ȼ�����ʾѡ��
		if GetLevel(sceneId,selfId) >= 10 then
			AddNumText(sceneId,x713510_g_ScriptId,"ѧϰ���㼼��", -1, 0)
		end
		return
end

--**********************************
--����������
--**********************************
function x713510_CheckAccept( sceneId, selfId )
end

--**********************************
--����
--**********************************
function x713510_OnAccept( sceneId, selfId, ABILITY_CAIKUANG )
end