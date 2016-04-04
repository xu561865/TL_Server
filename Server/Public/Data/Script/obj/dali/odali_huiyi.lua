--����

--�ű���
x002038_g_scriptId = 002038


--��ӵ�е��¼�ID�б�
x002038_g_eventList={210209}

--**********************************
--�¼��б�
--**********************************
function x002038_UpdateEventList( sceneId, selfId,targetId )
	
	local  Menpai=LuaFnGetMenPai(sceneId,selfId)
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "ʦ��"
	else
		PlayerSex = "ʦ��"
	end
	
	BeginEvent(sceneId)	
	if Menpai == OR_WUMENPAI then
		AddText(sceneId,"  ƶɮ���ף������ֵ��ӡ�#r#r  �����书�����֣������书�ߵ��Ǹ���һ·����·�򵥣������޴������ϣ��ѧϰ��ʵ�õ��书����Ӧ�ðݵ������׼����°���")
	elseif Menpai == OR_SHAOLIN then
		AddText(sceneId,"  "..PlayerSex.."������书�����ÿ찡��#r#r  ��Ҳ�ܾ�û�лص�����ǳ�����ʦ���Ǻ�ʦ�ֵ��ǡ�")
	else
		AddText(sceneId,"  �þ�û�м������ˣ��������������ʣ����ϧû�������������¡�")
	end
	
	if	GetLevel( sceneId, selfId)<=10	then
		AddNumText(sceneId,x002038_g_scriptId,"ȥ�����¿���",-1,0)
	end
	for i, eventId in x002038_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x002038_OnDefaultEvent( sceneId, selfId,targetId )
	x002038_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x002038_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if IsHaveMission(sceneId,selfId,4021) > 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"�������˻���������������վ����Ϊ���ṩ���ͷ���");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else	
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 9,95,146)
		end
	else
		for i, findId in x002038_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
				return
			end
		end
	end
end

--**********************************
--���ܴ�NPC������
--**********************************
function x002038_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002038_g_eventList do
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
function x002038_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��Ҫ����NPC���¼��б�
	for i, findId in x002038_g_eventList do
		if missionScriptId == findId then
			x002038_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�������Ѿ���������
--**********************************
function x002038_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002038_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ�����������
--**********************************
function x002038_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002038_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x002038_OnDie( sceneId, selfId, killerId )
end