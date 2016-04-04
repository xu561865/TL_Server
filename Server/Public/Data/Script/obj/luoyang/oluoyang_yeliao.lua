--洛阳NPC
--业了
--普通

--**********************************
--事件交互入口
--**********************************
function x000096_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"业了，小和尚")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
