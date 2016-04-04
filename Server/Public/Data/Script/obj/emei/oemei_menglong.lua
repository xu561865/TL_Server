--峨嵋NPC
--孟龙
--普通

--**********************************
--事件交互入口
--**********************************
function x015009_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是孟龙，我在峨嵋发布任务")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
