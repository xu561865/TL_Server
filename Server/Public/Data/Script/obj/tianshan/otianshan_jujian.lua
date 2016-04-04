--天山NPC
--菊剑
--普通

--**********************************
--事件交互入口
--**********************************
function x017004_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是菊剑~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
