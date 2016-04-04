--石林  把杨铁信的剑交给圆月村的郑萼
--MisDescBegin
--脚本号
x211705_g_ScriptId = 211705

--任务号
x211705_g_MissionId = 605

--目标NPC
x211705_g_Name	="郑萼"

--任务归类
x211705_g_MissionKind = 29

--任务等级
x211705_g_MissionLevel = 25

--任务需要得到的物品
x211705_g_DemandItem={{id=40002111,num=1}}		--变量第1位

--是否是精英任务
x211705_g_IfMissionElite = 0

--任务名
x211705_g_MissionName="信仰"
x211705_g_MissionInfo="把杨铁信的剑交给圆月村的郑萼"
x211705_g_MissionTarget="把杨铁信的剑交给圆月村的郑萼"
x211705_g_ContinueInfo="你终于把沾满鲜血的剑带来了"		
x211705_g_MissionComplete="你终于把沾满鲜血的剑带来了"

x211705_g_MoneyBonus=10200
x211705_g_Exp = 3000
x211705_g_ItemBonus={{id=30002001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211705_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x211705_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x211705_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x211705_g_Name then
			x211705_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x211705_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211705_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x211705_g_MissionName)
				AddText(sceneId,x211705_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x211705_g_MissionTarget)
				
				AddMoneyBonus( sceneId, x211705_g_MoneyBonus )
				for i, item in x211705_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
			
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x211705_g_ScriptId,x211705_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x211705_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x211705_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x211705_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211705_g_Name then
			AddNumText(sceneId, x211705_g_ScriptId,x211705_g_MissionName);
		end
    --满足任务接收条件
    elseif x211705_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211705_g_Name then
			AddNumText(sceneId,x211705_g_ScriptId,x211705_g_MissionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x211705_CheckAccept( sceneId, selfId )
	--需要60级才能接
	if GetLevel( sceneId, selfId ) >= 60 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x211705_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x211705_g_MissionId, x211705_g_ScriptId, 0, 0, 0 )
	BeginAddItem(sceneId)
		--添加信件类物品
		for i, item in x211705_g_DemandItem do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
	if ret > 0 then
		AddItemListToHuman(sceneId,selfId)
		Msg2Player(  sceneId, selfId,"#Y接受任务：信仰",MSG2PLAYER_PARA )
	else
		--任务奖励没有加成功
		BeginEvent(sceneId)
			strText = "背包已满,无法接受任务"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

--**********************************
--放弃
--**********************************
function x211705_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x211705_g_MissionId )
	if res > 0 then
		--移去任务物品
		for i, item in x211705_g_DemandItem do
			DelItem( sceneId, selfId, item.id, item.num )
		end
	end
end

--**********************************
--继续
--**********************************
function x211705_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x211705_g_MissionName)
		AddText(sceneId,x211705_g_ContinueInfo)
		AddMoneyBonus( sceneId, x211705_g_MoneyBonus )
		
		for i, item in x211705_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end	
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x211705_g_ScriptId,x211705_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211705_CheckSubmit( sceneId, selfId )
	for i, item in x211705_g_DemandItem do
		itemCount = GetItemCount( sceneId, selfId, item.id )
		if itemCount < item.num then
			return 0
		end
	end
	return 1
end

--**********************************
--提交
--**********************************
function x211705_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x211705_CheckSubmit( sceneId, selfId, selectRadioId ) then
		--添加任务奖励
		AddMoney(sceneId,selfId,x211705_g_MoneyBonus );
		LuaFnAddExp( sceneId, selfId,30)
				--扣除任务物品
		for i, item in x211705_g_DemandItem do
			DelItem( sceneId, selfId, item.id, item.num )
		end
		DelMission( sceneId,selfId,  x211705_g_MissionId )
		--设置任务已经被完成过
		MissionCom( sceneId,selfId,  x211705_g_MissionId )
		Msg2Player(  sceneId, selfId,"#Y完成任务：信仰",MSG2PLAYER_PARA )    		
		BeginAddItem(sceneId)
			for i, item in x211705_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then		
			AddExp(sceneId,selfId,x211705_g_Exp)
			AddMoney(sceneId,selfId,x211705_g_MoneyBonus );
			ret = DelMission( sceneId, selfId, x211705_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId, selfId, x211705_g_MissionId )
					AddItemListToHuman(sceneId,selfId)
			end
		else
		--任务奖励没有加成功
			BeginEvent(sceneId)
				strText = "背包已满,无法完成任务"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x211705_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x211705_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211705_OnItemChanged( sceneId, selfId, itemdataId )
end
