--陈孤雁

--脚本号
x010000_g_scriptId = 010000

--所拥有的事件ID列表
x010000_g_eventList={200922,201021,201121}

--**********************************
--事件列表
--**********************************
function x010000_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"我是陈孤雁，阁下来我丐帮何事？");
	for i, eventId in x010000_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	AddNumText(sceneId, x010000_g_scriptId, "加入门派",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x010000_OnDefaultEvent( sceneId, selfId,targetId )
	x010000_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x010000_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if	GetLevel( sceneId, selfId)<10	then
			BeginEvent(sceneId)
				AddText(sceneId,"你还是等到10级之后再来拜师学艺吧！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			x010000_g_MenPai = GetMenPai(sceneId, selfId)
			BeginEvent(sceneId)
				if x010000_g_MenPai == 2 then
					AddText(sceneId, "你又来消遣为师了，你已是我丐帮弟子，还拜什么师呢。")
				--返回值为9表示无门派
				elseif x010000_g_MenPai==9	then	
					AddText(sceneId,"那么从现在开始，你就是我丐帮的门下弟子了。")
					LuaFnJoinMenpai(sceneId, selfId, targetId, 2)
					BeginEvent(sceneId)
						AddText(sceneId,"你已经加入丐帮！");
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,leaderObjId)
					if	LuaFnGetSex( sceneId, selfId)==0	then
						LuaFnAwardTitle( sceneId, selfId,  0, 26)
						LuaFnMsg2Player( sceneId, selfId,"你已经加入丐帮！",MSG2PLAYER_PARA)
						LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 162, 0)
						LuaFnMsg2Player( sceneId, selfId,"你获得了丐帮侠女的称号！",MSG2PLAYER_PARA)
						LuaFnDispatchAllTitle(sceneId, selfId);
					else
						LuaFnAwardTitle( sceneId, selfId,  0, 21)
						LuaFnMsg2Player( sceneId, selfId,"你已经加入丐帮！",MSG2PLAYER_PARA)
						LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 162, 0)
						LuaFnMsg2Player( sceneId, selfId,"你获得了丐帮侠士的称号！",MSG2PLAYER_PARA)
						LuaFnDispatchAllTitle(sceneId, selfId);
					end
				else
					AddText(sceneId,"你已是别的门派的高徒了，丐帮不收你。")
				end
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)		
		end
	end
	for i, findId in x010000_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x010000_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x010000_g_eventList do
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
function x010000_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x010000_g_eventList do
		if missionScriptId == findId then
			x010000_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x010000_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x010000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x010000_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x010000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x010000_OnDie( sceneId, selfId, killerId )
end
