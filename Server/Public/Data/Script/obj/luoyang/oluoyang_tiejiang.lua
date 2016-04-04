--洛阳NPC   王德富 学习铸造技能 升级铸造技能
--铁匠
--普通

--脚本号
x000035_g_ScriptId = 000035

--所拥有的事件Id列表
estudy_zhuzao = 713505
elevelup_zhuzao = 713564
edialog_zhuzao = 713604
--所拥有的事件ID列表
x000035_g_eventList={estudy_zhuzao,elevelup_zhuzao}	--,edialog_zhuzao}	
MessageNum = 1		--MessageNum是对话编号，用于调用不同对话

x000035_g_shoptableindex=64
--**********************************
--事件列表
--**********************************
function x000035_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"你想学习铸造技能么？")
	for i, eventId in x000035_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	AddNumText(sceneId,g_scriptId,"购买图样",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000035_OnDefaultEvent( sceneId, selfId,targetId )
	x000035_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000035_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		DispatchShopItem( sceneId, selfId,targetId, x000035_g_shoptableindex )
	end
	for i, findId in x000035_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x000035_g_ScriptId )
		return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000035_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000035_g_eventList do
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
function x000035_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000035_g_eventList do
		if missionScriptId == findId then
			x000035_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000035_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000035_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000035_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000035_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000035_OnDie( sceneId, selfId, killerId )
end
