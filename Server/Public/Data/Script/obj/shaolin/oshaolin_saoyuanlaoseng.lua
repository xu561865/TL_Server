--大理NPC
--扫院老僧
--普通

--**********************************
--事件交互入口
--**********************************
function x009008_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"扫院老僧")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
