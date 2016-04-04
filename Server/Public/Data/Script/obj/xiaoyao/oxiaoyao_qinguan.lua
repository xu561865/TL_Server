--逍遥NPC
--秦观
--普通

--**********************************
--事件交互入口
--**********************************
function x014008_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"秦观，发布任务的")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
