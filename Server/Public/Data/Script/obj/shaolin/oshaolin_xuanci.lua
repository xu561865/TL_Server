--少林NPC
--玄慈
--普通

--**********************************
--事件交互入口
--**********************************
function x009005_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我觉得玄悲师弟圆寂，与大理段家并无干系。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
