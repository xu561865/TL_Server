--苏州NPC
--欧阳修
--一般

--**********************************
--事件交互入口
--**********************************
function x001001_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我觉得贺铸的词写得更为出色。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
