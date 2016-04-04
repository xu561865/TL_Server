--洛阳NPC
--程颢
--普通

--**********************************
--事件交互入口
--**********************************
function x000008_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我弟弟的才学在我之上，但他太容易冲动了。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
