--洛阳NPC
--金六爷
--普通

--**********************************
--事件交互入口
--**********************************
function x000100_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"金六爷，元宝商人")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
