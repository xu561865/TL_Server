--李工部

--脚本号
x002033_g_scriptId = 002033


--所拥有的事件ID列表
x002033_g_eventList={210233,210234,210235,210236}

--**********************************
--事件列表
--**********************************
function x002033_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	AddText(sceneId,"  "..PlayerName..PlayerSex.."，马上就要武林大会了，武林人士纷涌而至，是不是该奏明皇上多修建一些酒肆客栈才好。#r#r  在野外冒险的时候，如果遇到了野兽的头目，不要轻易放过它们啊。#r#r  如果你能从怪物头目身上搜出什么好的食材，还可以把它交给我，换取皇上御赐的装备。")
	for i, eventId in x002033_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002033_OnDefaultEvent( sceneId, selfId,targetId )
	x002033_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002033_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002033_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002033_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002033_g_eventList do
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
function x002033_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002033_g_eventList do
		if missionScriptId == findId then
			x002033_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002033_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002033_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002033_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002033_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002033_OnDie( sceneId, selfId, killerId )
end
