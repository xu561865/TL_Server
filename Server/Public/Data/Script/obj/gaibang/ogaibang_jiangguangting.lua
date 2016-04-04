--丐帮NPC
--蒋光亭
--普通

--**********************************
--事件交互入口
--**********************************
function x010010_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"如果你是丐帮弟子，我可以教你骑狼的技能。不过这个技能现在还没做。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
