--洛阳NPC
--李妈妈
--普通

--**********************************
--事件交互入口
--**********************************
function x000044_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我女儿现在是洛阳第一名人了，可是她的心事越来越沉重了。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
