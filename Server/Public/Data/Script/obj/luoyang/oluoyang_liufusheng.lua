--洛阳NPC
--柳复生
--普通

--**********************************
--事件交互入口
--**********************************
function x000097_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"柳复生，踢球的")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
