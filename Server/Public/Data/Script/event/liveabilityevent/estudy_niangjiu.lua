--酿酒技能学习

--脚本号
x713514_g_ScriptId = 713514

--此npc可以升到的最高等级
nMaxLevel = 5

--学习界面要说的话
x713514_g_MessageStudy = "如果你达到10级并且肯花费1两银子就可以学会酿酒技能。你决定学习么？"


--**********************************
--任务入口函数
--**********************************
function x713514_OnDefaultEvent( sceneId, selfId, targetId, ButtomNum,g_Npc_ScriptId )
	--玩家技能的等级
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_NIANGJIU)
	--玩家加工技能的熟练度
	ExpPoint = GetAbilityExp(sceneId, selfId, ABILITY_NIANGJIU)
	--任务判断

	--判断是否是丐帮派弟子,不是丐帮弟子不能学习
		if GetMenPai(sceneId,selfId) ~= OR_GAIBANG then
			BeginEvent(sceneId)
        		AddText(sceneId,"你不是本派弟子，我不能教你。");
        	EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	--判断是否已经学会了酿酒,如果学会了,则提示已经学会了
	if AbilityLevel >= 1 then
		BeginEvent(sceneId)
        	AddText(sceneId,"你已经学会酿酒技能了");
        	EndEvent(sceneId)
        DispatchMissionTips(sceneId,selfId)
		return
	end

	--如果点击的是“学习技能”（即参数=0）
	if ButtomNum == 0 then
		
		BeginEvent(sceneId)
		AddText(sceneId,x713514_g_MessageStudy)
		--确定学习按钮
				AddNumText(sceneId,x713514_g_ScriptId,"我确定要学习", -1, 2)
		--取消学习按钮
				AddNumText(sceneId,x713514_g_ScriptId,"我只是来看看", -1, 3)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif ButtomNum == 2 then			--如果点击的是“我确定要学习”
	--检查玩家是否有一个银币的现金
	if GetMoney(sceneId,selfId) <= 100 then			
		BeginEvent(sceneId)
			AddText(sceneId,"你的金钱不足");
			EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--检查玩家等级是否达到要求
	if GetLevel(sceneId,selfId) < LEVELUP_ABILITY[1].HumanLevelLimit then
		BeginEvent(sceneId)
			AddText(sceneId,"你的等级不够");
			EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--删除金钱
	CostMoney(sceneId,selfId,100)
	--技能提升到1
	SetHumanAbilityLevel(sceneId,selfId,ABILITY_NIANGJIU,1)
	--在npc聊天窗口通知玩家已经学会了
	BeginEvent(sceneId)
		AddText(sceneId,"你学会了酿酒技能")
	EndEvent( )
	DispatchEventList(sceneId,selfId,targetId)
	else --如果点击“我只是来看看”
		CallScriptFunction( g_Npc_ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
end

--**********************************
--列举事件
--**********************************
function x713514_OnEnumerate( sceneId, selfId, targetId )
		--如果不到等级则不显示选项
		if GetLevel(sceneId,selfId) >= 10 then
			AddNumText(sceneId,x713514_g_ScriptId,"学习酿酒技能", -1, 0)
		end
		return
end

--**********************************
--检测接受条件
--**********************************
function x713514_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x713514_OnAccept( sceneId, selfId, ABILITY_CAIKUANG )
end
