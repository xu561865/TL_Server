-- 宠物通用功能脚本

-- 脚本号
x335000_g_scriptId = 335000

-- 宠物技能学习
function x335000_PetStudy( sceneId, selfId, skillId )
	petGUID_H = LuaFnGetHighSectionOfTargetPetGuid( sceneId, selfId )
	petGUID_L = LuaFnGetLowSectionOfTargetPetGuid( sceneId, selfId )

	PetStudySkill( sceneId, selfId, petGUID_H, petGUID_L, skillId )
	return 1
end


-- 判断宠粮适合宠物食用
-- nIndex 是正在使用的宠粮的背包位置
function x335000_IsPetCanUseFood( sceneId, selfId, nIndex )
	petGUID_H = LuaFnGetHighSectionOfTargetPetGuid( sceneId, selfId )
	petGUID_L = LuaFnGetLowSectionOfTargetPetGuid( sceneId, selfId )

	ret = LuaFnPetCanUseFood( sceneId, selfId, petGUID_H, petGUID_L, nIndex )
	if ret > 0 then
		return 1
	else
		return 0
	end
end

-- 增加宠物最大生命值
function x335000_IncPetMaxHP( sceneId, selfId, value )
	if value <= 0 then
		return 0
	end

	petGUID_H = LuaFnGetHighSectionOfTargetPetGuid( sceneId, selfId )
	petGUID_L = LuaFnGetLowSectionOfTargetPetGuid( sceneId, selfId )

	value = value + LuaFnGetPetMaxHP( sceneId, selfId, petGUID_H, petGUID_L )

	LuaFnSetPetMaxHP( sceneId, selfId, petGUID_H, petGUID_L, value )
	return 1
end

-- 增加宠物生命值
function x335000_IncPetHP( sceneId, selfId, value )
	if value <= 0 then
		return 0
	end

	petGUID_H = LuaFnGetHighSectionOfTargetPetGuid( sceneId, selfId )
	petGUID_L = LuaFnGetLowSectionOfTargetPetGuid( sceneId, selfId )

	value = value + LuaFnGetPetHP( sceneId, selfId, petGUID_H, petGUID_L )
	MaxHP = LuaFnGetPetMaxHP( sceneId, selfId, petGUID_H, petGUID_L )

	if value > MaxHP then
		value = MaxHP
	end

	LuaFnSetPetHP( sceneId, selfId, petGUID_H, petGUID_L, value )
	return 1
end

-- 增加宠物寿命
function x335000_IncPetLife( sceneId, selfId, value )
	if value <= 0 then
		return 0
	end

	petGUID_H = LuaFnGetHighSectionOfTargetPetGuid( sceneId, selfId )
	petGUID_L = LuaFnGetLowSectionOfTargetPetGuid( sceneId, selfId )

	value = value + LuaFnGetPetLife( sceneId, selfId, petGUID_H, petGUID_L )

	LuaFnSetPetLife( sceneId, selfId, petGUID_H, petGUID_L, value )
	return 1
end

-- 增加宠物快乐度
function x335000_IncPetHappiness( sceneId, selfId, value )
	if value <= 0 then
		return 0
	end

	petGUID_H = LuaFnGetHighSectionOfTargetPetGuid( sceneId, selfId )
	petGUID_L = LuaFnGetLowSectionOfTargetPetGuid( sceneId, selfId )

	value = value + LuaFnGetPetHappiness( sceneId, selfId, petGUID_H, petGUID_L )
	MaxHappiness = 100

	if value > MaxHappiness then
		value = MaxHappiness
	end

	LuaFnSetPetHappiness( sceneId, selfId, petGUID_H, petGUID_L, value )
	return 1
end
