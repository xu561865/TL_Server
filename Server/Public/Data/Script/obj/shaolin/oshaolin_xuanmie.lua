--少林NPC
--玄灭
--普通

--**********************************
--事件交互入口
--**********************************
function x009011_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"如果你是少林弟子，我可以教你骑老虎的技能。不过这个技能现在还没做。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
