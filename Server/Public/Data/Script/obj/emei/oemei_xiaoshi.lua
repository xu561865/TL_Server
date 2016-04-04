--峨嵋NPC
--小诗
--普通

--**********************************
--事件交互入口
--**********************************
function x015005_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"小诗~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
