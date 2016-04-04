--武当NPC
--张君羡
--普通

--**********************************
--事件交互入口
--**********************************
function x012007_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"如果你是武当弟子，我可以教你骑鹤的技能。不过这个技能现在还没做。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
