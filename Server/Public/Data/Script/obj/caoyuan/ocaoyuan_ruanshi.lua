--阮实

--脚本号
x020002_g_scriptId = 020002

--所拥有的事件ID列表
x020002_g_eventList={211100,211109}	

--**********************************
--事件列表
--**********************************
function x020002_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"  你就是大侠"..PlayerName.." ？我早就从雁北的兄弟那里听到您的大名了。#r   既然到了草原，您就带着我们这些汉人翻身吧。我娘我哥和契丹人相处久了，都已经习惯，快忘记自己是大宋的子民了。#r    其实...我就生在这里，从来还没有踏足过大宋的土地呢。#r   请大侠帮助我们吧。#r")
	for i, eventId in x020002_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x020002_OnDefaultEvent( sceneId, selfId,targetId )
	x020002_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x020002_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x020002_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x020002_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x020002_g_eventList do
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
function x020002_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x020002_g_eventList do
		if missionScriptId == findId then
			x020002_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x020002_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x020002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x020002_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x020002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x020002_OnDie( sceneId, selfId, killerId )
end
