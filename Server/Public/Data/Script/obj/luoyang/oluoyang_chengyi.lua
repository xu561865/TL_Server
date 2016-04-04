--洛阳NPC
--程颐
--普通

--**********************************
--事件交互入口
--**********************************
function x000009_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我早就注意你的行为了！在洛阳城内胡乱跑来跑去的，成何体统？")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
