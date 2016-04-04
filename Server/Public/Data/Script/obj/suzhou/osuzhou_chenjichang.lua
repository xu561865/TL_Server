--苏州NPC
--陈季常
--一般

--**********************************
--事件交互入口
--**********************************
function x001024_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"老婆我爱你！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
