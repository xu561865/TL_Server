--洛阳NPC
--镖头
--普通

--**********************************
--事件交互入口
--**********************************
function x000072_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"本镖局黑白两道都有无数的朋友，因此才能保证连续十年不丢一趟镖。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
