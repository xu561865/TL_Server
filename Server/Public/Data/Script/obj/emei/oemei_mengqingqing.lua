--峨嵋NPC
--孟青青
--普通

--**********************************
--事件交互入口
--**********************************
function x015000_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"孟青青")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

