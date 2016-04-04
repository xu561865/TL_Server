--洛阳NPC
--康敏
--普通

--**********************************
--事件交互入口
--**********************************
function x000018_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"小妇人现在守寡在家，生活孤苦啊。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
