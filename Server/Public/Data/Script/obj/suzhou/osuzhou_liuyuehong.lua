--苏州NPC
--柳月虹
--一般

--**********************************
--事件交互入口
--**********************************
function x001025_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"从现在开始，你只许疼我一个，要宠我，不许骗我，答应我的每一件事情都要做到。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
