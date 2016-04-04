--大理NPC
--褚万里
--普通

--**********************************
--事件交互入口
--**********************************
function x002011_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"听说我家公子去太湖了，也不知道真假，王爷和王妃都快要担心死了。xxx少侠/姑娘，可曾听到过我家公子的消息？")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
