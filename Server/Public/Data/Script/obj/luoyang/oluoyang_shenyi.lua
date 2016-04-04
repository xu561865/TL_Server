--洛阳NPC
--神医
--普通

--**********************************
--事件交互入口
--**********************************
function x000064_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你需要治疗吗？")
		AddNumText(sceneId,g_scriptId,"治疗",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x000064_OnEventRequest( sceneId, selfId, targetId, eventId )
	RestoreHp( sceneId, selfId)
	BeginEvent(sceneId)
		AddText(sceneId,"你的生命值已经恢复");
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
