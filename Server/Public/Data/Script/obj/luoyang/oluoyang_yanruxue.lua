--脚本号
x000088_g_scriptId = 000088

--所拥有的事件ID列表
x000088_g_eventList={801010}

--**********************************
--事件交互入口
--**********************************
--function x000088_OnDefaultEvent( sceneId, selfId,targetId )
--	for i, eventId in x000088_g_eventList do
--		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
--	end
--end

function x000088_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"心情不好么？为什么不换个发型呢？")
		
		AddNumText(sceneId,x000088_g_scriptId,"修改发型",-1,1)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x000088_OnEventRequest( sceneId, selfId, targetId, eventId )

		CallScriptFunction( 801010, "OnEnumerate",sceneId, selfId, targetId )
end
