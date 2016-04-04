--苏州NPC
--艾虎
--一般

--**********************************
--事件交互入口
--**********************************
function x001031_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"艾虎，虫鸟坊")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
