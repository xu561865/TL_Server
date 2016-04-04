--星宿NPC
--出尘子
--普通

--**********************************
--事件交互入口
--**********************************
function x016005_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是出尘子~~")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
