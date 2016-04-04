--软老太太

--脚本号
x020001_g_scriptId = 020001

--所拥有的事件ID列表
x020001_g_eventList={211101}	

--**********************************
--事件列表
--**********************************
function x020001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"  孩子，你是阿实的朋友啊，听阿实说你很有本事啊。#r  阿实总是想结交些能打能杀的朋友，不好好帮阿诚和老烈头做事情。#r  向北走就是我们的毡房和马场，阿诚正在那边，今天就在我们毡房休息吧。#r")
	for i, eventId in x020001_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x020001_OnDefaultEvent( sceneId, selfId,targetId )
	x020001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x020001_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x020001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x020001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x020001_g_eventList do
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
function x020001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x020001_g_eventList do
		if missionScriptId == findId then
			x020001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x020001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x020001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x020001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x020001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x020001_OnDie( sceneId, selfId, killerId )
end
