--吕惠卿

--脚本号
x000005_g_scriptId = 000005


--所拥有的事件ID列表
x000005_g_eventList={200502,200601,200602,200603}

--对白状态检验
--g_missionId = 200502

--**********************************
--事件列表
--**********************************
function x000005_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
  if  (IsMissionHaveDone(sceneId,selfId,g_missionId) > 0 ) then
  			AddText(sceneId,"我是吕惠卿。少侠与人为善，将来必堪大用。");
	else			
			AddText(sceneId,"我是吕惠卿，你也是来报仇的吗？")--\n当年我是害得不少人家破人亡，现在我重病缠身，想要我性命易如反掌，想让我低头却是休想。");
	end
	for i, eventId in x000005_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000005_OnDefaultEvent( sceneId, selfId,targetId )
	x000005_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000005_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x000005_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000005_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000005_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x000005_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000005_g_eventList do
		if missionScriptId == findId then
			x000005_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000005_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000005_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000005_OnDie( sceneId, selfId, killerId )
end
