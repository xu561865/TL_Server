--少林NPC
--玄难
--普通

x009002_g_scriptId = 009002

--**********************************
--事件交互入口
--**********************************
function x009002_OnDefaultEvent( sceneId, selfId,targetId )
	x009002_g_MenPai = GetMenPai(sceneId, selfId)
	if x009002_g_MenPai == 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"你找为师有何事啊？")
			AddNumText(sceneId, x009002_g_scriptId, "学习技能",-1,0)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"老衲玄难，施主找贫僧有何事啊？")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x009002_OnEventRequest( sceneId, selfId, targetId, eventId )
	DispatchXinfaLevelInfo( sceneId, selfId, targetId, 0 );
end
