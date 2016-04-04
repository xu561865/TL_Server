--剑阁 三分天下
--MisDescBegin
--脚本号
x210707_g_ScriptId = 210707

--任务号
x210707_g_MissionId = 507

x210707_g_PreMissionId1 = 503
x210707_g_PreMissionId2 = 504
x210707_g_PreMissionId3 = 505

--目标NPC
x210707_g_Name	="时迁"

--任务归类
x210707_g_MissionKind = 18

--任务等级
x210707_g_MissionLevel = 7

--是否是精英任务
x210707_g_IfMissionElite = 0

--任务名
x210707_g_MissionName="三分天下"
x210707_g_MissionInfo="把隆中对交给时迁"
x210707_g_MissionTarget="把隆中对交给时迁"
x210707_g_ContinueInfo="你终于来了"		
x210707_g_MissionComplete="你终于来了"

x210707_g_MoneyBonus=10200
x210707_g_Exp = 3000
x210707_g_ItemBonus={{id=30002001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210707_OnDefaultEvent( sceneId, selfId, targetId )
   if(IsMissionHaveDone(sceneId,selfId,x210707_g_PreMissionId1) <= 0) then
   	return
   end
   
   if(IsMissionHaveDone(sceneId,selfId,x210707_g_PreMissionId2) <= 0) then
   	return
   end
   
   if(IsMissionHaveDone(sceneId,selfId,x210707_g_PreMissionId3) <= 0) then
   	return
   end
   
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x210707_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x210707_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x210707_g_Name then
			x210707_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x210707_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210707_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210707_g_MissionName)
				AddText(sceneId,x210707_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210707_g_MissionTarget)
				
				AddMoneyBonus( sceneId, x210707_g_MoneyBonus )
				for i, item in x210707_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
			
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210707_g_ScriptId,x210707_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x210707_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210707_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210707_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210707_g_Name then
			AddNumText(sceneId, x210707_g_ScriptId,x210707_g_MissionName);
		end
    --满足任务接收条件
    elseif x210707_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210707_g_Name then
			AddNumText(sceneId,x210707_g_ScriptId,x210707_g_MissionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210707_CheckAccept( sceneId, selfId )
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
function x210707_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210707_g_MissionId, x210707_g_ScriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x210707_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210707_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210707_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210707_g_MissionName)
		AddText(sceneId,x210707_g_ContinueInfo)
		AddMoneyBonus( sceneId, x210707_g_MoneyBonus )
		
		for i, item in x210707_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end	
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210707_g_ScriptId,x210707_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210707_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210707_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210707_CheckSubmit( sceneId, selfId, selectRadioId ) then
    		BeginAddItem(sceneId)
			for i, item in x210707_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
			
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then		
		
			AddExp(sceneId,selfId,x210707_g_Exp)
			AddMoney(sceneId,selfId,x210707_g_MoneyBonus );
			
			ret = DelMission( sceneId, selfId, x210707_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId, selfId, x210707_g_MissionId )
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
function x210707_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210707_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210707_OnItemChanged( sceneId, selfId, itemdataId )
end
