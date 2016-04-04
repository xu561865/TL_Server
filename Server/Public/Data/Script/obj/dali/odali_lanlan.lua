--大理NPC
--兰兰
--普通

--**********************************
--事件交互入口
--**********************************
function x002052_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"王妃非常担心我们家公子呢。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
