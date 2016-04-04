--峨嵋NPC
--崔绿华
--普通

x015003_g_scriptId = 015003

--**********************************
--事件交互入口
--**********************************
function x015003_OnDefaultEvent( sceneId, selfId,targetId )
	x015003_g_MenPai = GetMenPai(sceneId, selfId)
	if x015003_g_MenPai == 4 then
		BeginEvent(sceneId)
			AddText(sceneId,"你找为师有何事啊？")
			AddNumText(sceneId, x015003_g_scriptId, "学习技能",-1,0)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"我是崔绿华")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x015003_OnEventRequest( sceneId, selfId, targetId, eventId )
	DispatchXinfaLevelInfo( sceneId, selfId, targetId, 4 );
end
