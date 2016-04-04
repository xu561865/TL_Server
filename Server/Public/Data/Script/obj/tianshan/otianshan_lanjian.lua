--天山NPC
--兰剑
--普通

x017002_g_scriptId = 009002

--**********************************
--事件交互入口
--**********************************
function x017002_OnDefaultEvent( sceneId, selfId,targetId )
	x017002_g_MenPai = GetMenPai(sceneId, selfId)
	if x017002_g_MenPai == 7 then
		BeginEvent(sceneId)
			AddText(sceneId,"你找大师姐有何事啊？")
			AddNumText(sceneId, x017002_g_scriptId, "学习技能",-1,0)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"我是兰剑")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x017002_OnEventRequest( sceneId, selfId, targetId, eventId )
	DispatchXinfaLevelInfo( sceneId, selfId, targetId, 7 );
end
