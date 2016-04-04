--洛阳NPC		种植npc   1种植升级   2种植技能说明
--刘亦农
--普通

--脚本号
x000105_g_ScriptId = 000156

--所拥有的事件Id列表
estudy_zhongzhi = 713511
elevelup_zhongzhi = 713570
edialog_zhongzhi = 713610
x000105_g_eventList={estudy_zhongzhi,elevelup_zhongzhi}		--,edialog_zhongzhi}
--MessageNum = 1		--MessageNum是对话编号，用于调用不同对话
--**********************************
--事件列表
--**********************************
function x000105_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		if GetLevel(sceneId,selfId) < 10 then
			AddText(sceneId,"如果你到了10级，我就可以教给你种植庄稼的本领了。")
		else
			AddText(sceneId,"天气这么好，正是种植庄稼的好时机啊。")
		end
	for i, eventId in x000105_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000105_OnDefaultEvent( sceneId, selfId,targetId )
	x000105_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000105_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x000105_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x000105_g_ScriptId )
		return
	end
end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000105_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000105_g_eventList do
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
function x000105_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000105_g_eventList do
		if missionScriptId == findId then
			x000105_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000105_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000105_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000105_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000105_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000105_OnDie( sceneId, selfId, killerId )
end
