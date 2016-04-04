--西京枢密使

--脚本号
x311000_g_scriptId = 311000


--所拥有的事件ID列表
x311000_g_eventList={311004,311005}

--**********************************
--事件列表
--**********************************
function x311000_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerName=GetName(sceneId,selfId)
		local  PlayerSex=GetSex(sceneId,selfId)
		if PlayerSex == 0 then
			PlayerSex = "女侠"
		else
			PlayerSex = "大侠"
		end
		AddText(sceneId,"  "..PlayerName.." ， 你来的太是时候了。 梁山、武台、峨嵋等处叛乱又起，希望"..PlayerSex.."能协助平叛。\n\n  你也知道枢密院已把精锐禁军全部布署在北方边境，只剩老弱可派往内乱之地。\n\n  虽说叛军是乌合之众，可其中也有武林高手和奇人异士，这才是真正难对付的，我只有恳请"..PlayerSex.."出手相助。\n")
		if	(IsHaveMission(sceneId,selfId,4001) > 0)  then
			CallScriptFunction( (311004), "OnEnumerate",sceneId, selfId, targetId )
		elseif	(IsHaveMission(sceneId,selfId,4002) > 0)  then
			CallScriptFunction( (311005), "OnEnumerate",sceneId, selfId, targetId )
		else
			local	r=random(0,1)
			CallScriptFunction( (311004+r), "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x311000_OnDefaultEvent( sceneId, selfId,targetId )
	--if ( IsHaveMission(sceneId,selfId,4001) > 0) then
	--	DelMission(sceneId,selfId,4001)	
	--elseif ( IsHaveMission(sceneId,selfId,4002) > 0) then
	--	DelMission(sceneId,selfId,4002)
	--end
	x311000_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x311000_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x311000_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x311000_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x311000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x311000_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x311000_g_eventList do
		if missionScriptId == findId then
			x311000_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x311000_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x311000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x311000_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x311000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x311000_OnDie( sceneId, selfId, killerId )
end
