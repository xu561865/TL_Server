--逍遥NPC
--苏星河
--普通

x014000_g_scriptId = 014000

--**********************************
--事件交互入口
--**********************************
function x014000_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是苏星河~~")
	EndEvent(sceneId)
	AddNumText(sceneId, x014000_g_scriptId, "加入门派",-1,0)
	DispatchEventList(sceneId,selfId,targetId)
end


--**********************************
--事件列表选中一项
--**********************************
function x014000_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetLevel( sceneId, selfId)<10	then
		BeginEvent(sceneId)
			AddText(sceneId,"施主还是等到10级之后再来拜师学艺吧！")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		x014000_g_MenPai = GetMenPai(sceneId, selfId)
		BeginEvent(sceneId)
			if x014000_g_MenPai == 8 then
				AddText(sceneId, "你又来消遣为师了，你已是我逍遥弟子，还拜什么师呢。")
			--返回值为9表示无门派
			elseif x014000_g_MenPai==9	then	
				AddText(sceneId,"那么从现在开始，你就是我逍遥的门下弟子了。")
				LuaFnJoinMenpai(sceneId, selfId, targetId, 8)
				BeginEvent(sceneId)
	  				AddText(sceneId,"你已经加入逍遥派！");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,leaderObjId)
				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnAwardTitle( sceneId, selfId,  0, 56)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入逍遥派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 168, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了逍遥侠女的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				else
					LuaFnAwardTitle( sceneId, selfId,  0, 51)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入逍遥派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 168, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了逍遥侠士的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				end
			else
				AddText(sceneId,"你已是别的门派的高徒了，我们不收你")
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)		
	end
end
