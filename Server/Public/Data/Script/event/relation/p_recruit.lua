-- 收徒任务

--脚本号
x806008_g_scriptId = 806008

--收徒
x806008_g_Recruit= {}
x806008_g_Recruit["Id"] = 1003
x806008_g_Recruit["Name"] = "收徒"
x806008_g_Recruit["Name2"] = "拜师"

--**********************************
--任务入口函数 请求收徒
--**********************************
function x806008_OnDefaultEvent( sceneId, selfId, targetId )
	-- tid 是即将成为徒弟的玩家
	--组队人数＝2；
	if LuaFnHasTeam( sceneId, selfId ) == 0 then
		return
	end

	if LuaFnGetTeamSize( sceneId, selfId ) ~= 2 then
		return
	end

	if LuaFnGetTeamSceneMemberCount( sceneId, selfId ) ~= 1 then
		return
	end

	local tid = LuaFnGetTeamSceneMember( sceneId, selfId, 0 )

	--当前没有师父，只能同时拜一位玩家为师
	if LuaFnHaveMaster( sceneId, tid ) ~= 0 then
		return 0
	end

	BeginEvent(sceneId)
		local MasterName = LuaFnGetName( sceneId, selfId )
		AddText(sceneId, x806008_g_Recruit["Name2"])
		AddText(sceneId, "你是否愿意拜" .. MasterName .. "为师？")
	EndEvent( )
	DispatchMissionInfo(sceneId, tid, targetId, x806008_g_scriptId, x806008_g_Recruit["Id"])

	BeginEvent(sceneId)
		local ApprenticeName = LuaFnGetName( sceneId, tid )
		AddText(sceneId, "等待" .. ApprenticeName .. "答复。")
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)

end

--**********************************
--列举事件
--**********************************
function x806008_OnEnumerate( sceneId, selfId, targetId )
	if x806008_CheckAccept(sceneId, selfId) > 0 then
		AddNumText(sceneId, x806008_g_scriptId, x806008_g_Recruit["Name"])
	end
end

--**********************************
--检测接受条件
--**********************************
function x806008_CheckAccept( sceneId, selfId )

	--检查：
	--组队中只有师徒两个人
	if LuaFnHasTeam( sceneId, selfId ) == 0 then
		return 0
	end

	if LuaFnGetTeamSize( sceneId, selfId ) ~= 2 then
		return 0
	end

	if LuaFnGetTeamSceneMemberCount( sceneId, selfId ) ~= 1 then
		return 0
	end

	local tid = LuaFnGetTeamSceneMember( sceneId, selfId, 0 )

	--师傅等级≥61级
	if LuaFnGetLevel( sceneId, selfId ) < 61 then
		return 0
	end

	--最多同时收两名徒弟，当自行解除师徒关系满3天，或者有徒弟出师后，可以再收新徒弟
	if LuaFnGetPrenticeCount( sceneId, selfId ) >= 2 then
		return 0
	end

	if LuaFnGetPrenticeBetrayTime( sceneId, selfId ) < (86400 * 3) then
		return 0
	end

	--徒弟等级≥15并且≤25级，25级时当前经验不超过升级经验
	if LuaFnGetLevel( sceneId, tid ) < 15 then
		return 0
	end

	if LuaFnGetLevel( sceneId, tid ) > 25 then
		return 0
	end

	if LuaFnGetLevel( sceneId, tid ) == 25 then
		if LuaFnCanLevelUp( sceneId, tid ) ~= 0 then
			return 0
		end
	end

	--当前没有师父，只能同时拜一位玩家为师
	if LuaFnHaveMaster( sceneId, tid ) ~= 0 then
		return 0
	end

	--不是夫妻或结拜
	if LuaFnIsSpouses( sceneId, selfId, tid ) ~= 0 then
		return 0
	end

	if LuaFnIsBrother( sceneId, selfId, tid ) ~= 0 then
		return 0
	end

	--必须是好友
	if LuaFnIsFriend( sceneId, selfId, tid ) ~= 1 then
		return 0
	end

	if LuaFnIsFriend( sceneId, tid, selfId ) ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--接受
--**********************************
function x806008_OnAccept( sceneId, selfId )
	-- tid 是即将成为师傅的玩家
	--组队人数＝2；
	if LuaFnHasTeam( sceneId, selfId ) == 0 then
		return
	end

	if LuaFnGetTeamSize( sceneId, selfId ) ~= 2 then
		return
	end

	if LuaFnGetTeamSceneMemberCount( sceneId, selfId ) ~= 1 then
		return
	end

	local tid = LuaFnGetTeamSceneMember( sceneId, selfId, 0 )

	if x806008_CheckSubmit( sceneId, tid, selfId ) > 0 then
		x806008_OnSubmit( sceneId, selfId, tid )
	end
end

--**********************************
--检测是否可以拜师/收徒
--**********************************
function x806008_CheckSubmit( sceneId, selfId, tid )

	--师傅等级≥61级
	if LuaFnGetLevel( sceneId, selfId ) < 61 then
		return 0
	end

	--最多同时收两名徒弟，当自行解除师徒关系满3天，或者有徒弟出师后，可以再收新徒弟
	if LuaFnGetPrenticeCount( sceneId, selfId ) >= 2 then
		return 0
	end

	if LuaFnGetPrenticeBetrayTime( sceneId, selfId ) < (86400 * 3) then
		return 0
	end

	--徒弟等级≥15并且≤25级，25级时当前经验不超过升级经验
	if LuaFnGetLevel( sceneId, tid ) < 15 then
		return 0
	end

	if LuaFnGetLevel( sceneId, tid ) > 25 then
		return 0
	end

	if LuaFnGetLevel( sceneId, tid ) == 25 then
		if LuaFnCanLevelUp( sceneId, tid ) ~= 0 then
			return 0
		end
	end

	--当前没有师父，只能同时拜一位玩家为师
	if LuaFnHaveMaster( sceneId, tid ) ~= 0 then
		return 0
	end

	--不是夫妻或结拜
	if LuaFnIsSpouses( sceneId, selfId, tid ) ~= 0 then
		return 0
	end

	if LuaFnIsBrother( sceneId, selfId, tid ) ~= 0 then
		return 0
	end

	--必须是好友
	if LuaFnIsFriend( sceneId, selfId, tid ) ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x806008_OnSubmit( sceneId, selfId, tid )
	--徒弟增加一个称号
	local MasterName = LuaFnGetName( sceneId, tid )
	LuaFnAwardSpouseTitle( sceneId, selfId, MasterName .. "的徒弟" )
	DispatchAllTitle( sceneId, selfId )

	LuaFnAprentice( sceneId, selfId, tid )
end
