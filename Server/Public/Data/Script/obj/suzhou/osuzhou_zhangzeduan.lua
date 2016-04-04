--苏州NPC
--张择端
--一般

--**********************************
--事件交互入口
--**********************************
function x001011_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"再过几日就是清明节了，那时候苏州码头肯定会热闹无比……")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
