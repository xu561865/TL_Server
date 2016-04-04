--大理NPC
--金五爷
--元宝商人

--**********************************
--事件交互入口
--**********************************
function x002059_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"有元宝伴身，不愁前路无门！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
