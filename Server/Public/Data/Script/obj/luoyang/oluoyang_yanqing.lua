--洛阳NPC
--燕青
--普通

--**********************************
--事件交互入口
--**********************************
function x000034_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"姐姐原是天上之人，来到这污秽的人间，实属可惜啊。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
