--苏州NPC
--王安石
--一般

--**********************************
--事件交互入口
--**********************************
function x001000_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"天变不足畏，祖宗不足法，流俗之言不足恤。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
