--洛阳NPC		制药npc		1学习制药技能		2中医技能说明
--张明景
--普通

--脚本号
x000108_g_ScriptId = 000108

--所拥有的事件Id列表
estudy_zhiyao = 713503
elevelup_zhiyao = 713562
edialog_zhiyao = 713602
--所拥有的事件ID列表
x000108_g_eventList={estudy_zhiyao,elevelup_zhiyao}	--,edialog_zhiyao}	
MessageNum = 1		--MessageNum是对话编号，用于调用不同对话
--**********************************
--事件列表
--**********************************
function x000108_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"良药苦口，你到了10级我就可以教给你制药技能。")
	for i, eventId in x000108_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000108_OnDefaultEvent( sceneId, selfId,targetId )
	x000108_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000108_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x000108_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x000108_g_ScriptId )
		return
	end
end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000108_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000108_g_eventList do
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
function x000108_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000108_g_eventList do
		if missionScriptId == findId then
			x000108_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000108_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000108_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000108_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000108_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000108_OnDie( sceneId, selfId, killerId )
end
