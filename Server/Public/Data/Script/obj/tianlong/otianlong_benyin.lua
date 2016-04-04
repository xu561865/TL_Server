--本因

--脚本号
x013001_g_scriptId = 013001

--**********************************
--事件交互入口
--**********************************
function x013001_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"老衲本因，施主找贫僧有何事啊？")
		AddNumText(sceneId, x013001_g_scriptId, "加入门派",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x013001_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
			if	GetLevel( sceneId, selfId)<10	then
				BeginEvent(sceneId)
					AddText(sceneId,"施主还是等到10级之后再来拜师学艺吧！")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			else
				x013001_g_MenPai = GetMenPai(sceneId, selfId)
				BeginEvent(sceneId)
					if x013001_g_MenPai == 6 then
						AddText(sceneId, "你又来消遣为师了，你已是我天龙寺弟子，还拜什么师呢。")
					--返回值为9表示无门派
					elseif x013001_g_MenPai==9	then	
						AddText(sceneId,"那么从现在开始，你就是我天龙寺的门下弟子了。")
						LuaFnJoinMenpai(sceneId, selfId, targetId, 6)
						BeginEvent(sceneId)
							AddText(sceneId,"你已经加入天龙寺！");
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,leaderObjId)
						if	LuaFnGetSex( sceneId, selfId)==0	then
							LuaFnAwardTitle( sceneId, selfId,  0, 46)
							LuaFnMsg2Player( sceneId, selfId,"你已经加入天龙寺！",MSG2PLAYER_PARA)
							LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 166, 0)
							LuaFnMsg2Player( sceneId, selfId,"你获得了天龙侠女的称号！",MSG2PLAYER_PARA)
							LuaFnDispatchAllTitle(sceneId, selfId);
						else
							LuaFnAwardTitle( sceneId, selfId,  0, 41)
							LuaFnMsg2Player( sceneId, selfId,"你已经加入天龙寺！",MSG2PLAYER_PARA)
							LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 166, 0)
							LuaFnMsg2Player( sceneId, selfId,"你获得了天龙侠士的称号！",MSG2PLAYER_PARA)
							LuaFnDispatchAllTitle(sceneId, selfId);
						end
					else
						AddText(sceneId,"你已是别的门派的高徒了，恕我们天龙寺庙小，容不得您这尊大佛。")
					end
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)		
			end
	end
	for i, findId in g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end
