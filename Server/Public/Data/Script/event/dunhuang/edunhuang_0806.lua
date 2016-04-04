--找人任务
--寻找曲端
--MisDescBegin
--脚本号
x210806_g_ScriptId = 210806

--任务号
x210806_g_MissionId = 516

--目标NPC
x210806_g_Name	="朱王礼"

--任务归类
x210806_g_MissionKind = 19

--任务等级
x210806_g_MissionLevel = 9

--是否是精英任务
x210806_g_IfMissionElite = 0

--任务名
x210806_g_MissionName="回归"
x210806_g_MissionInfo="你去告诉朱王礼，无论他刺杀李秉常成功与否，只要坚守玉门关三天，我就可以率领大队宋军赶到。"
x210806_g_MissionTarget="找到朱王礼"
x210806_g_ContinueInfo="你终于来了"
x210806_g_MissionComplete="你终于来了"

x210806_g_MoneyBonus=10200
x210806_g_ItemBonus={{id=20101001,num=1}}


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210806_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x210806_g_MissionId) > 0 ) then
    	return
    elseif( IsHaveMission(sceneId,selfId,x210806_g_MissionId) > 0)  then

	if GetName(sceneId,targetId) == x210806_g_Name then
		x210806_OnContinue( sceneId, selfId, targetId )
	end
	 --满足任务接收条件
    elseif x210806_CheckAccept(sceneId,selfId) > 0 then

	if GetName(sceneId,targetId) ~= x210806_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210806_g_MissionName)
			AddText(sceneId,x210806_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x210806_g_MissionTarget)
			AddMoneyBonus( sceneId, x210806_g_MoneyBonus )
			for i, item in x210806_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x210806_g_ScriptId,x210806_g_MissionId)
	end
    end
end

--**********************************
--列举事件
--**********************************
function x210806_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210806_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210806_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210806_g_Name then
			AddNumText(sceneId, x210806_g_ScriptId,x210806_g_MissionName);
		end
    --满足任务接收条件
    elseif x210806_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210806_g_Name then
			AddNumText(sceneId,x210806_g_ScriptId,x210806_g_MissionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210806_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel( sceneId, selfId ) >= 10 and IsMissionHaveDone(sceneId,selfId,515) > 0 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210806_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210806_g_MissionId, x210806_g_ScriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x210806_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210806_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210806_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210806_g_MissionName)
		AddText(sceneId,x210806_g_ContinueInfo)
		AddMoneyBonus( sceneId, x210806_g_MoneyBonus )
		for i, item in x210806_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end

    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210806_g_ScriptId,x210806_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210806_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210806_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210806_CheckSubmit( sceneId, selfId, selectRadioId ) then
		--添加任务奖励
		AddMoney(sceneId,selfId,x210806_g_MoneyBonus );
		DelMission( sceneId,selfId,  x210806_g_MissionId )
		--设置任务已经被完成过
		MissionCom( sceneId,selfId,  x210806_g_MissionId )
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210806_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210806_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210806_OnItemChanged( sceneId, selfId, itemdataId )
end
