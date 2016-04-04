--少林NPC
--慧方
--普通

x009013_g_scriptId = 009013
--所拥有的事件ID列表
x009013_g_eventList={220000,220001,220002,220003,220004,220005,220006,220007,220008,220009,220010,220011,220012,220013,220014,220015,220016,220017,220018,220019,220020,220021,220022,220023,220024,220025,220026,220027}
--**********************************
--事件交互入口
--**********************************
function x009013_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是慧方，我发任务")
		CallScriptFunction( x009013_g_eventList[1], "OnEnumerate",sceneId, selfId, targetId )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x009013_OnDefaultEvent( sceneId, selfId,targetId )
	x009013_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x009013_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x009013_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x009013_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x009013_g_eventList do
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
function x009013_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x009013_g_eventList do
		if missionScriptId == findId then
			x009013_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x009013_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x009013_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x009013_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x009013_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x009013_OnDie( sceneId, selfId, killerId )
end
