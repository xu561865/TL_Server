--赵天师

--脚本号
x002030_g_scriptId = 002030


--所拥有的事件ID列表
x002030_g_eventList={210200,210204,210205,210208,210210,210212,210213,210214,210216,210217,210220,210223, 210224, 210225, 210229, 210230, 210232}
--x002030_g_eventList={210200}

--**********************************
--事件列表
--**********************************
function x002030_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	
	local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "妹妹"
	else
		PlayerSex = "兄弟"
	end
	local  IsNew = IsHaveMission(sceneId,selfId,440)
	
	if IsNew == 1 then
		AddText(sceneId,"  "..PlayerName..PlayerSex.."，苍山不墨千秋画，洱海无弦万古琴。没有想到你也来到大理城的武林大会了。#r#r  你人生地不熟，有什么问题多问我们四大善人啊。尤其是老哥哥我啊。")
	else
		AddText(sceneId,"  "..PlayerName..PlayerSex.."，这一会没有见面，你的武功就精进了这么多？ 真是可喜可贺啊。#r#r  有事没事就来找我们四大善人说说话啊。")
	end
	
	for i, eventId in x002030_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	
	
	ListMissionsNM( sceneId, selfId, targetId )
	
	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002030_OnDefaultEvent( sceneId, selfId,targetId )
	x002030_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002030_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002030_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
	
	
	
	RequestMissionNM( sceneId, selfId, targetId, eventId )
end

--**********************************
--接受此NPC的任务
--**********************************
function x002030_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002030_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
	
	OnMissionAcceptNM( sceneId, selfId, targetId, missionScriptId )
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x002030_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002030_g_eventList do
		if missionScriptId == findId then
			x002030_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002030_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002030_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002030_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002030_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
	
	
	
	SubmitMissionNM( sceneId, selfId, targetId, missionScriptId, selectRadioId )
end

--**********************************
--死亡事件
--**********************************
function x002030_OnDie( sceneId, selfId, killerId )
end
