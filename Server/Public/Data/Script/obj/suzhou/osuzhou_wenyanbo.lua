--苏州NPC
--文彦博
--一般

--**********************************
--事件交互入口
--**********************************
function x001009_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你是第一次来苏州吧，快去看看苏州园林的美景吧。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
