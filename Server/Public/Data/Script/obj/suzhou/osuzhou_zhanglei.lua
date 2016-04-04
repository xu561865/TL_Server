--苏州NPC
--张耒
--一般

--**********************************
--事件交互入口
--**********************************
function x001004_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你也是来参加考试的吗？")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
