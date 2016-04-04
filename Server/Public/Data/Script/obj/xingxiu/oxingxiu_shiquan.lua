--星宿NPC
--施全
--普通

x016007_g_scriptId = 016007

--**********************************
--事件交互入口
--**********************************
function x016007_OnDefaultEvent( sceneId, selfId,targetId )
	x016007_g_MenPai = GetMenPai(sceneId, selfId)
	if x016007_g_MenPai == 5 then
		BeginEvent(sceneId)
			AddText(sceneId,"你找为师有何事啊？")
			AddNumText(sceneId, x016007_g_scriptId, "学习技能",-1,0)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"我是施全")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x016007_OnEventRequest( sceneId, selfId, targetId, eventId )
	DispatchXinfaLevelInfo( sceneId, selfId, targetId, 5 );
end
