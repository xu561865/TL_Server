--生长点脚本，芋头3
--脚本号
--g_ScriptId = 711035

--此生长点编号
x711035_g_GpId = 536

--生长点需要的等级
x711035_g_ItemBoxNeedLevel = 12

function	x711035_OnOpen(SceneId,selfId,TargetId)
	--得到技能等级
	AbilityLevel = QueryHumanAbilityLevel( SceneId, selfId, ABILITY_ZHONGZHI)
	if AbilityLevel >= x711035_g_ItemBoxNeedLevel then
		return OR_OK
	else
		return OR_NO_LEVEL
	end
end

function	x711035_OnProcOver(SceneId,selfId,TargetId)
	return OR_OK
end

function	 x711035_OnRecycle(SceneId,selfId,TargetId)
	--取得生长点的坐标
	GP_X = GetItemBoxWorldPosX(SceneId,TargetId)
	GP_Z = GetItemBoxWorldPosZ(SceneId,TargetId)
	--下取整
	GP_X = floor(GP_X)
	GP_Z = floor(GP_Z)
	--判断种植牌的位置在哪个种植牌管辖的范围内
	for i, findid in PLANTNPC_ADDRESS do
		if	(GP_X >= findid.X_MIN)  and (GP_Z >= findid.Z_MIN) and (GP_X <= findid.X_MAX)  and (GP_Z <= findid.Z_MAX) and (SceneId == findid.Scene) then
			num = i	
			break
		end
	end
	
	--如果找不到正确的位置则返回
	if num == 0 then
		return
	end
	--找到正确的编号，把种植牌-1
	PLANTFLAG[num] = PLANTFLAG[num] - 1
	return 1
end
