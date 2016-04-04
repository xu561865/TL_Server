--洛阳NPC     洛阳循环任务
--智清
--普通

--脚本号
x000068_g_scriptId = 000068

--所拥有的事件ID列表
x000068_g_eventList={230000,230001,230002,230003,230004,230005,230006,230007,230008,230009,230010,230011,230012}	


--**********************************
--事件列表
--**********************************
function x000068_UpdateEventList( sceneId, selfId,targetId )
		BeginEvent(sceneId)
		local  PlayerName=GetName(sceneId,selfId)
		AddText(sceneId,"  "..PlayerName.."施主， 见到你太好了。#r#r  你看这白马寺后院，雁门过来的难民实在太多。 一方容身之所、一钵果腹之粥还罢了， 这药品、衣裳、用具实在匮乏，还得麻烦施主多方筹措。#r#r  游侠少年多如棕#r  义胆仁心却不同#r  刀剑并非济世方#r  日行一善是真功#r")
		--for i, eventId in x000068_g_eventList do
			CallScriptFunction( x000068_g_eventList[1], "OnEnumerate",sceneId, selfId, targetId )
		--end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000068_OnDefaultEvent( sceneId, selfId,targetId )
	x000068_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000068_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x000068_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000068_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000068_g_eventList do
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
function x000068_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000068_g_eventList do
		if missionScriptId == findId then
			x000068_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000068_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000068_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000068_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000068_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000068_OnDie( sceneId, selfId, killerId )
end
