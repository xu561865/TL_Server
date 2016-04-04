--洛阳NPC
--书僮
--普通

--**********************************
--事件交互入口
--**********************************
function x000036_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"老爷完成了《资治通鉴》之后，身体已经很虚弱了。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
