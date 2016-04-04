-- 出师任务

--脚本号
x806007_g_scriptId = 806007

--出师
x806007_g_FinishAppr= {}
x806007_g_FinishAppr["Id"] = 1004
x806007_g_FinishAppr["Name"] = "出师"


--**********************************
--任务入口函数
--**********************************
function x806007_OnDefaultEvent( sceneId, selfId, targetId )
	-- tid 是即将出师的玩家
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

	if x806007_CheckSubmit( sceneId, selfId, tid ) > 0 then
		x806007_OnAccept( sceneId, selfId, tid )
	end

end

--**********************************
--列举事件
--**********************************
function x806007_OnEnumerate( sceneId, selfId, targetId )
	if x806007_CheckAccept(sceneId, selfId) > 0 then
		AddNumText(sceneId, x806007_g_scriptId, x806007_g_FinishAppr["Name"]);
	end
end

--**********************************
--检测接受条件
--**********************************
function x806007_CheckAccept( sceneId, selfId )

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

	if LuaFnIsPrentice( sceneId, selfId, tid ) ~= 1 then
		return 0
	end

	--徒弟等级≥50级并且≤55级时
	if LuaFnGetLevel( sceneId, tid ) < 50 then
		return 0
	end

	if LuaFnGetLevel( sceneId, tid ) > 55 then
		return 0
	end

	--双方背包中必须有一个空间，否则中间弹出话“XXX的背包满了”
	LuaFnBeginAddItem( sceneId )
	LuaFnAddItem( sceneId, 30002002, 1 )
	ret = LuaFnEndAddItem( sceneId, selfId )

	if ret ~= 1 then
		return 0
	end

	ret = LuaFnEndAddItem( sceneId, tid )

	if ret ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--检测是否可以出师
--**********************************
function x806007_CheckSubmit( sceneId, selfId, tid )

	if LuaFnIsPrentice( sceneId, selfId, tid ) ~= 1 then
		return 0
	end

	--徒弟等级≥50级并且≤55级时
	if LuaFnGetLevel( sceneId, tid ) < 50 then
		return 0
	end

	if LuaFnGetLevel( sceneId, tid ) > 55 then
		return 0
	end

	--双方背包中必须有一个空间，否则中间弹出话“XXX的背包满了”
	LuaFnBeginAddItem( sceneId )
	LuaFnAddItem( sceneId, 30002002, 1 )
	ret = LuaFnEndAddItem( sceneId, selfId )

	if ret ~= 1 then
		return 0
	end

	ret = LuaFnEndAddItem( sceneId, tid )

	if ret ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--接受
--**********************************
function x806007_OnAccept( sceneId, selfId, tid )
	--双方的好友度都大于等于N=300才有奖励
	local flag = 0
	local MasterFriendPoint = LuaFnGetFriendPoint( sceneId, selfId, tid )
	if MasterFriendPoint < 300 then
		flag = 1
	elseif LuaFnGetFriendPoint( sceneId, tid, selfId ) < 300 then
		flag = 1
	end

	if flag ~= 1 then
		--给师傅增加师德（X=0-1000000） N=M（1000）＋MIN(X=500, 师父对徒弟的友好度*T)
		MoralPoint = 1000

		if (MasterFriendPoint * 1) < 500 then
			MoralPoint = MoralPoint + MasterFriendPoint
		else
			MoralPoint = MoralPoint + 500
		end

		MoralPoint = MoralPoint + LuaFnGetMasterMoralPoint( sceneId, selfId )

		if MoralPoint > 1000000 then
			MoralPoint = 1000000
		end

		LuaFnSetMasterMoralPoint( sceneId, selfId, MoralPoint )

		--ToDO: 物品需要找小二做
		LuaFnAddItemListToHuman( sceneId, selfId )
		LuaFnAddItemListToHuman( sceneId, tid )
	end


	--删除徒弟称号
	LuaFnAwardSpouseTitle( sceneId, tid, "" )
	DispatchAllTitle( sceneId, tid )

	LuaFnFinishAprentice( sceneId, tid, selfId )
end
