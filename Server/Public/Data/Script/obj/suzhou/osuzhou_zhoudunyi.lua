--苏州NPC
--周敦颐
--一般

--**********************************
--事件交互入口
--**********************************
function x001006_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"年轻人，我看好你！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
