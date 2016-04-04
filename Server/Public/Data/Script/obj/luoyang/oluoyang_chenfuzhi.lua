--洛阳NPC
--陈夫之
--普通

--**********************************
--事件交互入口
--**********************************
function x000112_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"想和别人结拜吗？我可以给你们写金兰谱。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
