--洛阳NPC
--努尔海
--普通

--**********************************
--事件交互入口
--**********************************
function x000081_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"赫连将军的蹴鞠技术绝对一流。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
