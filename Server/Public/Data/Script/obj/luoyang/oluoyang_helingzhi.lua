--脚本号
x000087_g_scriptId = 000087

--所拥有的事件ID列表
x000087_g_eventList={801011}

--**********************************
--事件交互入口
--**********************************
--function x000087_OnDefaultEvent( sceneId, selfId,targetId )
--	for i, eventId in x000087_g_eventList do
--		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
--	end
--end

function x000087_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"只要你有染发剂就可以改变头发的颜色了。")
		
		AddNumText(sceneId,x000087_g_scriptId,"修改发色",-1,2)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x000087_OnEventRequest( sceneId, selfId, targetId, eventId )

	CallScriptFunction( 801011, "OnEnumerate",sceneId, selfId, targetId )

end
