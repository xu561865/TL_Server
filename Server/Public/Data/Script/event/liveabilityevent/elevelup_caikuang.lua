--采矿技能升级

--脚本号
x713567_g_ScriptId = 713567

--此npc可以升到的最高等级
nMaxLevel = 5

--**********************************
--任务入口函数
--**********************************
function x713567_OnDefaultEvent( sceneId, selfId, targetId )
	--玩家技能的等级
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_CAIKUANG)
	--玩家加工技能的熟练度
	ExpPoint = GetAbilityExp(sceneId, selfId, ABILITY_CAIKUANG)
	--任务判断

	--如果还没有学会该生活技能
	if AbilityLevel < 1	then
		BeginEvent(sceneId)
			strText = "你还没有学会采矿技能！"
			AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--如果生活技能等级已经超出该npc所能教的范围
	if AbilityLevel >= nMaxLevel then
		BeginEvent(sceneId)
			strText = "我只能教你1-5级的采矿技能,请到帮派中学习更高级的采矿."
			AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		DispatchAbilityInfo(sceneId, selfId, targetId,x713567_g_ScriptId, ABILITY_CAIKUANG, LEVELUP_ABILITY[AbilityLevel+1].Money, LEVELUP_ABILITY[AbilityLevel+1].HumanExp, LEVELUP_ABILITY[AbilityLevel+1].AbilityExpLimitShow,LEVELUP_ABILITY[AbilityLevel+1].HumanLevelLimit)
	end
end

--**********************************
--列举事件
--**********************************
function x713567_OnEnumerate( sceneId, selfId, targetId )
		--如果不到等级则不显示选项
		if GetLevel(sceneId,selfId) >= 10 then
			AddNumText(sceneId,x713567_g_ScriptId,"升级采矿技能", -1, 1)
		end
		return
end

--**********************************
--检测接受条件
--**********************************
function x713567_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x713567_OnAccept( sceneId, selfId, ABILITY_CAIKUANG )
end
