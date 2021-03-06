--圣火术技能升级

--脚本号
x713572_g_ScriptId = 713572

--此npc可以升到的最高等级
nMaxLevel = 5

--**********************************
--任务入口函数
--**********************************
function x713572_OnDefaultEvent( sceneId, selfId, targetId )
	--玩家技能的等级
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_SHENGHUOSHU)
	--玩家圣火术技能的熟练度
	ExpPoint = GetAbilityExp(sceneId, selfId, ABILITY_SHENGHUOSHU)
	--任务判断

	--判断是否是少林派弟子,不是少林弟子不能学习
		if GetMenPai(sceneId,selfId) ~= OR_MINGJIAO then
			BeginEvent(sceneId)
        		AddText(sceneId,"你不是本派弟子，我不能教你。");
        	EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	--如果还没有学会该生活技能
	if AbilityLevel < 1	then
		BeginEvent(sceneId)
			strText = "你还没有学会圣火术技能！"
			AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--如果生活技能等级已经超出该npc所能教的范围
	if AbilityLevel >= nMaxLevel then
		BeginEvent(sceneId)
			strText = "我只能教你1-5级的圣火术技能,请到帮派中学习更高级的圣火术."
			AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		DispatchAbilityInfo(sceneId, selfId, targetId,x713572_g_ScriptId, ABILITY_SHENGHUOSHU, LEVELUP_ABILITY[AbilityLevel+1].Money, LEVELUP_ABILITY[AbilityLevel+1].HumanExp, LEVELUP_ABILITY[AbilityLevel+1].AbilityExpLimitShow,LEVELUP_ABILITY[AbilityLevel+1].HumanLevelLimit)
	end
end

--**********************************
--列举事件
--**********************************
function x713572_OnEnumerate( sceneId, selfId, targetId )
		--如果不到等级则不显示选项
		if GetLevel(sceneId,selfId) >= 10 then
			AddNumText(sceneId,x713572_g_ScriptId,"升级圣火术技能", -1, 1)
		end
		return
end

--**********************************
--检测接受条件
--**********************************
function x713572_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x713572_OnAccept( sceneId, selfId, ABILITY_SHENGHUOSHU )
end
