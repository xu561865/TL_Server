--太湖 呼延庆

--脚本号
x004001_g_scriptId = 004001

--所拥有的事件ID列表
x004001_g_eventList={210405, 210406, 210407, 210408, 210409}	

--**********************************
--事件列表
--**********************************
function x004001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	
	local IsDone475 = IsMissionHaveDone(sceneId,selfId,475)	
	local IsDone476 = IsMissionHaveDone(sceneId,selfId,476)	
	local IsDone477 = IsMissionHaveDone(sceneId,selfId,477)	
	local IsDone478 = IsMissionHaveDone(sceneId,selfId,478)	
	local IsDone479 = IsMissionHaveDone(sceneId,selfId,479)
		
	
	if(IsDone475 == 0) then	
		AddText(sceneId, "现在你先去杀死一些华南虎，为部队的驻扎扫清障碍吧。")
	elseif(IsDone476 == 0) then	
		AddText(sceneId, "去杀死10个稻草人，赢得本应该属于我们的声望。")	
	elseif(IsDone477 == 0) then	
		AddText(sceneId, "去杀死10个水贼，赢得本应该属于我们的声望。")	
	elseif(IsDone478 == 0) then	
		AddText(sceneId, " 帮我把这封信送给我的老同学林世长。")
	elseif(IsDone479 == 0) then	
		AddText(sceneId, "去雁门关前线找到周无畏将军。")
	end
	
	for i, eventId in x004001_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x004001_OnDefaultEvent( sceneId, selfId,targetId )
	x004001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x004001_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x004001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x004001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x004001_g_eventList do
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
function x004001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x004001_g_eventList do
		if missionScriptId == findId then
			x004001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x004001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x004001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x004001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x004001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x004001_OnDie( sceneId, selfId, killerId )
end
