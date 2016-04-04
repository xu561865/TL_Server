--武当NPC
--俞远山
--普通


x012010_g_scriptId = 012010

--**********************************
--事件交互入口
--**********************************
function x012010_OnDefaultEvent( sceneId, selfId,targetId )
	x012010_g_MenPai = GetMenPai(sceneId, selfId)
	if x012010_g_MenPai == 3 then
		BeginEvent(sceneId)
			AddText(sceneId,"你找为师有何事啊？")
			AddNumText(sceneId, x012010_g_scriptId, "学习技能",-1,0)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"你找我有什么事？")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x012010_OnEventRequest( sceneId, selfId, targetId, eventId )
	DispatchXinfaLevelInfo( sceneId, selfId, targetId, 3 );
end
