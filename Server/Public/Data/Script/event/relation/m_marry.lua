-- 结婚任务

--脚本号
x806003_g_scriptId = 806003

--结婚
x806003_g_Marry= {}
x806003_g_Marry["Id"] = 1000
x806003_g_Marry["Name"] = "结婚"
--x806003_g_Marry["g_MarryInfo"] = "想结婚就接受。"
--x806003_g_Marry["CantMarry"] = "小样，还想结婚~~~"
--结婚戒指
x806003_g_Marry["ItemBonus"] = 10422099
--结婚技能
x806003_g_Marry["Skills"] = {260, 261}
--x806003_g_Marry["ContinueInfo"] = "赶紧了赶紧了，点完成就开始结婚了。"

--**********************************
--任务入口函数 请求结婚
--**********************************
function x806003_OnDefaultEvent( sceneId, selfId, targetId )
	-- 如果已经结婚
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

	if x806003_CheckSubmit( sceneId, male, female ) > 0 then
		x806003_OnAccept( sceneId, male, female )
	end
end

--**********************************
--列举事件
--**********************************
function x806003_OnEnumerate( sceneId, selfId, targetId )
	if x806003_CheckAccept(sceneId, selfId) > 0 then
		AddNumText(sceneId, x806003_g_scriptId, x806003_g_Marry["Name"]);
	end
end

--**********************************
--检测接受条件
--**********************************
function x806003_CheckAccept( sceneId, selfId )

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

	if LuaFnIsFriend( sceneId, selfId, tid ) ~= 1 then
		return 0
	end

	if LuaFnIsFriend( sceneId, tid, selfId ) ~= 1 then
		return 0
	end

	-- 离得太远了
	if IsInDist( sceneId, selfId, tid, 10 ) ~= 1 then
		return 0
	end

	--男女双方的好友度都大于等于N=1000；
	if LuaFnGetFriendPoint( sceneId, selfId, tid ) < 1000 then
		return 0
	end

	if LuaFnGetFriendPoint( sceneId, tid, selfId ) < 1000 then
		return 0
	end

	--男女双方都单身；
	if LuaFnIsMarried( sceneId, selfId ) > 0 then
		return 0
	end

	if LuaFnIsMarried( sceneId, tid ) > 0 then
		return 0
	end

	--等级都大于等于N＝35级；
	if LuaFnGetLevel( sceneId, selfId ) < 35 then
		return 0
	end

	if LuaFnGetLevel( sceneId, tid ) < 35 then
		return 0
	end

	--男方身上金钱大于等于N=520520；
	if LuaFnGetMoney( sceneId, male ) < 520520 then
		return 0
	end

	return 1
end

--**********************************
--检测是否可以结婚
--**********************************
function x806003_CheckSubmit( sceneId, male, female )

	if LuaFnIsFriend( sceneId, male, female ) ~= 1 then
		return 0
	end

	if LuaFnIsFriend( sceneId, female, male ) ~= 1 then
		return 0
	end

	-- 离得太远了
	if IsInDist( sceneId, male, female, 10 ) ~= 1 then
		return 0
	end

	--男女双方的好友度都大于等于N=1000；
	if LuaFnGetFriendPoint( sceneId, male, female ) < 1000 then
		return 0
	end

	if LuaFnGetFriendPoint( sceneId, female, male ) < 1000 then
		return 0
	end

	--男女双方都单身；
	if LuaFnIsMarried( sceneId, male ) > 0 then
		return 0
	end

	if LuaFnIsMarried( sceneId, female ) > 0 then
		return 0
	end

	--等级都大于等于N＝35级；
	if LuaFnGetLevel( sceneId, male ) < 35 then
		return 0
	end

	if LuaFnGetLevel( sceneId, female ) < 35 then
		return 0
	end

	--男方身上金钱大于等于N=520520；
	if LuaFnGetMoney( sceneId, male ) < 520520 then
		return 0
	end

	--男女双方身上都要有至少一个物品空间；
	LuaFnBeginAddItem( sceneId )
	LuaFnAddItem( sceneId, x806003_g_Marry["ItemBonus"], 1 )
	ret = LuaFnEndAddItem( sceneId, male )

	if ret ~= 1 then
		return 0
	end

	ret = LuaFnEndAddItem( sceneId, female )

	if ret ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--接受
--**********************************
function x806003_OnAccept( sceneId, male, female )
	--扣除男方身上金钱520520；
	LuaFnCostMoney( sceneId, male, 520520 )

	--分别生成一个戒指给男女；
	--直接用 x806003_CheckSubmit 中 AddItem 的结果
	--ToDO: 戒指需要有两个人的名字
	LuaFnAddItemListToHuman( sceneId, male )
	LuaFnAddItemListToHuman( sceneId, female )

	--给双方分别增加婚姻技能
	for i, skillId in x806003_g_Marry["Skills"] do
		AddSkill( sceneId, male, skillId )
		AddSkill( sceneId, female, skillId )
	end

	local maleName = LuaFnGetName( sceneId, male )
	local femaleName = LuaFnGetName( sceneId, female )

	--分别发EMAIL给男女双方上面的所有好友（包括好友度不够的）。
	LuaFnSendMailToAllFriend( sceneId, male, "我亲爱的朋友，我已和" .. femaleName .. "喜结良缘，祝福我们吧！" )
	LuaFnSendMailToAllFriend( sceneId, female, "我亲爱的朋友，我已和" .. maleName .. "喜结良缘，祝福我们吧！" )

	--增加一个称号“某某的夫君”“某某的妻子”；
	LuaFnAwardSpouseTitle( sceneId, female, maleName .. "的妻子" )
	DispatchAllTitle( sceneId, female )
	LuaFnAwardSpouseTitle( sceneId, male, femaleName .. "的夫君" )
	DispatchAllTitle( sceneId, male )

	LuaFnMarry( sceneId, male, female )
end
