--少林NPC
--玄寂
--普通

x009003_g_scriptId = 009003

--**********************************
--事件交互入口
--**********************************
function x009003_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"老衲玄寂，施主找贫僧有何事啊？")
		AddNumText(sceneId, x009003_g_scriptId, "加入门派",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x009003_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetLevel( sceneId, selfId)<10	then
		BeginEvent(sceneId)
			AddText(sceneId,"施主还是等到10级之后再来拜师学艺吧！")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		x009003_g_MenPai = GetMenPai(sceneId, selfId)
		BeginEvent(sceneId)
			if x009003_g_MenPai == 0 then
				AddText(sceneId, "你又来消遣为师了，你已是我少林弟子，还拜什么师呢。")
			--返回值为9表示无门派
			elseif x009003_g_MenPai==9	then	
				AddText(sceneId,"那么从现在开始，你就是我少林的门下弟子了。")
				LuaFnJoinMenpai(sceneId, selfId, targetId, 0)
				BeginEvent(sceneId)
	  				AddText(sceneId,"你已经加入少林派！");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,leaderObjId)
				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnAwardTitle( sceneId, selfId,  0, 6)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入少林派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 160, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了少林侠女的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				else
					LuaFnAwardTitle( sceneId, selfId,  0, 1)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入少林派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 160, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了少林侠士的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				end
			else
				AddText(sceneId,"你已是别的门派的高徒了，恕我们少林寺庙小，容不得您这尊大佛。")
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)		
	end
end
