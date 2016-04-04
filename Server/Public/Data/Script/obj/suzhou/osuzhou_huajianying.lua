--苏州NPC
--花剑影
--一般

--**********************************
--事件交互入口
--**********************************
function x001029_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"本镖局曾经创造了运镖一百万里无事故的纪录。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
