--脚本号
x008001_g_scriptId = 008001

--所拥有的事件ID列表
x008001_g_eventList={210800,210805,210806,210809,210709}

--**********************************
--事件列表
--**********************************
function x008001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"我们马上要顶不住了，"..PlayerName.."，必须放弃玉门关，撤回本土。现在去杀死10只沙坡狼吧。");
	for i, eventId in x008001_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x008001_OnDefaultEvent( sceneId, selfId,targetId )
	x008001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x008001_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x008001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x008001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x008001_g_eventList do
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
function x008001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x008001_g_eventList do
		if missionScriptId == findId then
			x008001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x008001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x008001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x008001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x008001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x008001_OnDie( sceneId, selfId, killerId )
end
