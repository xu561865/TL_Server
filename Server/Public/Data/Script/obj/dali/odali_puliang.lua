--蒲良

--脚本号
x002023_g_scriptId = 002023

x002023_g_shoptableindex=1

--所拥有的事件ID列表
x002023_g_eventList={210200,210201}

--**********************************
--事件列表
--**********************************
function x002023_UpdateEventList( sceneId, selfId,targetId )
	local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	BeginEvent(sceneId)
	AddText(sceneId,"  古人云：工欲利其兵，必先利其器。行走江湖要先有件合手的兵器才行，"..PlayerName..PlayerSex.."，不妨来挑一件自己喜欢的吧。")
	AddNumText(sceneId,x002023_g_scriptId,"购买武器",-1,0)
	for i, eventId in x002023_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	
	
	ListMissionsNM( sceneId, selfId, targetId )
	
	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002023_OnDefaultEvent( sceneId, selfId,targetId )
	x002023_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002023_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText() == 0	then
		DispatchShopItem( sceneId, selfId,targetId, x002023_g_shoptableindex )
	end
	for i, findId in x002023_g_eventList do
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
function x002023_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002023_g_eventList do
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
function x002023_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002023_g_eventList do
		if missionScriptId == findId then
			x002023_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002023_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002023_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002023_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002023_g_eventList do
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
function x002023_OnDie( sceneId, selfId, killerId )
end
