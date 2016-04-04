--洛阳NPC
--张小泉
--普通

--**********************************
--事件交互入口
--**********************************
function x000031_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"皇帝陛下要我们来洛阳可不是来玩的。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
