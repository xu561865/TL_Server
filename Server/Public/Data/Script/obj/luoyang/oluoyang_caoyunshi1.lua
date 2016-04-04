--洛阳NPC
--漕运使
--漕运循环任务

--脚本号
x311006_g_scriptId = 311006

--所拥有的事件ID列表
x311006_g_eventList={311010}	

--**********************************
--事件列表
--**********************************
function x311006_UpdateEventList( sceneId, selfId,targetId )

	for i, eventId in x311006_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end

end

--**********************************
--事件交互入口
--**********************************
function x311006_OnDefaultEvent( sceneId, selfId,targetId )
	x311006_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x311006_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x311006_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

