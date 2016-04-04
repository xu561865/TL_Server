--苏州NPC
--雨墨
--一般

--**********************************
--事件交互入口
--**********************************
function x001034_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"雨墨，颜查散公子的书童")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
