--洛阳NPC
--金元宝
--普通

--**********************************
--事件交互入口
--**********************************
function x000075_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我的钱庄在洛阳是独一无二的。声誉，当然是洛阳最好的。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
