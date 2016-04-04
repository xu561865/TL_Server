-- 普通配方脚本
-- 700906
-- 烹饪初级
-- 该脚本有以下三个必备功能函数：
-- x700906_AbilityCheck ——技能使用检查函数
-- x700906_AbilityConsume ——合成结束，进行相关消耗
-- x700906_AbilityProduce ——合成成功，产出产品
-- 脚本号
x700906_g_ScriptId = 700906

-- 生活技能号
x700906_g_AbilityID = ABILITY_PENGREN

-- 该项生活技能的最大级别
x700906_g_AbilityMaxLevel = 12

-- 配方等级
x700906_g_RecipeLevel = 7

----------------------------------------------------------------------------------------
--	技能使用检查函数
----------------------------------------------------------------------------------------
function x700906_AbilityCheck(sceneId, selfId)
	-- 检查其他消耗
	VigorValue = x700906_g_RecipeLevel * 2 + 1
	if GetHumanVigor(sceneId, selfId) < VigorValue then
		return OR_NOT_ENOUGH_VIGOR
	end

	-- 检查是否材料足够
	--ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, PENGREN_CHUJICAILIAO, 3 )
	--if ret == 1 then
	--	return OR_OK
	--end

	--ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, PENGREN_ZHONGJICAILIAO, 2 )
	--if ret == 1 then
	--	return OR_OK
	--end

	ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, PENGREN_GAOJICAILIAO, 1 )
	if ret == 1 then
		return OR_OK
	end

	return OR_STUFF_LACK
end

----------------------------------------------------------------------------------------
--	合成结束，进行相关消耗
----------------------------------------------------------------------------------------
function x700906_AbilityConsume(sceneId, selfId)
	-- 首先进行其他消耗
	VigorCost = x700906_g_RecipeLevel * 2 + 1
	VigorValue = GetHumanVigor(sceneId, selfId) - VigorCost
	SetHumanVigor(sceneId, selfId, VigorValue)

	-- 然后进行材料消耗
	--ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, PENGREN_CHUJICAILIAO, 3 )
	--if ret == 1 then
	--	ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialConsume", sceneId, selfId, PENGREN_CHUJICAILIAO, 3 )
	--	return ret
	--end

	--ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, PENGREN_ZHONGJICAILIAO, 2 )
	--if ret == 1 then
	--	ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialConsume", sceneId, selfId, PENGREN_ZHONGJICAILIAO, 2 )
	--	return ret
	--end

	ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, PENGREN_GAOJICAILIAO, 1 )
	if ret == 1 then
		ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialConsume", sceneId, selfId, PENGREN_GAOJICAILIAO, 1 )
		return ret
	end

	return 0
end

----------------------------------------------------------------------------------------
--	合成成功，产出产品
----------------------------------------------------------------------------------------
function x700906_AbilityProduce(sceneId, selfId)
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x700906_g_AbilityID)

	ret = CallScriptFunction( ABILITYLOGIC_ID, "ProduceComplex", sceneId, selfId, PENGREN_GAOJICAILIAO, x700906_g_RecipeLevel, AbilityLevel, x700906_g_AbilityMaxLevel )
	if ret > -1 then
		LuaFnSendAbilitySuccessMsg( sceneId, selfId, x700906_g_AbilityID, 215, ret )
		return OR_OK
	end

	return OR_ERROR
end
