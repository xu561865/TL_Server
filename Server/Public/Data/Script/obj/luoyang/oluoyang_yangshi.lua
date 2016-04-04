--洛阳NPC
--杨时
--普通

--**********************************
--事件交互入口
--**********************************
function x000040_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"程老师不见我们我们就不走。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
