--苏州NPC
--王夫人
--一般

--**********************************
--事件交互入口
--**********************************
function x001021_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"这苏州钱庄也是我们王家的产业。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
