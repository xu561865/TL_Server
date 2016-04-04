--���

--�ű���
x002033_g_scriptId = 002033


--��ӵ�е��¼�ID�б�
x002033_g_eventList={210233,210234,210235,210236}

--**********************************
--�¼��б�
--**********************************
function x002033_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "����"
	else
		PlayerSex = "����"
	end
	AddText(sceneId,"  "..PlayerName..PlayerSex.."�����Ͼ�Ҫ���ִ���ˣ�������ʿ��ӿ�������ǲ��Ǹ��������϶��޽�һЩ������ջ�źá�#r#r  ��Ұ��ð�յ�ʱ�����������Ұ�޵�ͷĿ����Ҫ���׷Ź����ǰ���#r#r  ������ܴӹ���ͷĿ�����ѳ�ʲô�õ�ʳ�ģ������԰��������ң���ȡ�������͵�װ����")
	for i, eventId in x002033_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x002033_OnDefaultEvent( sceneId, selfId,targetId )
	x002033_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x002033_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002033_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--���ܴ�NPC������
--**********************************
function x002033_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002033_g_eventList do
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
function x002033_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��Ҫ����NPC���¼��б�
	for i, findId in x002033_g_eventList do
		if missionScriptId == findId then
			x002033_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�������Ѿ���������
--**********************************
function x002033_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002033_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ�����������
--**********************************
function x002033_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002033_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x002033_OnDie( sceneId, selfId, killerId )
end