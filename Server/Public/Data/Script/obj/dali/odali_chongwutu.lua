--大理NPC
--宠物兔
--普通

--**********************************
--事件交互入口
--**********************************
function x002068_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"兔兔")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
