-- 宝石合成

-- 脚本号
x701602_g_scriptId = 701602

-- 脚本名称
x701602_g_scriptName = "合成宝石"

--**********************************************************************
--任务入口函数
--**********************************************************************
function x701602_OnDefaultEvent( sceneId, selfId, targetId )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 23)

end

--**********************************************************************
--列举事件
--**********************************************************************
function x701602_OnEnumerate( sceneId, selfId, targetId )

	AddNumText(sceneId, x701602_g_scriptId, x701602_g_scriptName)

end

--**********************************************************************
--宝石合成接口
--bagIndex1, bagIndex2：两块宝石所在的格子
--**********************************************************************
function x701602_GemCompound( sceneId, selfId, bagIndex1, bagIndex2 )

	SerialNum1 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, bagIndex1 )
	SerialNum2 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, bagIndex2 )

	if SerialNum1 ~= SerialNum2 then
		return OR_STUFF_LACK
	end

	Quality = LuaFnGetItemQuality( SerialNum1 )
	if Quality >= 9 then
		return OR_CANNOT_UPGRADE
	end

	-- 计算精力消耗
	EnergyCost = Quality * 2 + 1
	MyNewEnergy = GetHumanEnergy( sceneId, selfId ) - EnergyCost
	if MyNewEnergy < 0 then
		return OR_NOT_ENOUGH_ENERGY
	end

	-- 计算新的宝石的编号，增加 Quality 的权指
	NewSerialNum = SerialNum1 + 100000

	-- 消耗精力
	SetHumanEnergy( sceneId, selfId, MyNewEnergy )

	-- 删除原材料
	LuaFnEraseItem( sceneId, selfId, bagIndex1 )
	LuaFnEraseItem( sceneId, selfId, bagIndex2 )

	-- 生成合成物，最后一个 1 是品质，不影响宝石
	res = LuaFnTryRecieveItem( sceneId, selfId, NewSerialNum, 1 )
	if res == -1 then
		Msg2Player( sceneId, selfId, "测试数据：宝石合成失败(原宝石编号：" .. SerialNum1 .. "，合成宝石编号："
					.. NewSerialNum .. ")，请提交本条信息。", MSG2PLAYER_PARA)
		return OR_FAILURE
	end

	-- 提示生成物
	LuaFnSendAbilitySuccessMsg( sceneId, selfId, -1, -1, NewSerialNum )
	return OR_OK
end
