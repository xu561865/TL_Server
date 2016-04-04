--峨嵋NPC
--小茗
--普通

--**********************************
--事件交互入口
--**********************************
function x015004_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"小茗~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
