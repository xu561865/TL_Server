--天龙NPC
--任飞燕
--普通

--**********************************
--事件交互入口
--**********************************
function x013013_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"任飞燕，家眷")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
