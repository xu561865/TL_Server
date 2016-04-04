--苏州NPC
--风波恶
--一般

--**********************************
--事件交互入口
--**********************************
function x001019_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"想打架吗？")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
