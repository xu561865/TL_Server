--大理NPC
--宠物猫
--普通

--**********************************
--事件交互入口
--**********************************
function x002066_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"喵~~~~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
