--洛阳NPC
--漕运使
--漕运循环任务

--脚本号
x311008_g_scriptId = 311008

--所拥有的事件ID列表
x311008_g_eventList={311010}	

--**********************************
--事件列表
--**********************************
function x311008_UpdateEventList( sceneId, selfId,targetId )

	for i, eventId in x311008_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end

end

--**********************************
--事件交互入口
--**********************************
function x311008_OnDefaultEvent( sceneId, selfId,targetId )
	x311008_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x311008_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x311008_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end
