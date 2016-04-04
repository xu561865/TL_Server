--剑阁 时迈

--脚本号
x007006_g_scriptId = 007006

--所拥有的事件ID列表
x007006_g_eventList={210702,210703,210704,210705,210707}	

--**********************************
--事件列表
--**********************************
function x007006_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	
	local IsDone503 = IsMissionHaveDone(sceneId,selfId,503)	
	local IsDone504 = IsMissionHaveDone(sceneId,selfId,504)	
	local IsDone505 = IsMissionHaveDone(sceneId,selfId,505)	
	local IsDone507 = IsMissionHaveDone(sceneId,selfId,507)	
		
	
	if(IsDone503 == 0) then	
		AddText(sceneId,  "第一把钥匙在黑猿首领手中，去帮我抢来。哦，我是说，帮我拿来")
	elseif(IsDone504 == 0) then	
		AddText(sceneId, PlayerName.."黄色的宝藏钥匙，在草人首领手中。")
	elseif(IsDone505 == 0) then	
		AddText(sceneId, "就差最后一把钥匙了，它在一个愚蠢的鬼面侏儒首领手中")
	elseif(IsDone507 == 0) then	
		AddText(sceneId, "就差最后一把钥匙了，有了它我就能无敌于天下了")	
	end
	
	for i, eventId in x007006_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x007006_OnDefaultEvent( sceneId, selfId,targetId )
	x007006_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x007006_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x007006_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x007006_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x007006_g_eventList do
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
function x007006_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x007006_g_eventList do
		if missionScriptId == findId then
			x007006_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x007006_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x007006_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x007006_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x007006_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x007006_OnDie( sceneId, selfId, killerId )
end
