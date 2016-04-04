--逍遥NPC
--吴领军
--普通

--**********************************
--事件交互入口
--**********************************
function x014004_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"如果你是逍遥弟子，我可以教你骑鹿的技能。不过这个技能现在还没做。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
