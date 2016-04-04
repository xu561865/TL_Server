--明教NPC
--林岩
--普通

--**********************************
--事件交互入口
--**********************************
function x011013_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"林岩，发布任务")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
