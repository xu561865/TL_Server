-- 普通配方脚本
-- 700902
-- 制药中级
-- 该脚本有以下三个必备功能函数：
-- x700902_AbilityCheck ——技能使用检查函数
-- x700902_AbilityConsume ——合成结束，进行相关消耗
-- x700902_AbilityProduce ——合成成功，产出产品
-- 脚本号
x700902_g_ScriptId = 700902

-- 生活技能号
x700902_g_AbilityID = ABILITY_ZHIYAO

-- 该项生活技能的最大级别
x700902_g_AbilityMaxLevel = 12

-- 配方等级
x700902_g_RecipeLevel = 4

----------------------------------------------------------------------------------------
--	技能使用检查函数
----------------------------------------------------------------------------------------
function x700902_AbilityCheck(sceneId, selfId)
	-- 检查其他消耗
	VigorValue = x700902_g_RecipeLevel * 2 + 1
	if GetHumanVigor(sceneId, selfId) < VigorValue then
		return OR_NOT_ENOUGH_VIGOR
	end

	-- 检查是否材料足够
	--ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, ZHIYAO_CHUJICAILIAO, 3 )
	--if ret == 1 then
	--	return OR_OK
	--end

	ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, ZHIYAO_ZHONGJICAILIAO, 2 )
	if ret == 1 then
		return OR_OK
	end

	ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, ZHIYAO_GAOJICAILIAO, 1 )
	if ret == 1 then
		return OR_OK
	end

	return OR_STUFF_LACK
end

----------------------------------------------------------------------------------------
--	合成结束，进行相关消耗
----------------------------------------------------------------------------------------
function x700902_AbilityConsume(sceneId, selfId)
	-- 首先进行其他消耗
	VigorCost = x700902_g_RecipeLevel * 2 + 1
	VigorValue = GetHumanVigor(sceneId, selfId) - VigorCost
	SetHumanVigor(sceneId, selfId, VigorValue)

	-- 然后进行材料消耗
	--ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, ZHIYAO_CHUJICAILIAO, 3 )
	--if ret == 1 then
	--	ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialConsume", sceneId, selfId, ZHIYAO_CHUJICAILIAO, 3 )
	--	return ret
	--end

	ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, ZHIYAO_ZHONGJICAILIAO, 2 )
	if ret == 1 then
		ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialConsume", sceneId, selfId, ZHIYAO_ZHONGJICAILIAO, 2 )
		return ret
	end

	ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialCheck", sceneId, selfId, ZHIYAO_GAOJICAILIAO, 1 )
	if ret == 1 then
		ret = CallScriptFunction( ABILITYLOGIC_ID, "MaterialConsume", sceneId, selfId, ZHIYAO_GAOJICAILIAO, 1 )
		return ret
	end

	return 0
end

----------------------------------------------------------------------------------------
--	合成成功，产出产品
----------------------------------------------------------------------------------------
function x700902_AbilityProduce(sceneId, selfId)
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x700902_g_AbilityID)

	ret = CallScriptFunction( ABILITYLOGIC_ID, "ProduceComplex", sceneId, selfId, ZHIYAO_ZHONGJICAILIAO, x700902_g_RecipeLevel, AbilityLevel, x700902_g_AbilityMaxLevel )
	if ret > -1 then
		LuaFnSendAbilitySuccessMsg( sceneId, selfId, x700902_g_AbilityID, 164, ret )
		return OR_OK
	end

	return OR_ERROR
end
