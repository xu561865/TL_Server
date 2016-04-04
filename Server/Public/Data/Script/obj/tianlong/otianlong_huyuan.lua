--天龙NPC
--护院
--普通

--**********************************
--事件交互入口
--**********************************
function x013019_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"护院")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
