--剑阁 姜桂枝

--脚本号
x007001_g_scriptId = 007001

--所拥有的事件ID列表
x007001_g_eventList={210702, 210708,210709}	

--**********************************
--事件列表
--**********************************
function x007001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	
	local IsDone502 = IsMissionHaveDone(sceneId,selfId,502)	
	local IsDone508 = IsMissionHaveDone(sceneId,selfId,508)	
	local IsDone509 = IsMissionHaveDone(sceneId,selfId,509)		
		
	
	if(IsDone502 == 0) then	
		AddText(sceneId, "拜托你去武侯祠看看吧，也许能找到什么奇怪的人也说不定。")
	elseif(IsDone508 == 0) then	
		AddText(sceneId, "必须去消灭修罗小鬼，才能继续生存。")
	elseif(IsDone509 == 0) then	
		AddText(sceneId, "请你把这封信交给敦煌杨文广，让他出兵来帮助我们。敦煌就在剑阁的北方。")		
	end
	
	for i, eventId in x007001_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x007001_OnDefaultEvent( sceneId, selfId,targetId )
	x007001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x007001_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x007001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x007001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x007001_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x007001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x007001_g_eventList do
		if missionScriptId == findId then
			x007001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x007001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x007001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x007001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x007001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x007001_OnDie( sceneId, selfId, killerId )
end
