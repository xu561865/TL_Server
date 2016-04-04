--剑阁 姜末

--脚本号
x007004_g_scriptId = 007004

--所拥有的事件ID列表
x007004_g_eventList={210700, 210701, 210706}	

--**********************************
--事件列表
--**********************************
function x007004_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	
	local IsDone500 = IsMissionHaveDone(sceneId,selfId,500)	
	local IsDone501 = IsMissionHaveDone(sceneId,selfId,501)	
	local IsDone506 = IsMissionHaveDone(sceneId,selfId,506)		
	
	if(IsDone500 == 0) then	
		AddText(sceneId, "帮我去杀死10个蜀道白猿") 
	elseif(IsDone501 == 0) then	
		AddText(sceneId, "帮我去杀死10个蜀道黑猿")
	elseif(IsDone506 == 0) then	
		AddText(sceneId, "帮我去杀死10个鬼面侏儒")
	else
		AddText(sceneId, "我没事了")
	end
	for i, eventId in x007004_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x007004_OnDefaultEvent( sceneId, selfId,targetId )
	x007004_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x007004_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x007004_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x007004_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x007004_g_eventList do
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
function x007004_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x007004_g_eventList do
		if missionScriptId == findId then
			x007004_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x007004_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x007004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x007004_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x007004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x007004_OnDie( sceneId, selfId, killerId )
end
