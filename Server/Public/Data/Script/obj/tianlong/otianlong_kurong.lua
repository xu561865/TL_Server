--天龙NPC
--枯荣
--普通

--**********************************
--事件交互入口
--**********************************
function x013000_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"枯荣大师")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
