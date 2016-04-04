--ʯ�� �غ���

--�ű���
x026001_g_scriptId = 026001

--��ӵ�е��¼�ID�б�
x026001_g_eventList={211703,211706}	

--**********************************
--�¼��б�
--**********************************
function x026001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	
	local IsDone606 = IsMissionHaveDone(sceneId,selfId,606)	
		
	
	
	--if(IsHaveMission(sceneId,selfId,606) > 0) then
	--	AddText(sceneId,  "�㻹���Ѿ��������� 606 û����ɣ�")
	--	EndEvent(sceneId)
	--	DispatchEventList(sceneId,selfId,targetId)
	--	return
	--end
		
	
	if(IsDone606 == 0) then		
		AddText(sceneId, "ɱ10��������")	
	end	
	
	for i, eventId in x026001_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x026001_OnDefaultEvent( sceneId, selfId,targetId )
	x026001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x026001_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x026001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--���ܴ�NPC������
--**********************************
function x026001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x026001_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end
			return
		end
	end
end

--**********************************
--�ܾ���NPC������
--**********************************
function x026001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��Ҫ����NPC���¼��б�
	for i, findId in x026001_g_eventList do
		if missionScriptId == findId then
			x026001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�������Ѿ���������
--**********************************
function x026001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x026001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ�����������
--**********************************
function x026001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x026001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x026001_OnDie( sceneId, selfId, killerId )
end