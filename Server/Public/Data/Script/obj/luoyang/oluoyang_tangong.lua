--洛阳NPC
--谭公
--普通

--**********************************
--事件交互入口
--**********************************
function x000023_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"这些药材都很不错，冰蟾灵药就用它来配了。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
