-- 缝纫配方脚本 用于使用技能制造物品
-- *******
-- 缝纫 5 级
-- 该脚本有以下三个必备功能函数：
-- x700923_AbilityCheck ——技能使用检查函数
-- x700923_AbilityConsume ——合成结束，进行相关消耗
-- x700923_AbilityProduce ——合成成功，产出产品

--------------------------------------------------------------------------------
-- 以下部分需要改写
--------------------------------------------------------------------------------
--脚本中文名
--2级帽配方 制造物品

-- 脚本号
x700923_g_ScriptId = 700923

-- 生活技能号
x700923_g_AbilityID = ABILITY_FENGREN

-- 该项生活技能的最大级别
x700923_g_AbilityMaxLevel = 12

-- 配方号
x700923_g_RecipeID = 89

-- 配方等级(需求技能的等级)
x700923_g_RecipeLevel = 1

-- 材料表
x700923_g_CaiLiao = {
	{ID = 20105005, Count = 2},
	{ID = 20107005, Count = 2},
	{ID = 20308065, Count = 1},
}

-- 产品表
x700923_g_ChanPin = {
	{ID = 10210012, Odds = 3333},
	{ID = 10210013, Odds = 6666},
	{ID = 10210014, Odds = 10000},
}
--------------------------------------------------------------------------------
-- 以上部分需要改写
--------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	技能使用检查函数
----------------------------------------------------------------------------------------
function x700923_AbilityCheck(sceneId, selfId)
	-- 检查其他消耗
	VigorValue = x700923_g_RecipeLevel * 2 + 1
	if GetHumanVigor(sceneId, selfId) < VigorValue then
		return OR_NOT_ENOUGH_VIGOR
	end

	-- 检查是否材料足够
	StartPos = LuaFnGetMaterialStartBagPos(sceneId, selfId)
	EndPos = LuaFnGetMaterialEndBagPos(sceneId, selfId)

	for idx, Mat in x700923_g_CaiLiao do
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
function x700923_AbilityConsume(sceneId, selfId)
	-- 首先进行其他消耗
	VigorCost = x700923_g_RecipeLevel * 2 + 1
	VigorValue = GetHumanVigor(sceneId, selfId) - VigorCost
	SetHumanVigor(sceneId, selfId, VigorValue)

	-- 然后进行材料消耗
	StartPos = LuaFnGetMaterialStartBagPos(sceneId, selfId)
	EndPos = LuaFnGetMaterialEndBagPos(sceneId, selfId)

	for idx, Mat in x700923_g_CaiLiao do
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
function x700923_AbilityProduce(sceneId, selfId)
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x700923_g_AbilityID)

	-- 随机出一个数 [1, 10000]
	rand = random(10000)

	for i, item in x700923_g_ChanPin do
		if item.Odds >= rand then
			Quality = CallScriptFunction( ABILITYLOGIC_ID, "CalcQuality", x700923_g_RecipeLevel, AbilityLevel, x700923_g_AbilityMaxLevel )

			if LuaFnTryRecieveItem(sceneId, selfId, item.ID, Quality) < 0 then
				return OR_ERROR
			end

			LuaFnSendAbilitySuccessMsg( sceneId, selfId, x700923_g_AbilityID, x700923_g_RecipeID, item.ID )
			return OR_OK
		end
	end

	return OR_ERROR
end
