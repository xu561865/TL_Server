--天龙NPC
--破痴
--普通

--**********************************
--事件交互入口
--**********************************
function x013006_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"破痴，拈花寺来挂单的")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
