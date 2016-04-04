--星宿NPC
--红玉
--普通

--**********************************
--事件交互入口
--**********************************
function x016002_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是红玉~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
