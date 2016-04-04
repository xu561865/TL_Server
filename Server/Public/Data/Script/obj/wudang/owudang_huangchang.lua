--武当NPC
--黄裳
--普通

--**********************************
--事件交互入口
--**********************************
function x012002_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我来发布任务")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
