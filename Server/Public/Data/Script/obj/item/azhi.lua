--石林  可怕的真相

--脚本号
x300018_g_scriptId = 300008


--所拥有的事件ID列表
x300018_g_eventList={211708}

--**********************************
--事件交互入口
--**********************************
function x300018_OnDefaultEvent( sceneId, selfId,targetId )
	x300018_OnEventRequest( sceneId, selfId, targetId, 211708 )
end

--**********************************
--刷新事件
--**********************************
function x300018_OnEventRequest( sceneId, selfId, targetId, eventId )
	CallScriptFunction( 211708, "OnDefaultEvent",sceneId, selfId, targetId )
end

--**********************************
--接受此NPC的任务
--**********************************
function x300018_OnMissionAccept( sceneId, selfId, targetId )
	--ret = CallScriptFunction( 211708, "CheckAccept", sceneId, selfId )
	--if ret > 0 then
	--	CallScriptFunction( 211708, "OnAccept", sceneId, selfId )
	--end
	--return
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x300018_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x300018_g_eventList do
		if missionScriptId == findId then
			UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

function x300018_IsSkillLikeScript( sceneId, selfId)
	return 0;
end
