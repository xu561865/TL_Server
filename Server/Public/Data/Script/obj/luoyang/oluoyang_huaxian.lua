--洛阳NPC
--花仙
--普通

--**********************************
--事件交互入口
--**********************************
function x000094_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是花仙，管理结婚")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
