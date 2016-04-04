--大理NPC
--武士
--普通

--**********************************
--事件交互入口
--**********************************
function x002065_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"打架的台上请")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
