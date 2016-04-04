--天龙NPC
--本观
--普通

x013003_g_scriptId = 013003

--**********************************
--事件交互入口
--**********************************
function x013003_OnDefaultEvent( sceneId, selfId,targetId )
	x013003_g_MenPai = GetMenPai(sceneId, selfId)
	if x013003_g_MenPai == 6 then
		BeginEvent(sceneId)
			AddText(sceneId,"你找为师有何事啊？")
			AddNumText(sceneId, x013003_g_scriptId, "学习技能",-1,0)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"老衲本观，施主找贫僧有何事啊？")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x013003_OnEventRequest( sceneId, selfId, targetId, eventId )
	DispatchXinfaLevelInfo( sceneId, selfId, targetId, 6 );
end
