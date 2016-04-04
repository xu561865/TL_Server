--苏州NPC
--魏真
--一般

--**********************************
--事件交互入口
--**********************************
function x001035_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"梅花桩上打架才见功夫")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
