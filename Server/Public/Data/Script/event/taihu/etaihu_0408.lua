--太湖 安定团结
--MisDescBegin
--脚本号
x210408_g_ScriptId = 210408

--任务号
x210408_g_MissionId = 478

--目标NPC
x210408_g_Name	="林世长"

--任务归类
x210408_g_MissionKind = 15

--任务等级
x210408_g_MissionLevel = 10

--是否是精英任务
x210408_g_IfMissionElite = 0

--任务名
x210408_g_MissionName="安定团结"
x210408_g_MissionInfo="把呼延庆的信送给林世长"
x210408_g_MissionTarget="把呼延庆的信送给林世长"
x210408_g_ContinueInfo="你终于来了"		
x210408_g_MissionComplete="你终于来了"

x210408_g_MoneyBonus=10200
x210408_g_Exp = 3000
x210408_g_ItemBonus={{id=30002001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210408_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x210408_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x210408_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x210408_g_Name then
			x210408_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x210408_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210408_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210408_g_MissionName)
				AddText(sceneId,x210408_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210408_g_MissionTarget)
				
				AddMoneyBonus( sceneId, x210408_g_MoneyBonus )
				for i, item in x210408_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
			
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210408_g_ScriptId,x210408_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x210408_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210408_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210408_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210408_g_Name then
			AddNumText(sceneId, x210408_g_ScriptId,x210408_g_MissionName);
		end
    --满足任务接收条件
    elseif x210408_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210408_g_Name then
			AddNumText(sceneId,x210408_g_ScriptId,x210408_g_MissionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210408_CheckAccept( sceneId, selfId )
	--需要10级才能接
	if GetLevel( sceneId, selfId ) >= 10 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210408_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210408_g_MissionId, x210408_g_ScriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x210408_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210408_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210408_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210408_g_MissionName)
		AddText(sceneId,x210408_g_ContinueInfo)
		AddMoneyBonus( sceneId, x210408_g_MoneyBonus )
		
		for i, item in x210408_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end	
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210408_g_ScriptId,x210408_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210408_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210408_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210408_CheckSubmit( sceneId, selfId, selectRadioId ) then
    		BeginAddItem(sceneId)
			for i, item in x210408_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
			
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then		
		
			AddExp(sceneId,selfId,x210408_g_Exp)
			AddMoney(sceneId,selfId,x210408_g_MoneyBonus );
			
			ret = DelMission( sceneId, selfId, x210408_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId, selfId, x210408_g_MissionId )
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
function x210408_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210408_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210408_OnItemChanged( sceneId, selfId, itemdataId )
end
