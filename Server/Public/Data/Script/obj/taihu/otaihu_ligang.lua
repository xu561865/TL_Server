--太湖 李纲

--脚本号
x004002_g_scriptId = 004002

--所拥有的事件ID列表
x004002_g_eventList={210400, 210401, 210402, 210403, 210404}	

--**********************************
--事件列表
--**********************************
function x004002_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	
	local IsDone470 = IsMissionHaveDone(sceneId,selfId,470)
	local IsDone472 = IsMissionHaveDone(sceneId,selfId,472)
	local IsDone473 = IsMissionHaveDone(sceneId,selfId,473)	
		
	
	if(IsDone470 == 0) then	
		AddText(sceneId,  "这鬼地方遍地都是讨厌的鳄鱼，越看越闹心……去帮我杀掉他们！")
	elseif(IsDone472 == 0) then	
		AddText(sceneId, "去军营大门和酒馆之间的路上，找到神秘的信使，干掉他，他身上很有可能有一颗蜡丸。")
 	elseif(IsDone473 == 0) then	
		AddText(sceneId,  "去太湖酒店找到酒客曹纯，他会告诉你一些情况。")			    				
	end
	
	for i, eventId in x004002_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x004002_OnDefaultEvent( sceneId, selfId,targetId )
	x004002_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x004002_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x004002_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x004002_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x004002_g_eventList do
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
function x004002_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x004002_g_eventList do
		if missionScriptId == findId then
			x004002_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x004002_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x004002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x004002_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x004002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x004002_OnDie( sceneId, selfId, killerId )
end
