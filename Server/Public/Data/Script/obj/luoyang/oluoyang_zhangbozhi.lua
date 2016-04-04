--洛阳NPC
--张伯志
--普通

--**********************************
--事件交互入口
--**********************************
function x000078_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你想要截镖吗……哦，我是说你想要听音乐吗？")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
