--武当NPC
--林灵素
--普通

--**********************************
--事件交互入口
--**********************************
function x012003_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"……")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
