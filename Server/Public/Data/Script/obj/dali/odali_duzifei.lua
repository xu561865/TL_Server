--大理NPC		烹饪   1烹饪技能学习 2烹饪技能说明
--杜子飞
--普通

--脚本号
x002061_g_ScriptId = 002061

--所拥有的事件Id列表
elevelup_pengren = 713561
edialog_pengren = 713515
--所拥有的事件ID列表
x002061_g_eventList={elevelup_pengren}	--,edialog_pengren}	
MessageNum = 1		--MessageNum是对话编号，用于调用不同对话
--**********************************
--事件列表
--**********************************
function x002061_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"烹饪可是一项需要耐心的技能，需要常常练习才可以提高的。要想学习和提高烹饪的技能就经常来我这里看看吧！")
	AddNumText(sceneId,x002061_g_ScriptId,"怎样做馒头？",-1,0)
	for i, eventId in x002061_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002061_OnDefaultEvent( sceneId, selfId,targetId )
	x002061_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002061_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText() == 0	then
		BeginEvent(sceneId)
			AddText(sceneId,"  最简单的食物就是馒头。#r#r  技能窗口有一页为“生活技能”，其中有“烹饪”技能，在烹饪的描述中点击“制作”，就会出现烹饪窗口，选择“馒头配方”，进行“制造”，就可以看到背包里热气腾腾的馒头了。#r#r  做馒头无需材料，但还是要耗费一些活力的。尝尝看吧。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	for i, findId in x002061_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x002061_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002061_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002061_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,ABILITY_PENGREN )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x002061_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002061_g_eventList do
		if missionScriptId == findId then
			x002061_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002061_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002061_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002061_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002061_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002061_OnDie( sceneId, selfId, killerId )
end
