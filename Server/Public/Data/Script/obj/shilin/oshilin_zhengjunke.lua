--石林NPC
--郑君可
--普通

--**********************************
--事件交互入口
--**********************************
function x026005_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是郑君可~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
