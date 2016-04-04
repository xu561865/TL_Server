--丐帮NPC
--洪通
--普通

--**********************************
--事件交互入口
--**********************************
function x010012_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"洪通，任务发布人")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
