--苏州NPC
--慕容复
--主角

--**********************************
--事件交互入口
--**********************************
function x001015_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"这位少侠，你可曾在附近见过一位吐蕃喇嘛？")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
