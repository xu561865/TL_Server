--武当NPC
--张玄素
--普通

x012006_g_scriptId = 012006

--**********************************
--事件交互入口
--**********************************
function x012006_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是张玄素")
		AddNumText(sceneId, x012006_g_scriptId, "加入门派",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x012006_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetLevel( sceneId, selfId)<10	then
		BeginEvent(sceneId)
			AddText(sceneId,"你还是等到10级之后再来拜师学艺吧！")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		x012006_g_MenPai = GetMenPai(sceneId, selfId)
		BeginEvent(sceneId)
			if x012006_g_MenPai == 3 then
				AddText(sceneId, "你又来消遣为师了，你已是我武当弟子，还拜什么师呢。")
			--返回值为9表示无门派
			elseif x012006_g_MenPai==9	then	
				AddText(sceneId,"那么从现在开始，你就是我武当的门下弟子了。")
				LuaFnJoinMenpai(sceneId, selfId, targetId, 3)
				BeginEvent(sceneId)
	  				AddText(sceneId,"你已经加入武当派！");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,leaderObjId)
				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnAwardTitle( sceneId, selfId,  0, 36)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入武当派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 163, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了武当侠女的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				else
					LuaFnAwardTitle( sceneId, selfId,  0, 31)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入武当派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 163, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了武当侠士的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				end
			else
				AddText(sceneId,"你已是别的门派的高徒了，我们不收你。")
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)		
	end
end
