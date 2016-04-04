--大理NPC
--天仙妹妹
--普通

--**********************************
--事件交互入口
--**********************************
function x002054_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"大理国西倚苍山，北临洱海，风光秀丽，人杰地灵，才会有我这样的天仙妹妹。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
