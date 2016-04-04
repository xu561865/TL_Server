--星宿NPC
--韩世忠
--普通

x016001_g_scriptId = 016001

--**********************************
--事件交互入口
--**********************************
function x016001_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是韩世忠")
		AddNumText(sceneId, x016001_g_scriptId, "加入门派",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x016001_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetLevel( sceneId, selfId)<10	then
		BeginEvent(sceneId)
			AddText(sceneId,"施主还是等到10级之后再来拜师学艺吧！")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		x016001_g_MenPai = GetMenPai(sceneId, selfId)
		BeginEvent(sceneId)
			if x016001_g_MenPai == 5 then
				AddText(sceneId, "你又来消遣为师了，你已是我星宿弟子，还拜什么师呢。")
			--返回值为9表示无门派
			elseif x016001_g_MenPai==9	then	
				AddText(sceneId,"那么从现在开始，你就是我星宿的门下弟子了。")
				LuaFnJoinMenpai(sceneId, selfId, targetId, 5)
				BeginEvent(sceneId)
	  				AddText(sceneId,"你已经加入星宿派！");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,leaderObjId)
				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnAwardTitle( sceneId, selfId,  0, 76)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入星宿派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 165, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了星宿侠女的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				else
					LuaFnAwardTitle( sceneId, selfId,  0, 71)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入星宿派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 165, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了星宿侠士的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				end
			else
				AddText(sceneId,"你已是别的门派的高徒了，我们不收你")
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)		
	end
end
