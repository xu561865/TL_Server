--选择植物的脚本

--脚本号
x713550_g_scriptId = 713550

AbilityId =	ABILITY_ZHONGZHI

--**********************************
--任务入口函数
--**********************************
function x713550_OnDefaultEvent( sceneId, selfId, targetId, zhiwuId )
	--判断种植牌的位置
	PlantFlag_X,PlantFlag_Z =  GetWorldPos(sceneId,targetId)	--得到npc坐标
	PlantFlag_X = floor(PlantFlag_X)
	PlantFlag_Z = floor(PlantFlag_Z)
	for i, findid in PLANTNPC_ADDRESS do
		if	((PlantFlag_X ==  findid.X)  and (PlantFlag_Z == findid.Z) and (sceneId == findid.Scene)) then
			num = i
			break
		end
	end
	--如果没找到对应位置
	if num == 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "水土流失，请爱护大自然！")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	--如果土地不是闲置状态
	if	PLANTFLAG[num] ~= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "土地已被种植，请过一会儿再来吧！")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end

	--如果活力不足
	x713550_g_vigor = GetHumanVigor(sceneId,selfId)
	--查找植物等级
	for i,g_findid in V_ZHONGZHI_ID do
		if g_findid == zhiwuId then
			x713550_g_ZhiWuLevel = V_ZHONGZHI_NEEDLEVEL[i]
			break
		end
	end
	if x713550_g_vigor < floor(x713550_g_ZhiWuLevel * 1.5 +2) then
		BeginEvent(sceneId)
			AddText(sceneId, "你的活力不足!")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	--增加熟练度
	CallScriptFunction(ABILITYLOGIC_ID, "GainExperience", sceneId, selfId, AbilityId, x713550_g_ZhiWuLevel)
	--删除相应活力
		CallScriptFunction(ABILITYLOGIC_ID, "VigorCostZhongZhi", sceneId, selfId, AbilityId, x713550_g_ZhiWuLevel)
	--放置生长点
	for i,g_findid in V_ZHONGZHI_ID do
		if g_findid == zhiwuId then
			ItemBoxTypeId = V_ZHONGZHI_ITEMBOX_ID[i]
			break
		end
	end
	ItemBoxId01 = ItemBoxEnterScene(PlantFlag_X+1.5,PlantFlag_Z-1,ItemBoxTypeId,sceneId,0)
	ItemBoxId02 = ItemBoxEnterScene(PlantFlag_X+1.5,PlantFlag_Z+2,ItemBoxTypeId,sceneId,0)
	ItemBoxId03 = ItemBoxEnterScene(PlantFlag_X-0.5,PlantFlag_Z-1,ItemBoxTypeId,sceneId,0)
	ItemBoxId04 = ItemBoxEnterScene(PlantFlag_X-0.5,PlantFlag_Z+2,ItemBoxTypeId,sceneId,0)
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId01,450000)
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId02,450000)
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId03,450000)
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId04,450000)
		
	--AbilityExp	=	GetAbilityExp(sceneId, selfId, AbilityId)
	--增加一些经验
	--SetAbilityExp(sceneId, selfId, AbilityId, AbilityExp+1)
	--AbilityExp	=	GetAbilityExp(sceneId, selfId, AbilityId)
	
	PLANTFLAG[num] = 4
	BeginEvent(sceneId)
		AddText(sceneId, "你已经开始种植")
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)

 	return OR_OK
end
