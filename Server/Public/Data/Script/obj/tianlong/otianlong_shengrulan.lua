--天龙NPC
--盛如兰
--普通

--**********************************
--事件交互入口
--**********************************
function x013011_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"盛如兰，家眷")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
