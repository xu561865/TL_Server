--苏州NPC
--颜查散
--一般

--**********************************
--事件交互入口
--**********************************
function x001033_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"颜查散，书生")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
