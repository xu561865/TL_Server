--天龙NPC
--伍忠
--普通

--**********************************
--事件交互入口
--**********************************
function x013009_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"伍忠，大理官员")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
