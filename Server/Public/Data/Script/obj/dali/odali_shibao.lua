--石宝

--脚本号
x002040_g_scriptId = 002040


--所拥有的事件ID列表
x002040_g_eventList={210209}

--**********************************
--事件列表
--**********************************
function x002040_UpdateEventList( sceneId, selfId,targetId )
	
	local  Menpai=LuaFnGetMenPai(sceneId,selfId)
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "师妹"
	else
		PlayerSex = "师弟"
	end
	
	BeginEvent(sceneId)	
	if Menpai == OR_WUMENPAI then
		AddText(sceneId,"  在下石宝，明教光明右使旗下。#r#r  右使当下广招弟子，光明圣火已几乎染指天下，此时不入更待何时。#r#r  明教弟子承圣火护佑，武功爆发力极强，几近狂化。")
	elseif Menpai == OR_MINGJIAO then
		AddText(sceneId,"  "..PlayerSex.."，你的武功进步好快啊。#r#r  熊熊圣火佑我明教，万丈光明普照天下。")
	else
		AddText(sceneId,"  好久没有见到你了，以你这样的天资，真可惜不是我明教中人，终成碌碌之辈。")
	end
	
	if	GetLevel( sceneId, selfId)<=10	then
		AddNumText(sceneId,x002040_g_scriptId,"去光明顶看看",-1,0)
	end
	for i, eventId in x002040_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002040_OnDefaultEvent( sceneId, selfId,targetId )
	x002040_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002040_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if IsHaveMission(sceneId,selfId,4021) > 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"你有漕运货舱在身，我们驿站不能为你提供传送服务。");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else	
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 11, 98, 149)
		end
	else
		for i, findId in x002040_g_eventList do
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
function x002040_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002040_g_eventList do
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
function x002040_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002040_g_eventList do
		if missionScriptId == findId then
			x002040_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002040_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002040_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002040_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002040_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002040_OnDie( sceneId, selfId, killerId )
end
