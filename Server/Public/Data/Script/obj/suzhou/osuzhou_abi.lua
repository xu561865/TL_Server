--苏州NPC
--阿碧
--一般

--**********************************
--事件交互入口
--**********************************
function x001022_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"公子爷在苏州的日子里总是闷闷不乐。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
