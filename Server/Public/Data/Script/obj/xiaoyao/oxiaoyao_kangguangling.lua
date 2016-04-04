--逍遥NPC
--康广陵
--普通

x014001_g_scriptId = 014001

--**********************************
--事件交互入口
--**********************************
function x014001_OnDefaultEvent( sceneId, selfId,targetId )
	x014001_g_MenPai = GetMenPai(sceneId, selfId)
	if x014001_g_MenPai == 8 then
		BeginEvent(sceneId)
			AddText(sceneId,"你找为师有何事啊？")
			AddNumText(sceneId, x014001_g_scriptId, "学习技能",-1,0)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"我是康广陵，你有何事啊？")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x014001_OnEventRequest( sceneId, selfId, targetId, eventId )
	DispatchXinfaLevelInfo( sceneId, selfId, targetId, 8 );
end
