--陈永仁

--脚本号
x311001_g_scriptId = 311001


--所拥有的事件ID列表
x311001_g_eventList={311004}

--**********************************
--事件列表
--**********************************
function x311001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerSex=GetSex(sceneId,selfId)
		if PlayerSex == 0 then
			PlayerSex = "女侠"
		else
			PlayerSex = "大侠"
		end
		AddText(sceneId,"  五台山叛军的底细我们已经打探清楚， 原来是汉国刘家和燕国慕容家的余党联合作乱， 妄图复国。\n\n  "..PlayerSex.."， 你和刘光世大人谈过了吗？ 如果准备好了，我马上直接送你前往，从后山小径，直奔其巢穴。\n")
		CallScriptFunction(311004, "OnEnumerate",sceneId, selfId, targetId )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x311001_OnDefaultEvent( sceneId, selfId,targetId )
	x311001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x311001_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x311001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x311001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x311001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x311001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x311001_g_eventList do
		if missionScriptId == findId then
			x311001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x311001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x311001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x311001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x311001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x311001_OnDie( sceneId, selfId, killerId )
end
