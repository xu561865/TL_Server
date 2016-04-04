--木人巷副本任务npc

--脚本号
x013007_g_scriptId = 402010


--所拥有的事件ID列表
x013007_g_eventList={401010}

--**********************************
--事件列表
--**********************************
function x013007_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerName=GetName(sceneId,selfId)
		AddText(sceneId,"  "..PlayerName.." ，快来吧，现在只能进副本，还是大理城用过的。以后给你加新的。\n")
		for i, findId in x013007_g_eventList do
			CallScriptFunction( x013007_g_eventList[i], "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x013007_OnDefaultEvent( sceneId, selfId,targetId )
	x013007_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x013007_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x013007_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x013007_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x013007_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x013007_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x013007_g_eventList do
		if missionScriptId == findId then
			x013007_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x013007_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x013007_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x013007_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x013007_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x013007_OnDie( sceneId, selfId, killerId )
end

