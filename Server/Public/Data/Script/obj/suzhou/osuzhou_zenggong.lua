--苏州NPC
--曾巩
--一般

--**********************************
--事件交互入口
--**********************************
function x001003_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"今年的考生素质很高，尤其是这四个进入决赛的考生。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
