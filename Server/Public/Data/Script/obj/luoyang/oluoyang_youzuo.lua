--洛阳NPC
--游酢
--普通

--**********************************
--事件交互入口
--**********************************
function x000039_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"程老师不见我们，我们就在这里等到下雪为止。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
