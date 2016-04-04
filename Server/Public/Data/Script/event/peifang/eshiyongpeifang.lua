--使用配方的脚本

--脚本号
x713501_g_scriptId = 713501

--使用配方
function x713501_ReadRecipe( sceneId, playerId, recipeIndex )
	RecipeFlag = IsPrescrLearned( sceneId, playerId, recipeIndex )

	if RecipeFlag < 1 then
	-- 没有学会
		SetPrescription( sceneId, playerId, recipeIndex, 1 )
		Msg2Player( sceneId,playerId,"你学会一项新的配方",MSG2PLAYER_PARA)
		return 1
	else
	-- 已学会
	-- 目前 SetPrescription 是个双开关，学会了再调用会放弃，但是不摧毁配方实体。测试使用
		Msg2Player( sceneId,playerId,"该配方已学会",MSG2PLAYER_PARA)
		return 0
	end

	return 0
end
