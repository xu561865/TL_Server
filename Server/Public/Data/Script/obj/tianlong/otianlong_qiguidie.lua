--天龙NPC
--齐归蝶
--普通

--**********************************
--事件交互入口
--**********************************
function x013010_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"齐归蝶，本因夫人")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
