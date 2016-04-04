--明教NPC
--吕师襄
--普通

x011006_g_scriptId = 009002

--**********************************
--事件交互入口
--**********************************
function x011006_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"洒家是圣教右使吕师襄，若要加入明教，便来找洒家。")
		AddNumText(sceneId, x011006_g_scriptId, "加入门派",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x011006_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetLevel( sceneId, selfId)<10	then
		BeginEvent(sceneId)
			AddText(sceneId,"我明教教令，只收10级以上之人。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		x011006_g_MenPai = GetMenPai(sceneId, selfId)
		BeginEvent(sceneId)
			if x011006_g_MenPai == 1 then
				AddText(sceneId, "这玩笑也是开得的？若惹得洒家性发，扣你一千门贡也是轻的。")
			--返回值为9表示无门派
			elseif x011006_g_MenPai==9	then	
				AddText(sceneId,"以后咱们便是一家人，大碗喝酒，大秤分金！")
				LuaFnJoinMenpai(sceneId, selfId, targetId, 1)
				BeginEvent(sceneId)
	  				AddText(sceneId,"你已经加入明教！");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,leaderObjId)
				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnAwardTitle( sceneId, selfId,  0, 16)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入明教！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 161, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了明教侠女的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				else
					LuaFnAwardTitle( sceneId, selfId,  0, 11)
					LuaFnMsg2Player( sceneId, selfId,"你已经加入明教！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 161, 0)
					LuaFnMsg2Player( sceneId, selfId,"你获得了明教侠士的称号！",MSG2PLAYER_PARA)
					LuaFnDispatchAllTitle(sceneId, selfId);
				end
			else
				AddText(sceneId,"这厮好不轻省！你已是其他门派之人，还来我明教做甚？")
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)		
	end
end
