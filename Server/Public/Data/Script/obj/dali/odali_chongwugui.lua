--大理NPC
--宠物龟
--普通

--**********************************
--事件交互入口
--**********************************
function x002067_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"龟")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
