--天龙NPC
--林国清
--普通

--**********************************
--事件交互入口
--**********************************
function x013008_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"林国清，官员")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
