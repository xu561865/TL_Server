--洛阳NPC
--田骁鸣
--普通

--**********************************
--事件交互入口
--**********************************
function x000104_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"田骁鸣，卖马的")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
