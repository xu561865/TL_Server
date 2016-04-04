--����
--��ֲ��12

--�ű���
x714104_g_ScriptId = 714104

event_xuanzezhiwu = 713550

--ֲ���Ʒ����б�
x714104_g_eventList={20104001,20104002,20104005,20104008,20104009,20104010,
			20105001,20105003,20105006,20105009,20105010} --ֲ��ı��,����eventId
--**********************************
--�¼��������
--**********************************
function x714104_OnDefaultEvent( sceneId, selfId,targetId )
	--PLANTFLAG[1] =0
	--PLANTFLAG[2] =0
	AbilityLevel = QueryHumanAbilityLevel( sceneId, selfId, ABILITY_ZHONGZHI)
	--�����Ҳ�����ֲ����
	if AbilityLevel == 0	then
		BeginEvent(sceneId)
			AddText(sceneId, "����ȥѧϰ��ֲ���ܰ�")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	--�����һ���ֲ����
	if AbilityLevel ~= 0	then
		BeginEvent(sceneId)
			AddText(sceneId, "��ѡ����Ҫ�ֵ�ֲ��")
			--ͨ��x714104_g_eventList��scriptglobal�е�ֲ���б��Աȣ������������ֲ���ܵȼ�����ʾ��Ӧֲ��
			for i, eventId in x714104_g_eventList do	--������������˿�����ֲ��ֲ���б�
				for j,g_ZhiWuId in V_ZHONGZHI_ID do		--����scriptglobal�е�����ֲ���б�
					if eventId == g_ZhiWuId then
						if AbilityLevel >= V_ZHONGZHI_NEEDLEVEL[j] then --��������ֲ���ܵȼ�>=��ֲ��Ҫ���ܵȼ�]
							AddNumText(sceneId, x714104_g_eventList[i], V_ZHONGZHI_NAME[j])
							break
						end
					end
				end
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x714104_OnEventRequest( sceneId, selfId, targetId, eventId )
	zhiwuId = eventId
	for i, findId in x714104_g_eventList do
		if zhiwuId == findId then
			CallScriptFunction( 713550, "OnDefaultEvent",sceneId, selfId, targetId, zhiwuId )
			return
		end
	end
end

--**********************************
--���ܴ�NPC��������ʱ��������ӿڣ�
--**********************************
function x714104_OnMissionSubmit( sceneId, selfId, targetId, scriptId )
	for i, findId in x714104_g_eventList do
		if scriptId == findId then
			ret = CallScriptFunction( scriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( scriptId, "OnAccept", sceneId, selfId, ABILITY_ZHONGZHI )
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, ABILITY_ZHONGZHI )
			end
			return
		end
	end
end

--**********************************
--���ܴ�NPC������
--**********************************
function x714104_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x714104_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, ABILITY_ZHONGZHI )	
			end
			return
		end
	end
end
