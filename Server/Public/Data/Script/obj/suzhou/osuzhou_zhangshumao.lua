--苏州NPC
--张树茂
--一般

--**********************************
--事件交互入口
--**********************************
function x001041_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"张树茂，苏州官员")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
