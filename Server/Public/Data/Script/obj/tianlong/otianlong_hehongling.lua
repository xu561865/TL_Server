--天龙NPC
--何红绫
--普通

--**********************************
--事件交互入口
--**********************************
function x013012_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"何红绫，家属")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
