-- 缝纫配方脚本 用于使用技能制造物品
-- *******
-- 缝纫 7 级
-- 该脚本有以下三个必备功能函数：
-- x700932_AbilityCheck ——技能使用检查函数
-- x700932_AbilityConsume ——合成结束，进行相关消耗
-- x700932_AbilityProduce ——合成成功，产出产品

--------------------------------------------------------------------------------
-- 以下部分需要改写
--------------------------------------------------------------------------------
--脚本中文名
--2级帽配方 制造物品

-- 脚本号
x700932_g_ScriptId = 700932

-- 生活技能号
x700932_g_AbilityID = ABILITY_FENGREN

-- 该项生活技能的最大级别
x700932_g_AbilityMaxLevel = 12

-- 配方号
x700932_g_RecipeID = 106

-- 配方等级(需求技能的等级)
x700932_g_RecipeLevel = 1

-- 材料表
x700932_g_CaiLiao = {
	{ID = 20105007, Count = 3},
	{ID = 20107007, Count = 2},
	{ID = 20308077, Count = 1},
}

-- 产品表
x700932_g_ChanPin = {
	{ID = 10213018, Odds = 1666},
	{ID = 10213019, Odds = 3332},
	{ID = 10213020, Odds = 4998},
	{ID = 10213021, Odds = 6664},
	{ID = 10213022, Odds = 8330},
	{ID = 10213023, Odds = 10000},
}
--------------------------------------------------------------------------------
-- 以上部分需要改写
--------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	技能使用检查函数
----------------------------------------------------------------------------------------
function x700932_AbilityCheck(sceneId, selfId)
	-- 检查其他消耗
	VigorValue = x700932_g_RecipeLevel * 2 + 1
	if GetHumanVigor(sceneId, selfId) < VigorValue then
		return OR_NOT_ENOUGH_VIGOR
	end

	-- 检查是否材料足够
	StartPos = LuaFnGetMaterialStartBagPos(sceneId, selfId)
	EndPos = LuaFnGetMaterialEndBagPos(sceneId, selfId)

	for idx, Mat in x700932_g_CaiLiao do
		nCount = Mat.Count

		ret = GetItemCount(sceneId, selfId, Mat.ID)
		if ret < nCount then
			return OR_STUFF_LACK
		end
	end

	return OR_OK
end

----------------------------------------------------------------------------------------
--	合成结束，进行相关消耗
----------------------------------------------------------------------------------------
function x700932_AbilityConsume(sceneId, selfId)
	-- 首先进行其他消耗
	VigorCost = x700932_g_RecipeLevel * 2 + 1
	VigorValue = GetHumanVigor(sceneId, selfId) - VigorCost
	SetHumanVigor(sceneId, selfId, VigorValue)

	-- 然后进行材料消耗
	StartPos = LuaFnGetMaterialStartBagPos(sceneId, selfId)
	EndPos = LuaFnGetMaterialEndBagPos(sceneId, selfId)

	for idx, Mat in x700932_g_CaiLiao do
		nCount = Mat.Count

		ret = DelItem(sceneId, selfId, Mat.ID, nCount)
		if ret ~= 1 then
			return 0
		end
	end

	return 1
end

----------------------------------------------------------------------------------------
--	合成成功，产出产品
----------------------------------------------------------------------------------------
function x700932_AbilityProduce(sceneId, selfId)
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x700932_g_AbilityID)

	-- 随机出一个数 [1, 10000]
	rand = random(10000)

	for i, item in x700932_g_ChanPin do
		if item.Odds >= rand then
			Quality = CallScriptFunction( ABILITYLOGIC_ID, "CalcQuality", x700932_g_RecipeLevel, AbilityLevel, x700932_g_AbilityMaxLevel )

			if LuaFnTryRecieveItem(sceneId, selfId, item.ID, Quality) < 0 then
				return OR_ERROR
			end

			LuaFnSendAbilitySuccessMsg( sceneId, selfId, x700932_g_AbilityID, x700932_g_RecipeID, item.ID )
			return OR_OK
		end
	end

	return OR_ERROR
end
