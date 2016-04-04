--苏州NPC
--郑天寿
--一般

--**********************************
--事件交互入口
--**********************************
function x001048_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"郑天寿，苏州擂台管理员")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
