--天山NPC
--符敏仪
--普通

--**********************************
--事件交互入口
--**********************************
function x017008_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我来发布任务~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
