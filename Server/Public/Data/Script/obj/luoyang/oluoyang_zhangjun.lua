--洛阳NPC
--张浚
--普通

--**********************************
--事件交互入口
--**********************************
function x000098_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"张浚，踢球的")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
