--峨嵋NPC
--李十二娘
--普通

x015001_g_scriptId = 015001

--**********************************
--事件交互入口
--**********************************
function x015001_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"李十二娘")
		AddNumText(sceneId, x015001_g_scriptId, "加入门派",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x015001_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetLevel( sceneId, selfId)<10	then
		BeginEvent(sceneId)
			AddText(sceneId,"施主还是等到10级之后再来拜师学艺吧！")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		x015001_g_MenPai = GetMenPai(sceneId, selfId)
		BeginEvent(sceneId)
			if x015001_g_MenPai == 4 then
				AddText(sceneId, "你又来消遣为师了，你已是我峨嵋弟子，还拜什么师呢。")
			--返回值为9表示无门派
			elseif x015001_g_MenPai==9	then	
				AddText(sceneId,"那么从现在开始，你就是我峨嵋的门下弟子了。")
				LuaFnJoinMenpai(sceneId, selfId, targetId, 4)
				BeginEvent(sceneId)
	  				AddText(sceneId,"你已经加入峨嵋派！");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,leaderObjId)
				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnAwardTitle( sceneId, selfId,  0, 66)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入峨嵋派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 164, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了峨嵋侠女的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				else
					LuaFnAwardTitle( sceneId, selfId,  0, 61)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入峨嵋派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 164, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了峨嵋侠士的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				end
			else
				AddText(sceneId,"你已是别的门派的高徒了，我们不收你。")
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)		
	end
end
