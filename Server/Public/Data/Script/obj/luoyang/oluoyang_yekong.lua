--洛阳NPC
--业空
--普通

--**********************************
--事件交互入口
--**********************************
function x000095_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"业空，小和尚")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
