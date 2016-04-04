--洛阳NPC
--宗喀班
--普通

--**********************************
--事件交互入口
--**********************************
function x000042_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"洛阳城的阳光，远比逻些城的阳光柔和。真不适应……")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
