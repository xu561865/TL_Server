--洛阳NPC
--朴明善
--普通

--**********************************
--事件交互入口
--**********************************
function x000046_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是朴明善。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
