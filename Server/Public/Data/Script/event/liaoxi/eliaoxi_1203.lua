--找人任务
--辽军元帅
--MisDescBegin
--脚本号
x211203_g_ScriptId = 211203

--任务号
x211203_g_MissionId = 553

--目标NPC
x211203_g_Name	="耶律金"

--任务归类
x211203_g_MissionKind = 32

--任务等级
x211203_g_MissionLevel = 58

--是否是精英任务
x211203_g_IfMissionElite = 0


--任务名
x211203_g_MissionName="辽军元帅"
x211203_g_MissionInfo="黑蜂肆虐，我们无法抵抗，请你帮忙找到元帅耶律金，请他派兵支援我们"		--任务描述
x211203_g_MissionTarget="找到辽军元帅耶律金"		--任务目标
x211203_g_MissionComplete="好的，我马上派人去支援。"		--提交时npc的话
x211203_g_MoneyBonus=100
x211203_g_ItemBonus={{id=10105001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211203_OnDefaultEvent( sceneId, selfId, targetId )

    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x211203_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x211203_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x211203_g_Name then
			x211203_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x211203_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211203_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x211203_g_MissionName)
			AddText(sceneId,x211203_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x211203_g_MissionTarget)
			AddText(sceneId,"#{M_SHOUHUO}")
			AddMoneyBonus( sceneId, x211203_g_MoneyBonus )
			for i, item in x211203_g_ItemBonus do
						AddItemBonus( sceneId, item.id, item.num )
					end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x211203_g_ScriptId,x211203_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x211203_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x211203_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x211203_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211203_g_Name then
			AddNumText(sceneId, x211203_g_ScriptId,x211203_g_MissionName);
		end
    --满足任务接收条件
    elseif x211203_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211203_g_Name then
			AddNumText(sceneId,x211203_g_ScriptId,x211203_g_MissionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x211203_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel( sceneId, selfId ) >= 1 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x211203_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x211203_g_MissionId, x211203_g_ScriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x211203_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x211203_g_MissionId )
end

--**********************************
--继续
--**********************************
function x211203_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x211203_g_MissionName)
     AddText(sceneId,x211203_g_MissionComplete)
   AddMoneyBonus( sceneId, x211203_g_MoneyBonus )
    for i, item in x211203_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x211203_g_ScriptId,x211203_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211203_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x211203_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x211203_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x211203_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x211203_g_MoneyBonus );
			DelMission( sceneId,selfId,  x211203_g_MissionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x211203_g_MissionId )
			AddItemListToHuman(sceneId,selfId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x211203_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x211203_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211203_OnItemChanged( sceneId, selfId, itemdataId )
end







