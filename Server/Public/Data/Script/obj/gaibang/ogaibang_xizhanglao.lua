--丐帮NPC
--奚长老
--普通

--**********************************
--事件交互入口
--**********************************
function x010007_OnDefaultEvent( sceneId, selfId,targetId )
	x010007_g_MenPai = GetMenPai(sceneId, selfId)
	if x010007_g_MenPai == 2 then
		BeginEvent(sceneId)
			AddText(sceneId,"你找为师有何事啊？")
			AddNumText(sceneId, g_scriptId, "学习技能",-1,0)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"你找我有何事啊？")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

function x010007_OnEventRequest( sceneId, selfId, targetId, eventId )
	DispatchXinfaLevelInfo( sceneId, selfId, targetId, 2 );
end
