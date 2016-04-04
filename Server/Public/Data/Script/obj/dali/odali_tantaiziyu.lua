--澹台子羽

--脚本号
x002046_g_scriptId = 002046


--所拥有的事件ID列表
x002046_g_eventList={210209}

--**********************************
--事件列表
--**********************************
function x002046_UpdateEventList( sceneId, selfId,targetId )
	
	local  Menpai=LuaFnGetMenPai(sceneId,selfId)
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "师妹"
	else
		PlayerSex = "师弟"
	end
	
	BeginEvent(sceneId)	
	if Menpai == OR_WUMENPAI then
		AddText(sceneId,"  在下澹台子羽，逍遥门下。#r#r  逍遥派云深不至何处，却有影响天下之力，你知道为什么吗？#r#r  逍遥武功，从不是刀枪棍棒，只是设下玄机，请君入瓮。我愿荐你入逍遥派。")
	elseif Menpai == OR_XIAOYAO then
		AddText(sceneId,"  "..PlayerSex.."，你的武功进步好快，逍遥不修苦力，只讲灵气，看来你确实天资聪颖啊。")
	else
		AddText(sceneId,"  好久没有见到你了，以你这样的天资，可惜没有入我逍遥，什么样的武功还不是一介匹夫。")
	end
	
	if	GetLevel( sceneId, selfId)<=10	then
		AddNumText(sceneId,x002046_g_scriptId,"去凌波洞看看",-1,0)
	end
	for i, eventId in x002046_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002046_OnDefaultEvent( sceneId, selfId,targetId )
	x002046_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002046_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if IsHaveMission(sceneId,selfId,4021) > 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"你有漕运货舱在身，我们驿站不能为你提供传送服务。");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 14,66,143)
		end
	else
		for i, findId in x002046_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
				return
			end
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002046_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002046_g_eventList do
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
function x002046_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002046_g_eventList do
		if missionScriptId == findId then
			x002046_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002046_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002046_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002046_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002046_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002046_OnDie( sceneId, selfId, killerId )
end
