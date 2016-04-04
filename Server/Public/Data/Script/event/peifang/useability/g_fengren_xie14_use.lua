-- 缝纫配方脚本 用于使用技能制造物品
-- *******
-- 缝纫 2 级
-- 该脚本有以下三个必备功能函数：
-- x700914_AbilityCheck ——技能使用检查函数
-- x700914_AbilityConsume ——合成结束，进行相关消耗
-- x700914_AbilityProduce ——合成成功，产出产品

--------------------------------------------------------------------------------
-- 以下部分需要改写
--------------------------------------------------------------------------------
--脚本中文名
--2级帽配方 制造物品

-- 脚本号
x700914_g_ScriptId = 700914

-- 生活技能号
x700914_g_AbilityID = ABILITY_FENGREN

-- 该项生活技能的最大级别
x700914_g_AbilityMaxLevel = 12

-- 配方号
x700914_g_RecipeID = 68

-- 配方等级(需求技能的等级)
x700914_g_RecipeLevel = 1

-- 材料表
x700914_g_CaiLiao = {
	{ID = 20105002, Count = 1},
	{ID = 20107002, Count = 3},
	{ID = 20308092, Count = 1},
}

-- 产品表
x700914_g_ChanPin = {
	{ID = 10211004, Odds = 5000},
	{ID = 10211005, Odds = 10000},
}
--------------------------------------------------------------------------------
-- 以上部分需要改写
--------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	技能使用检查函数
----------------------------------------------------------------------------------------
function x700914_AbilityCheck(sceneId, selfId)
	-- 检查其他消耗
	VigorValue = x700914_g_RecipeLevel * 2 + 1
	if GetHumanVigor(sceneId, selfId) < VigorValue then
		return OR_NOT_ENOUGH_VIGOR
	end

	-- 检查是否材料足够
	StartPos = LuaFnGetMaterialStartBagPos(sceneId, selfId)
	EndPos = LuaFnGetMaterialEndBagPos(sceneId, selfId)

	for idx, Mat in x700914_g_CaiLiao do
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
function x700914_AbilityConsume(sceneId, selfId)
	-- 首先进行其他消耗
	VigorCost = x700914_g_RecipeLevel * 2 + 1
	VigorValue = GetHumanVigor(sceneId, selfId) - VigorCost
	SetHumanVigor(sceneId, selfId, VigorValue)

	-- 然后进行材料消耗
	StartPos = LuaFnGetMaterialStartBagPos(sceneId, selfId)
	EndPos = LuaFnGetMaterialEndBagPos(sceneId, selfId)

	for idx, Mat in x700914_g_CaiLiao do
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
function x700914_AbilityProduce(sceneId, selfId)
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x700914_g_AbilityID)

	-- 随机出一个数 [1, 10000]
	rand = random(10000)

	for i, item in x700914_g_ChanPin do
		if item.Odds >= rand then
			Quality = CallScriptFunction( ABILITYLOGIC_ID, "CalcQuality", x700914_g_RecipeLevel, AbilityLevel, x700914_g_AbilityMaxLevel )

			if LuaFnTryRecieveItem(sceneId, selfId, item.ID, Quality) < 0 then
				return OR_ERROR
			end

			LuaFnSendAbilitySuccessMsg( sceneId, selfId, x700914_g_AbilityID, x700914_g_RecipeID, item.ID )
			return OR_OK
		end
	end

	return OR_ERROR
end
