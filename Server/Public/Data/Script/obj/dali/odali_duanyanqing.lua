--段延庆

--脚本号
x002016_g_scriptId = 002016

--所拥有的事件ID列表
x002016_g_eventList={201801,201901, 210225, 210226, 210227, 210228, 210229}		--,201802

--**********************************
--事件列表
--**********************************
function x002016_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"小兄弟，我是看你心地还不错，所以才劝你不必把自己打扮成‘大侠’、‘善人’这些恶心模样。#r#r 那些大侠、那些善人，你现在看他起高楼、看他宴宾客、看他夜夜笙歌，哈哈，我看到的是他就要楼塌了，国破了。");
	for i, eventId in x002016_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002016_OnDefaultEvent( sceneId, selfId,targetId )
	x002016_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002016_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002016_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002016_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002016_g_eventList do
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
function x002016_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002016_g_eventList do
		if missionScriptId == findId then
			x002016_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002016_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002016_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002016_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002016_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002016_OnDie( sceneId, selfId, killerId )
end
