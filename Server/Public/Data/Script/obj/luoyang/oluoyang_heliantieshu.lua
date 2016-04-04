--洛阳NPC
--赫连铁树
--普通

--**********************************
--事件交互入口
--**********************************
function x000033_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你说得很对，就这么办。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
