--洛阳NPC
--月老
--普通

--脚本号
x000093_g_scriptId = 000093

--目标NPC
x000093_g_name	="月老"

--所拥有的事件ID列表 {结婚, 离婚, 强制离婚}
x000093_g_RelationEventList={806003,806005,806004}

--**********************************
--事件交互入口
--**********************************
function x000093_OnDefaultEvent( sceneId, selfId, targetId )
	x000093_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表
--**********************************
function x000093_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "月老，管理婚姻。")
		for i, eventId in x000093_g_RelationEventList do
			CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x000093_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x000093_g_RelationEventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			x000093_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000093_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000093_g_RelationEventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x000093_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000093_g_RelationEventList do
		if missionScriptId == findId then
			x000093_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end
