-- 离婚任务

--脚本号
x806005_g_scriptId = 806005

--离婚
x806005_g_Unmarry= {}
x806005_g_Unmarry["Id"] = 1001
x806005_g_Unmarry["Name"] = "离婚"
x806005_g_Unmarry["Skills"] = {260, 261}

--**********************************
--任务入口函数
--**********************************
function x806005_OnDefaultEvent( sceneId, selfId, targetId )
	-- tid 是发生关系的玩家，在此计算出来以后，其他子程序中就不再计算和判断
	--男女组队，组队人数＝2；
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

	local selfSex = LuaFnGetSex( sceneId, selfId )
	local tSex = LuaFnGetSex( sceneId, tid )
	local male
	local female

	if selfSex == tSex then
		return
	end

	if selfSex == 1 then
		male = selfId
		female = tid
	else
		male = tid
		female = selfId
	end

	if x806005_CheckSubmit( sceneId, male, female ) > 0 then
		x806005_OnAccept( sceneId, male, female )
	end

end

--**********************************
--列举事件
--**********************************
function x806005_OnEnumerate( sceneId, selfId, targetId )
	if x806005_CheckAccept(sceneId, selfId) > 0 then
		AddNumText(sceneId, x806005_g_scriptId, x806005_g_Unmarry["Name"]);
	end
end

--**********************************
--检测接受条件
--**********************************
function x806005_CheckAccept( sceneId, selfId )

	--检查：
	--男女组队，组队人数＝2；
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

	--俩人是夫妻
	if LuaFnIsSpouses( sceneId, selfId, tid ) == 0 then
		return 0
	end

	local selfSex = LuaFnGetSex( sceneId, selfId )
	local tSex = LuaFnGetSex( sceneId, tid )
	local male

	if selfSex == tSex then
		return 0
	end

	if selfSex == 1 then
		male = selfId
	else
		male = tid
	end

	--男方身上金钱大于等于N=55555
	if LuaFnGetMoney( sceneId, male ) < 55555 then
		return 0
	end

	return 1
end

--**********************************
--检测是否可以离婚
--**********************************
function x806005_CheckSubmit( sceneId, male, female )

	--俩人是夫妻
	if LuaFnIsSpouses( sceneId, male, female ) == 0 then
		return 0
	end

	--男方身上金钱大于等于N=55555
	if LuaFnGetMoney( sceneId, male ) < 55555 then
		return 0
	end

	return 1
end

--**********************************
--接受
--**********************************
function x806005_OnAccept( sceneId, male, female )
	--扣除男方身上金钱55555；
	LuaFnCostMoney( sceneId, male, 55555 )

	--删除双方婚姻技能
	for i, skillId in x806005_g_Unmarry["Skills"] do
		DelSkill( sceneId, male, skillId )
		DelSkill( sceneId, female, skillId )
	end

	--降低友好度
	LuaFnSetFriendPoint( sceneId, male, female, 10 )
	LuaFnSetFriendPoint( sceneId, female, male, 10 )

	--删除称号
	LuaFnAwardSpouseTitle( sceneId, female, "" )
	DispatchAllTitle( sceneId, female )
	LuaFnAwardSpouseTitle( sceneId, male, "" )
	DispatchAllTitle( sceneId, male )

	--
	LuaFnUnMarry( sceneId, male, female )
end
