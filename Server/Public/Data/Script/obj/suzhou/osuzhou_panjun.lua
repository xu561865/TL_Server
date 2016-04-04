--苏州NPC
--潘浚
--一般

--**********************************
--事件交互入口
--**********************************
function x001040_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"潘浚，苏州知府。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
