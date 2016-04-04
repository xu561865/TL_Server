--洛阳NPC
--游坦之
--普通

--**********************************
--事件交互入口
--**********************************
function x000017_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"阿紫小姐，马上就会没事的，你不要担心。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
