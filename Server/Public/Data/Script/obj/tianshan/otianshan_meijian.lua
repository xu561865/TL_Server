--天山NPC
--梅剑
--普通

--**********************************
--事件交互入口
--**********************************
function x017001_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是梅剑，老尊主不在，我来管理天山")
		AddNumText(sceneId, g_scriptId, "加入门派",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x017001_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetLevel( sceneId, selfId)<10	then
		BeginEvent(sceneId)
			AddText(sceneId,"施主还是等到10级之后再来拜师学艺吧！")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		x017001_g_MenPai = GetMenPai(sceneId, selfId)
		BeginEvent(sceneId)
			if x017001_g_MenPai == 7 then
				AddText(sceneId, "你又来消遣为师了，你已是我天山弟子，还拜什么师呢。")
			--返回值为9表示无门派
			elseif x017001_g_MenPai==9	then	
				AddText(sceneId,"那么从现在开始，你就是我天山的门下弟子了。")
				LuaFnJoinMenpai(sceneId, selfId, targetId, 7)
				BeginEvent(sceneId)
	  				AddText(sceneId,"你已经加入天山派！");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,leaderObjId)
				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnAwardTitle( sceneId, selfId,  0, 86)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入天山派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 167, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了天山侠女的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				else
					LuaFnAwardTitle( sceneId, selfId,  0, 81)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入天山派！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 167, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了天山侠士的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				end
			else
				AddText(sceneId,"你已是别的门派的高徒了，我们不收你的")
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)		
	end
end
