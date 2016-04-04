--洛阳NPC
--毕昇
--普通

--脚本号
x000012_g_scriptId = 000012

--目标NPC
x000012_g_name	="毕昇"

--所拥有的事件ID列表 {结婚, 离婚, 强制离婚, 收徒, 出师, 叛师, 逐出师门, 结拜, 断绝关系, 毁约}
x000012_g_RelationEventList={701602,806003,806005,806004,806008,806007,806006,806009} --,806001,806000,806002}

--任务名

--**********************************
--事件交互入口
--**********************************
function x000012_OnDefaultEvent( sceneId, selfId, targetId )
	x000012_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表
--**********************************
function x000012_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "小的现在啥也不提供了！～～")
--		for i, eventId in x000012_g_RelationEventList do
--			CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId )
--		end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x000012_OnEventRequest( sceneId, selfId, targetId, eventId )
	--收徒
	if eventId == 806008 then
		CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
		return
	end

	--开除徒弟需要指定开除第几个
	if eventId == 806009 then
		CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId, GetNumText() )
		x000012_UpdateEventList( sceneId, selfId, targetId )
		return
	end

	for i, findId in x000012_g_RelationEventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			x000012_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000012_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000012_g_RelationEventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x000012_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000012_g_RelationEventList do
		if missionScriptId == findId then
			x000012_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end
