--峨嵋NPC
--萧湘水
--普通

--**********************************
--事件交互入口
--**********************************
function x015007_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"如果你是峨嵋弟子，我可以教你骑凤凰的技能。不过这个技能现在还没做。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
