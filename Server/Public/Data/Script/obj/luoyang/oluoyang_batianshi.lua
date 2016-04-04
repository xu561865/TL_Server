--洛阳NPC
--巴天石
--普通

--**********************************
--事件交互入口
--**********************************
function x000019_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"大理每次参加蹴鞠大赛，都是陪太子读书而已。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
