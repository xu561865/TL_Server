--调整发型
--脚本号
x801010_g_ScriptId = 801010

--调整发型UI 21

--**********************************
--列举事件
--**********************************
function x801010_OnEnumerate( sceneId, selfId, targetId )

	-- 为什么要 NPC 名字？
	local TransportNPCName=GetName(sceneId,targetId);

	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId)
		UICommand_AddString(sceneId,TransportNPCName)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 21)
	return

end


--**********************************
--调整完发型
--**********************************
function x801010_FinishAdjust( sceneId, selfId, styleId)
	-- 是否需要什么返回信息？
	-- 换头像还需要判断 Race 吗？
	LuaFnChangeHumanHairModel( sceneId, selfId, styleId )
--	Msg2Player(sceneId,selfId,"改变发型成功。",MSG2PLAYER_PARA)
	BeginEvent(sceneId)
		AddText(sceneId,"改变发型成功。");
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
