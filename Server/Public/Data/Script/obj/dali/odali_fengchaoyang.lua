--凤朝阳

--脚本号
x002037_g_scriptId = 002037


--所拥有的事件ID列表
x002037_g_eventList={}

--**********************************
--事件列表
--**********************************
function x002037_UpdateEventList( sceneId, selfId,targetId )
    local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	BeginEvent(sceneId)
	AddText(sceneId,"  习武之人，何惧死伤，"..PlayerName..PlayerSex.."，有兴趣来比一场吗？")
	for i, eventId in x002037_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002037_OnDefaultEvent( sceneId, selfId,targetId )
	x002037_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002037_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002037_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002037_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002037_g_eventList do
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
--拒绝此NPC的任务
--**********************************
function x002037_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002037_g_eventList do
		if missionScriptId == findId then
			x002037_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002037_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002037_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002037_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002037_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002037_OnDie( sceneId, selfId, killerId )
end
