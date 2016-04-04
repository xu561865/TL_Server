--洛阳NPC
--乔复盛
--普通

--**********************************
--事件交互入口
--**********************************
function x000109_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我可以教给你自己开店的办法。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
