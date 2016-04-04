--����̩

--�ű���
x002018_g_scriptId = 002018


--��ӵ�е��¼�ID�б�
x002018_g_eventList={200301,200302}

--**********************************
--�¼��б�
--**********************************
function x002018_UpdateEventList( sceneId, selfId,targetId )
    local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "����"
	else
		PlayerSex = "����"
	end
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"���ںܶ�������ʿ���۴����ǣ����ϵİ�Σ��Ϊ��Ҫ��Ҫ���ر������ſɡ�"..PlayerName..PlayerSex.."����ҲҪע�ⰲȫ��")
	--�Ĵ���˴˴�ǰ������,��֪�к���ͼ,���ܶ���֮,���Ǻ���.");
	for i, eventId in x002018_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x002018_OnDefaultEvent( sceneId, selfId,targetId )
	x002018_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x002018_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002018_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--���ܴ�NPC������
--**********************************
function x002018_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002018_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--�ܾ���NPC������
--**********************************
function x002018_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��Ҫ����NPC���¼��б�
	for i, findId in x002018_g_eventList do
		if missionScriptId == findId then
			x002018_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�������Ѿ���������
--**********************************
function x002018_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002018_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ�����������
--**********************************
function x002018_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002018_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x002018_OnDie( sceneId, selfId, killerId )
end