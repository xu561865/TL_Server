--洛阳NPC 工艺技能NPC   包含功能：1工艺技能的学习 2讲解工艺技能
--龙三少
--普通

--脚本号
x000106_g_ScriptId = 000106

--所拥有的事件Id列表
estudy_gongyi = 713507
elevelup_gongyi = 713566
edialog_gongyi = 713606
--所拥有的事件ID列表
x000106_g_eventList={estudy_gongyi,elevelup_gongyi}		--,edialog_gongyi}	
MessageNum = 1		--MessageNum是对话编号，用于调用不同对话

x000106_g_shoptableindex=66
--**********************************
--事件列表
--**********************************
function x000106_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"你想学习工艺技能么？")
	for i, eventId in x000106_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	AddNumText(sceneId,g_scriptId,"购买图样",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000106_OnDefaultEvent( sceneId, selfId,targetId )
	x000106_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000106_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		DispatchShopItem( sceneId, selfId,targetId, x000106_g_shoptableindex )
	end
	for i, findId in x000106_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x000106_g_ScriptId )
		return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000106_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000106_g_eventList do
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
function x000106_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000106_g_eventList do
		if missionScriptId == findId then
			x000106_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000106_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000106_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000106_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000106_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000106_OnDie( sceneId, selfId, killerId )
end
