--苏州NPC
--雪竹莲
--一般

--**********************************
--事件交互入口
--**********************************
function x001036_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"长发道人雪竹莲")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
