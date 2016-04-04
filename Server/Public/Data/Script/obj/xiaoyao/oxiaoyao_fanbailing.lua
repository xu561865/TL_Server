--逍遥NPC
--范百龄
--普通

--**********************************
--事件交互入口
--**********************************
function x014002_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"范百龄~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
