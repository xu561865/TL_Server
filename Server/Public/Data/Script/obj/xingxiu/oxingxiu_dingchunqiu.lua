--星宿NPC
--丁春秋
--普通

--**********************************
--事件交互入口
--**********************************
function x016000_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是丁春秋~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
