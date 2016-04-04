--大理NPC 采药技能NPC   包含功能：1采药技能的学习 2讲解采药技能
--刘寄奴
--普通

--脚本号
x002049_g_ScriptId = 002049

--商店编号
x002049_g_shoptableindex=73

--所拥有的事件Id列表
estudy_caiyao = 713509
elevelup_caiyao = 713568
edialog_caiyao = 713608
--所拥有的事件ID列表
x002049_g_eventList={estudy_caiyao,elevelup_caiyao}	--,edialog_caiyao}	
--MessageNum = 1		--MessageNum是对话编号，用于调用不同对话
--**********************************
--事件列表
--**********************************
function x002049_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"采药南山下，浪迹红尘中。相逢总是缘。一笑便成空。想学习和提高采药技能就经常来我这里看看吧！")
	for i, eventId in x002049_g_eventList do
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
function x002049_OnDefaultEvent( sceneId, selfId,targetId )
	x002049_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002049_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText() == ABILITY_TEACHER_SHOP	then
		DispatchShopItem( sceneId, selfId,targetId, x002049_g_shoptableindex )
	end
	for i, findId in x002049_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x002049_g_ScriptId )
		return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002049_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002049_g_eventList do
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
function x002049_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002049_g_eventList do
		if missionScriptId == findId then
			x002049_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002049_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002049_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002049_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002049_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002049_OnDie( sceneId, selfId, killerId )
end
