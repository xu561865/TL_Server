--明教NPC
--厉天佑
--普通

--**********************************
--事件交互入口
--**********************************
function x011011_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"厉天佑，传授骑骆驼技能")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
