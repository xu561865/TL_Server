--天山NPC
--竹剑
--普通

--**********************************
--事件交互入口
--**********************************
function x017003_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是竹剑~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
