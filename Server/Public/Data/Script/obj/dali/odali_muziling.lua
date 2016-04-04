--大理NPC		钓鱼npc		1升级钓鱼技能		2钓鱼技能说明
--穆子陵
--普通

--脚本号
x002050_g_ScriptId = 002050

--商店编号
x002050_g_shoptableindex=73

--所拥有的事件Id列表
estudy_diaoyu = 713510
elevelup_diaoyu = 713569
edialog_diaoyu = 713609
--所拥有的事件ID列表
x002050_g_eventList={estudy_diaoyu,elevelup_diaoyu}	--,edialog_diaoyu}	
--MessageNum = 1		--MessageNum是对话编号，用于调用不同对话
--**********************************
--事件列表
--**********************************
function x002050_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"选好钓位，选准钓饵，备好钓具，练好钓技，才可以钓到好鱼。想学习和提高钓鱼技能就常来我这里看看吧！")
	for i, eventId in x002050_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	--商店选项
	AddNumText(sceneId,g_scriptId,"购买工具",-1,ABILITY_TEACHER_SHOP)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002050_OnDefaultEvent( sceneId, selfId,targetId )
	x002050_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002050_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText() == ABILITY_TEACHER_SHOP	then
		DispatchShopItem( sceneId, selfId,targetId, x002050_g_shoptableindex )
	end
	for i, findId in x002050_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x002050_g_ScriptId )
		return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002050_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002050_g_eventList do
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
function x002050_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002050_g_eventList do
		if missionScriptId == findId then
			x002050_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002050_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002050_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002050_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002050_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002050_OnDie( sceneId, selfId, killerId )
end
