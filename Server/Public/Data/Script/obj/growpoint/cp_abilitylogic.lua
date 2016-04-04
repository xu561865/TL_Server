-- 通用生活技能逻辑脚本
-- 脚本号
x701601_g_ScriptId = 701601

---------------------------------------------------------------------
---------------------------------------------------------------------

-- 初级制药材料
x701601_g_ZhiYao_ChuJiCaiLiao = {
	20101001, 20101002, 20101003, 20101004, 20101005,
	20101006, 20101007, 20101008,
}

-- 中级制药材料
x701601_g_ZhiYao_ZhongJiCaiLiao = {
	20101009, 20101010, 20101011, 20101012, 20101013,
	20101014, 20101015, 20101016, 20101017,
}

-- 高级制药材料
x701601_g_ZhiYao_GaoJiCaiLiao = {
	20101018, 20101019, 20101020, 20101021, 20101022,
	20101023, 20101024, 20101025, 20101026, 20101027,
	20101028, 20101029, 20101030,
}

-- 初级烹饪材料
x701601_g_PengRen_ChuJiCaiLiao = {
	20104001, 20104002, 20104003, 20106001, 20106002,
	20106003, 20102001, 20102002, 20102003,
}

-- 中级烹饪材料
x701601_g_PengRen_ZhongJiCaiLiao = {
	20104004, 20104005, 20104006, 20106004, 20106005,
	20106006, 20102004, 20102005, 20102006,
}

-- 高级烹饪材料
x701601_g_PengRen_GaoJiCaiLiao = {
	20104007, 20104008, 20104009, 20104010, 20104011,
	20104012, 20106007, 20106008, 20106009, 20106010,
	20106011, 20106012, 20102007, 20102008, 20102009,
	20102010, 20102011, 20102012,
}

-- 所有材料表
x701601_g_CaiLiaoBiao = {}

x701601_g_CaiLiaoBiao[ZHIYAO_CHUJICAILIAO] = x701601_g_ZhiYao_ChuJiCaiLiao
x701601_g_CaiLiaoBiao[ZHIYAO_ZHONGJICAILIAO] = x701601_g_ZhiYao_ZhongJiCaiLiao
x701601_g_CaiLiaoBiao[ZHIYAO_GAOJICAILIAO] = x701601_g_ZhiYao_GaoJiCaiLiao
x701601_g_CaiLiaoBiao[PENGREN_CHUJICAILIAO] = x701601_g_PengRen_ChuJiCaiLiao
x701601_g_CaiLiaoBiao[PENGREN_ZHONGJICAILIAO] = x701601_g_PengRen_ZhongJiCaiLiao
x701601_g_CaiLiaoBiao[PENGREN_GAOJICAILIAO] = x701601_g_PengRen_GaoJiCaiLiao

-- 材料检查函数，判断玩家身上是否有足够 quantity 的 class 类材料
-- 如果符合条件，则返回 1，否则返回 0

-- class: 材料的种类
-- quantity: 材料所需的数量
function x701601_MaterialCheck(sceneId, selfId, class, quantity)
	StartPos = LuaFnGetMaterialStartBagPos(sceneId, selfId)
	EndPos = LuaFnGetMaterialEndBagPos(sceneId, selfId)
	MaterialList = x701601_g_CaiLiaoBiao[class]
	Count = 0

	for i = StartPos, EndPos do
		ItemSerial = LuaFnGetItemTableIndexByIndex(sceneId, selfId, i)

		if ItemSerial ~= 0 then
			for idx, Mat in MaterialList do
				if ItemSerial == Mat then
					Count = Count + LuaFnGetItemCountInBagPos(sceneId, selfId, i)
					-- 找到了马上停止循环
					break
				end
			end

			-- 在这里进行判断，以减少循环次数（特别是当材料充裕时）
			if Count >= quantity then
				return 1
			end
		end

	end

	return 0
end

-- 消耗材料，消耗玩家 quantity 数量的 class 类材料
-- 本函数不保证材料足够，由调用函数来保证
-- 成功返回 1，失败返回 0

-- class: 材料的种类
-- quantity: 材料所需的数量
function x701601_MaterialConsume(sceneId, selfId, class, quantity)
	StartPos = LuaFnGetMaterialStartBagPos(sceneId, selfId)
	EndPos = LuaFnGetMaterialEndBagPos(sceneId, selfId)
	MaterialList = x701601_g_CaiLiaoBiao[class]
	Count = quantity

	for i = StartPos, EndPos do
		ItemSerial = LuaFnGetItemTableIndexByIndex(sceneId, selfId, i)

		if ItemSerial ~= 0 then
			for idx, Mat in MaterialList do
				if ItemSerial == Mat then
					DelCount = GetItemCount(sceneId, selfId, ItemSerial)

					if DelCount > Count then
						DelCount = Count
					end

					DelItem(sceneId, selfId, ItemSerial, DelCount)
					Count = Count - DelCount
					-- 找到了马上停止循环
					break
				end
			end

			-- 在这里进行判断，以减少循环次数（特别是当材料充裕时）
			if Count < 1 then
				return 1
			end
		end

	end

	return 0
end


-- 初级制药产品
x701601_g_ZhiYao_ChuJiChanPin = {
	{ID = 30001001, Odds = 769},
	{ID = 30002001, Odds = 1538},
	{ID = 30003001, Odds = 2307},
	{ID = 30001002, Odds = 3076},
	{ID = 30002002, Odds = 3845},
	{ID = 30003002, Odds = 4614},
	{ID = 30004001, Odds = 5383},
	{ID = 30004006, Odds = 6152},
	{ID = 30004011, Odds = 6920},
	{ID = 30004016, Odds = 7688},
	{ID = 30004021, Odds = 8456},
	{ID = 30005001, Odds = 9224},
	{ID = 30005006, Odds = 9992},
	{ID = 30001003, Odds = 9993},
	{ID = 30002003, Odds = 9994},
	{ID = 30003003, Odds = 9995},
	{ID = 30005011, Odds = 9996},
	{ID = 30005013, Odds = 9997},
	{ID = 30005015, Odds = 9998},
	{ID = 30005017, Odds = 9999},
	{ID = 30005019, Odds = 10000},
}

-- 中级制药产品
x701601_g_ZhiYao_ZhongJiChanPin = {
	{ID = 30001004, Odds = 500},
	{ID = 30002004, Odds = 1000},
	{ID = 30003004, Odds = 1500},
	{ID = 30004002, Odds = 2000},
	{ID = 30004007, Odds = 2500},
	{ID = 30004012, Odds = 3000},
	{ID = 30004017, Odds = 3500},
	{ID = 30004022, Odds = 4000},
	{ID = 30005002, Odds = 4500},
	{ID = 30005007, Odds = 5000},
	{ID = 30006001, Odds = 5499},
	{ID = 30006003, Odds = 5998},
	{ID = 30006005, Odds = 6497},
	{ID = 30006007, Odds = 6996},
	{ID = 30006009, Odds = 7495},
	{ID = 30006011, Odds = 7994},
	{ID = 30006013, Odds = 8493},
	{ID = 30001005, Odds = 8992},
	{ID = 30002005, Odds = 9491},
	{ID = 30003005, Odds = 9990},
	{ID = 30001006, Odds = 9991},
	{ID = 30002006, Odds = 9992},
	{ID = 30003007, Odds = 9993},
	{ID = 30004003, Odds = 9994},
	{ID = 30004008, Odds = 9995},
	{ID = 30004013, Odds = 9996},
	{ID = 30004018, Odds = 9997},
	{ID = 30004023, Odds = 9998},
	{ID = 30005003, Odds = 9999},
	{ID = 30005008, Odds = 10000},
}

-- 高级制药产品
x701601_g_ZhiYao_GaoJiChanPin = {
	{ID = 30001007, Odds = 554},
	{ID = 30001008, Odds = 1108},
	{ID = 30002008, Odds = 1662},
	{ID = 30003008, Odds = 2216},
	{ID = 30004004, Odds = 2770},
	{ID = 30004009, Odds = 3324},
	{ID = 30004014, Odds = 3878},
	{ID = 30004019, Odds = 4432},
	{ID = 30004024, Odds = 4986},
	{ID = 30005004, Odds = 5540},
	{ID = 30005009, Odds = 6094},
	{ID = 30005018, Odds = 6648},
	{ID = 30005020, Odds = 7202},
	{ID = 30005012, Odds = 7756},
	{ID = 30005014, Odds = 8310},
	{ID = 30005016, Odds = 8864},
	{ID = 30002007, Odds = 9417},
	{ID = 30003007, Odds = 9971},
	{ID = 30007004, Odds = 9972},
	{ID = 30007005, Odds = 9973},
	{ID = 30007006, Odds = 9974},
	{ID = 30007007, Odds = 9975},
	{ID = 30007008, Odds = 9976},
	{ID = 30007009, Odds = 9977},
	{ID = 30006002, Odds = 9978},
	{ID = 30006004, Odds = 9979},
	{ID = 30006006, Odds = 9980},
	{ID = 30006008, Odds = 9981},
	{ID = 30006010, Odds = 9982},
	{ID = 30006012, Odds = 9983},
	{ID = 30006014, Odds = 9984},
	{ID = 30001009, Odds = 9985},
	{ID = 30002009, Odds = 9986},
	{ID = 30003009, Odds = 9987},
	{ID = 30001010, Odds = 9988},
	{ID = 30002010, Odds = 9989},
	{ID = 30003010, Odds = 9990},
	{ID = 30004005, Odds = 9991},
	{ID = 30004010, Odds = 9992},
	{ID = 30004015, Odds = 9993},
	{ID = 30004020, Odds = 9994},
	{ID = 30004025, Odds = 9995},
	{ID = 30004030, Odds = 9996},
	{ID = 30004035, Odds = 9997},
	{ID = 30007001, Odds = 9998},
	{ID = 30007002, Odds = 9999},
	{ID = 30007003, Odds = 10000},
}

-- 初级烹饪产品
x701601_g_PengRen_ChuJiChanPin = {
	{ID = 30101013, Odds = 1111},
	{ID = 30101001, Odds = 2222},
	{ID = 30101014, Odds = 3333},
	{ID = 30101002, Odds = 4444},
	{ID = 30101015, Odds = 5555},
	{ID = 30102001, Odds = 6666},
	{ID = 30102005, Odds = 7777},
	{ID = 30102013, Odds = 8888},
	{ID = 30102017, Odds = 9998},
	{ID = 30101003, Odds = 9999},
	{ID = 30102009, Odds = 10000},
}

-- 中级烹饪产品
x701601_g_PengRen_ZhongJiChanPin = {
	{ID = 30102010, Odds = 1111},
	{ID = 30101016, Odds = 2222},
	{ID = 30101004, Odds = 3333},
	{ID = 30102002, Odds = 4443},
	{ID = 30102014, Odds = 5553},
	{ID = 30102006, Odds = 6663},
	{ID = 30102018, Odds = 7773},
	{ID = 30101017, Odds = 8883},
	{ID = 30101005, Odds = 9993},
	{ID = 30102015, Odds = 9994},
	{ID = 30101018, Odds = 9995},
	{ID = 30101006, Odds = 9996},
	{ID = 30102011, Odds = 9997},
	{ID = 30102003, Odds = 9998},
	{ID = 30102007, Odds = 9999},
	{ID = 30102019, Odds = 10000},
}

-- 高级烹饪产品
x701601_g_PengRen_GaoJiChanPin = {
	{ID = 30101019, Odds = 1111},
	{ID = 30101007, Odds = 2221},
	{ID = 30101008, Odds = 3331},
	{ID = 30101020, Odds = 4441},
	{ID = 30102016, Odds = 5551},
	{ID = 30102008, Odds = 6661},
	{ID = 30102004, Odds = 7771},
	{ID = 30102012, Odds = 8881},
	{ID = 30102020, Odds = 9991},
	{ID = 30101009, Odds = 9992},
	{ID = 30101021, Odds = 9993},
	{ID = 30101022, Odds = 9994},
	{ID = 30101010, Odds = 9995},
	{ID = 30101023, Odds = 9996},
	{ID = 30101011, Odds = 9997},
	{ID = 30101012, Odds = 9998},
	{ID = 30103001, Odds = 9999},
	{ID = 30101024, Odds = 10000},
}

-- 所有产品表
x701601_g_ChanPinBiao = {}

x701601_g_ChanPinBiao[ZHIYAO_CHUJICAILIAO] = x701601_g_ZhiYao_ChuJiChanPin
x701601_g_ChanPinBiao[ZHIYAO_ZHONGJICAILIAO] = x701601_g_ZhiYao_ZhongJiChanPin
x701601_g_ChanPinBiao[ZHIYAO_GAOJICAILIAO] = x701601_g_ZhiYao_GaoJiChanPin
x701601_g_ChanPinBiao[PENGREN_CHUJICAILIAO] = x701601_g_PengRen_ChuJiChanPin
x701601_g_ChanPinBiao[PENGREN_ZHONGJICAILIAO] = x701601_g_PengRen_ZhongJiChanPin
x701601_g_ChanPinBiao[PENGREN_GAOJICAILIAO] = x701601_g_PengRen_GaoJiChanPin

-- 生成合成物
-- 成功返回 物品 ID，失败返回 -1

-- class: 合成物的种类
function x701601_ProduceComplex(sceneId, selfId, class, RecipeLevel, AbilityLevel, AbilityMaxLevel)
	ComplexList = x701601_g_ChanPinBiao[class]
	-- 随机出一个数 [1, 10000]
	rand = random(10000)

	for i, item in ComplexList do
		if item.Odds >= rand then
			Quality = x701601_CalcQuality(RecipeLevel, AbilityLevel, AbilityMaxLevel)

			if LuaFnTryRecieveItem(sceneId, selfId, item.ID, Quality) < 0 then
				return -1
			end

			return item.ID
		end
	end

	return -1
end

-- 计算产品品质
function x701601_CalcQuality(RecipeLevel, AbilityLevel, AbilityMaxLevel)
	-- 随机出一个数 [0, 49]
	Quality = random(0, 49)
	return Quality
end

---------------------------------------------------------------------
---------------------------------------------------------------------


-------------------------------------------------------------------------
-- 合成结束时的成功率计算
function x701601_CheckForResult(sceneId, selfId, AbilityID, RecipeLevel)
	-- 辅助生活技能级别
	local AssisAbilityLevel

	if AbilityID == ABILITY_PENGREN then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_YANGSHENGFA)
	elseif AbilityID == ABILITY_ZHIYAO then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_YAOLI)
	elseif AbilityID == ABILITY_KAIGUANG then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_FOFA)
	elseif AbilityID == ABILITY_SHENGHUOSHU then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_CAIHUOSHU)
	elseif AbilityID == ABILITY_NIANGJIU then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_LIANHUALUO)
	elseif AbilityID == ABILITY_XUANBINGSHU then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_CAIBINGSHU)
	elseif AbilityID == ABILITY_ZHIGU then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_JINGMAIBAIJUE)
	elseif AbilityID == ABILITY_ZHIDU then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_YINCHONGSHU)
	elseif AbilityID == ABILITY_ZHIFU then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_LINGXINSHU)
	elseif AbilityID == ABILITY_LIANDAN then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_DAOFA)
	elseif AbilityID == ABILITY_QIMENDUNJIA then
		AssisAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_LIUYIFENGGU)
	else
		return OR_OK
	end

	-- 概率
	odds = 30 + AssisAbilityLevel / 3 - RecipeLevel * 2;
	rand = random(100)
	if odds >= rand then
		-- 成功
		return OR_OK
	end

	return OR_FAILURE
end

-- 配方合成结束时的熟练度增长
function x701601_GainExperience(sceneId, selfId, AbilityID, RecipeLevel)
	-- 生活技能级别
	local AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, AbilityID)
	local MinLevelDisparity = 0
	local MaxLevelDisparity = 1
	local ExpGain = 0

	ExpLimit = LEVELUP_ABILITY[AbilityLevel].AbilityExpLimitTop
	ExpNow = GetAbilityExp(sceneId, selfId, AbilityID)

	if ExpLimit <= ExpNow then
		return
	end

	LevelDisparity = AbilityLevel - RecipeLevel
	if LevelDisparity >= 0 then
		if LevelDisparity <= MinLevelDisparity then
			ExpGain = 100
		elseif LevelDisparity <= MaxLevelDisparity then
			ExpGain = 100 / (LevelDisparity - MinLevelDisparity + 1)
		end
	end

	Exp = ExpGain + ExpNow

	if Exp > ExpLimit then
		Exp = ExpLimit
	end

	SetAbilityExp(sceneId, selfId, AbilityID, Exp)
	--Msg2Player(sceneId,selfId,"熟练度增加到"..floor(Exp/100).."。",MSG2PLAYER_PARA)
end

---------------------------------------------------------------------------

--检查某项生活技能是否需要升级(根据熟练度自动升级)
--AbilityID 指生活技能 ID
--
function	x701601_CheckAbilityLevel(sceneId,selfId,AbilityID)
	--玩家加工技能的等级
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, AbilityID)
	--玩家加工技能的熟练度
	ExpPoint = GetAbilityExp(sceneId, selfId, AbilityID)
	Flag = 0

	if AbilityLevel<=10 then
		if AbilityLevel*10<ExpPoint then
			Flag = 1
		end
	elseif AbilityLevel<=20 then
		if (10*10 + (AbilityLevel-10)*20)<ExpPoint then
			Flag = 1
		end
	--elseif ...
	end

	if Flag>0 then
		SetHumanAbilityLevel(sceneId, selfId, AbilityID, AbilityLevel+1)
		AddText(sceneId, selfId, 0, "生活技能升级了！")
	end

end

function	x701601_TooManyGems(sceneId,selfId, EquipPos)
	GemCount = GetGemEmbededCount(sceneId, selfId, EquipPos)

	if GemCount<3 then
		return 0
	end

	--返回 1 表示宝石镶嵌数量已满
	return 1
end

--宝石镶嵌接口
--GemIndex 宝石对应的物品唯一号(ItemIndex)
--selfId 指合成物品的玩家
--返回值 0:成功，其他失败 1:宝石消失 2:装备消失 3:宝石装备都消失 4:精力不足
function	x701601_EmbedProc(sceneId,selfId, GemIndex)
	--玩家加工技能的等级
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_XIANGQIAN)
	--玩家加工技能的熟练度
	ExpPoint = GetAbilityExp(sceneId, selfId, ABILITY_XIANGQIAN)
	--宝石等级(1~8)
	GemQual = GetItemQuality(GemIndex)
	--宝石类别
	GemType = GetItemIndex(GemIndex)

	--有多大几率生成，几率算法可以进行修改
	odds = 90 - (GemQual - 1) * 5
	rand = random(100)

	-- 计算精力消耗
	EnergyCost = GemQual * 2 + 1
	MyNewEnergy = GetHumanEnergy( sceneId, selfId ) - EnergyCost
	if MyNewEnergy < 0 then
		return 4
	end

	-- 消耗精力
	SetHumanEnergy( sceneId, selfId, MyNewEnergy )

	if odds>rand then
	--增加熟练度
		--x701601_GainExperience(sceneId, selfId, ABILITY_XIANGQIAN, GemQual)
		return 0
	else
		return 1
	end
end

--宝石镶嵌时判断两个宝石是否冲突
--Gem1SerialNumber 宝石的序列号
--Gem2SerialNumber 宝石的序列号
--返回值 true 表示冲突，false 表示不冲突
function	x701601_IsGemConflict(sceneId, Gem1SerialNumber, Gem2SerialNumber)
	--得到物品的类型（宝石大类）
	return (LuaFnGetItemType(Gem1SerialNumber) == LuaFnGetItemType(Gem2SerialNumber))
end

-- 装备允许镶嵌的宝石类型表
x701601_g_EquipGemTable = {}
x701601_g_EquipGemTable[HEQUIP_WEAPON] = {1, 2, 3, 4}
x701601_g_EquipGemTable[HEQUIP_CAP] = {11, 12, 13, 14}
x701601_g_EquipGemTable[HEQUIP_ARMOR] = {11, 12, 13, 14}
x701601_g_EquipGemTable[HEQUIP_CUFF] = {11, 12, 13, 14}
x701601_g_EquipGemTable[HEQUIP_BOOT] = {11, 12, 13, 14}
x701601_g_EquipGemTable[HEQUIP_SASH] = {}
x701601_g_EquipGemTable[HEQUIP_RING] = {}
x701601_g_EquipGemTable[HEQUIP_NECKLACE] = {}

function	x701601_IsGemFitEquip(sceneId, selfId, GemSerialNum, EquipBagIndex)
	EquipType = LuaFnGetBagEquipType(sceneId, selfId, EquipBagIndex)
	GemType = LuaFnGetItemType(GemSerialNum)

	if EquipType == -1 then
		return 0
	end

	for i, gem in x701601_g_EquipGemTable[EquipType] do
		if gem == GemType then
			return 1
		end
	end

	return 0
end

--采集类生活技能的精力消耗处理
function x701601_EnergyCostCaiJi(sceneId, selfId, AbilityID, BaseLevel)
	--需要消耗精力
	x701601_g_EnergyCost = floor(BaseLevel * 1.5 +2)
	--获得当前精力
	x701601_g_EnertyNow = GetHumanEnergy(sceneId,selfId)
	--消耗后的精力
	x701601_g_EnertyNow = x701601_g_EnertyNow - x701601_g_EnergyCost
	if x701601_g_EnertyNow < 0 then
		x701601_g_EnertyNow = 0
	end
	--设置消耗后的精力
	SetHumanEnergy(sceneId,selfId,x701601_g_EnertyNow)
	--Msg2Player(sceneId,selfId,"消耗#R"..x701601_g_EnergyCost.."#W点精力。",MSG2PLAYER_PARA)
end

--种植技能的活力消耗处理
function x701601_VigorCostZhongZhi(sceneId, selfId, AbilityID, BaseLevel)
	--需要消耗活力
	x701601_g_VigorCost = floor(BaseLevel * 1.5 +2)
	--获得当前活力
	x701601_g_VigorNow = GetHumanVigor(sceneId,selfId)
	--消耗后的精力
	x701601_g_VigorNow = x701601_g_VigorNow - x701601_g_VigorCost
	if x701601_g_VigorNow < 0 then
		x701601_g_VigorNow = 0
	end
	--设置消耗后的精力
	SetHumanVigor(sceneId,selfId,x701601_g_VigorNow)
	--Msg2Player(sceneId,selfId,"消耗#R"..x701601_g_VigorCost.."#W点活力。",MSG2PLAYER_PARA)
end
