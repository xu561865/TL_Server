--完颜斡离不

--脚本号
x022005_g_scriptId = 022005

--所拥有的事件ID列表
x022005_g_eventList={211303}	

--**********************************
--事件列表
--**********************************
function x022005_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"你们宋人都是我的俘虏,都要听我的")
	for i, eventId in x022005_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x022005_OnDefaultEvent( sceneId, selfId,targetId )
	if IsHaveMission(sceneId,selfId,MISSION_561) > 0 then			--判断玩家是否拥有561号任务
		misIndex = GetMissionIndexByID(sceneId,selfId,MISSION_561)
		num = GetMissionParam(sceneId,selfId,misIndex,1)
		if num ~= 1 then
			SetMissionByIndex(sceneId,selfId,misIndex,1,1)			--把任务变量的第二位设置为1
			BeginEvent(sceneId)
				strText = "找到完颜斡离不"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			--如果另外2个人也找到了，则把任务标志设定为完成
			if GetMissionParam(sceneId,selfId,misIndex,2) == 1 and GetMissionParam(sceneId,selfId,misIndex,3) == 1 then
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			end
		end
	end
	x022005_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x022005_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x022005_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x022005_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x022005_g_eventList do
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
function x022005_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x022005_g_eventList do
		if missionScriptId == findId then
			x022005_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x022005_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x022005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x022005_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x022005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x022005_OnDie( sceneId, selfId, killerId )
end
