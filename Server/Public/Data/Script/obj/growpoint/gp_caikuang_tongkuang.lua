--生长点
--对应生活技能：采矿	采矿技能的编号7
--铜矿
--脚本号710001
--铜矿石100%  黑宝石1%
--等级1

--每次打开必定获得的产品
x710001_g_MainItemId = 20103001
--可能得到的产品
x710001_g_SubItemId = 50113005
--需要技能Id
x710001_g_AbilityId = 7
--需要技能等级
x710001_g_AbilityLevel = 1


--生成函数开始************************************************************************
--每个ItemBox中最多10个物品
function 		x710001_OnCreate(sceneId,growPointType,x,y)
	--放入ItemBox同时放入一个物品
	targetId  = ItemBoxEnterScene(x,y,growPointType,sceneId,1,x710001_g_MainItemId)	--每个生长点最少能得到一个物品,这里直接放入itembox中一个
	--获得1~3的随机数,如果是1则不需要放入,如果多余1再用AddItemToBox增加物品
	ItemCount = random(1,3)
	if ItemCount ~= 1 then
		for i=1, (ItemCount - 1) do
			AddItemToBox(sceneId,targetId,1,x710001_g_MainItemId)
		end
	end
	--放入次要产品
	if random(1,100) == 1 then
		AddItemToBox(sceneId,targetId,1,x710001_g_SubItemId)
	end	
end
--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x710001_OnOpen(sceneId,selfId,targetId)
--返回类型
-- 0 表示打开成功
	ABilityID		=	GetItemBoxRequireAbilityID(sceneId,targetId)
	AbilityLevel = QueryHumanAbilityLevel(sceneId,selfId,ABilityID)
	res = x710001_OpenCheck(sceneId,selfId,ABilityID,AbilityLevel)
	return res
end
--打开前函数结束&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--回收函数开始########################################################################
function	 x710001_OnRecycle(sceneId,selfId,targetId)
	-- 增加熟练度
	ABilityID	=	GetItemBoxRequireAbilityID(sceneId,targetId)
	CallScriptFunction(ABILITYLOGIC_ID, "GainExperience", sceneId, selfId, ABilityID, x710001_g_AbilityLevel)
	--消耗精力
	CallScriptFunction(ABILITYLOGIC_ID, "EnergyCostCaiJi", sceneId, selfId, ABilityID, x710001_g_AbilityLevel)
		--返回1，生长点回收
		return 1
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x710001_OnProcOver(sceneId,selfId,targetId)
	return 0
end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

function	x710001_OpenCheck(sceneId,selfId,AbilityId,AblityLevel)
	--检查生活技能等级
	if AbilityLevel<x710001_g_AbilityLevel then
		return OR_NO_LEVEL
	end
	--检查精力
	if GetHumanEnergy(sceneId,selfId)< floor(x710001_g_AbilityLevel * 1.5 +2) then
		return OR_NOT_ENOUGH_ENERGY
	end
	return OR_OK
end
