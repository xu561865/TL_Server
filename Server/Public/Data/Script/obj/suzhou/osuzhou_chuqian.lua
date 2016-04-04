--苏州NPC
--楚衍
--一般

--**********************************
--事件交互入口
--**********************************
function x001014_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是楚衍")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
