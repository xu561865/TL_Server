--大理NPC
--王颖
--普通

--**********************************
--事件交互入口
--**********************************
function x002025_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"君子用财取之有道。我们王氏钱庄可是在各地都有分号的！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
