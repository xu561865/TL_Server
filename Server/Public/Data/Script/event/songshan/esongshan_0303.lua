--找人任务
--来龙去脉
--MisDescBegin
--脚本号
x210303_g_ScriptId = 210303

--任务号
x210303_g_MissionId = 463

--上一个任务的ID
x210303_g_MissionIdPre_1 = 460
x210303_g_MissionIdPre_2 = 461
x210303_g_MissionIdPre_3 = 462

--目标NPC
x210303_g_Name	="陆松"

--任务归类
x210303_g_MissionKind = 14

--任务等级
x210303_g_MissionLevel = 25

--是否是精英任务
x210303_g_IfMissionElite = 0

--任务名
x210303_g_MissionName="来龙去脉"
x210303_g_MissionInfo=[[
    柴大官人最近总是做噩梦，这也难怪，近来嵩阳书院发生了好多怪事。
    当年柴老太爷吐血而死的时候，柴大官人年纪还小，很是害怕。那时候就落下了病根，就是见不得血。
    去找陆松陆郎中开点安神的药吧。]]
x210303_g_MissionTarget="找到陆松"
x210303_g_ContinueInfo="你找到陆松了吗，快点去找吧。"		--未完成任务的npc对话
x210303_g_MissionComplete="你终于来了"
x210303_g_MoneyBonus=12000

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210303_OnDefaultEvent( sceneId, selfId, targetId )

	--如果玩家完成过这个任务
  if( IsMissionHaveDone(sceneId,selfId,x210303_g_MissionId) > 0 ) then
  	return
	elseif( IsHaveMission(sceneId,selfId,x210303_g_MissionId) > 0)  then
		if GetName(sceneId, targetId) == x210303_g_Name then
			x210303_OnComplete( sceneId, selfId, targetId );
		else
			x210303_OnContinue( sceneId, selfId, targetId );
		end
	elseif x210303_CheckAccept(sceneId,selfId) > 0 then --满足任务接收条件
		if GetName(sceneId,targetId) ~= x210303_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId);
				AddText(sceneId, x210303_g_MissionName);
				AddText(sceneId, x210303_g_MissionInfo);
				AddText(sceneId, "#{M_MUBIAO}");
				AddText(sceneId, x210303_g_MissionTarget);
			EndEvent( );
			DispatchMissionInfo(sceneId,selfId,targetId,x210303_g_ScriptId,x210303_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x210303_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x210303_g_MissionIdPre_1) <= 0 or 	IsMissionHaveDone(sceneId,selfId,x210303_g_MissionIdPre_2) <= 0 or IsMissionHaveDone(sceneId,selfId,x210303_g_MissionIdPre_3) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210303_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210303_g_MissionId) > 0 then
			AddNumText(sceneId, x210303_g_ScriptId, x210303_g_MissionName);
    --满足任务接收条件
    elseif x210303_CheckAccept(sceneId,selfId) > 0 then
			if GetName(sceneId,targetId) ~= x210303_g_Name then
				AddNumText(sceneId, x210303_g_ScriptId, x210303_g_MissionName);
			end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210303_CheckAccept( sceneId, selfId )
	--需要2级才能接
	if GetLevel( sceneId, selfId ) >= 15 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210303_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId, selfId, x210303_g_MissionId, x210303_g_ScriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x210303_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210303_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210303_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	print("===============x210303_OnContinue============");
  BeginEvent(sceneId)
		AddText(sceneId, x210303_g_MissionName)
		AddText(sceneId, x210303_g_ContinueInfo)
  EndEvent( )
	DispatchMissionDemandInfo(sceneId, selfId, targetId, x210303_g_ScriptId, x210303_g_MissionId, 0);
end

--**********************************
--完成
--**********************************
function x210303_OnComplete( sceneId, selfId, targetId )
	--提交任务时的说明信息
  BeginEvent(sceneId)
		AddText(sceneId, x210303_g_MissionName)
		AddText(sceneId, x210303_g_MissionComplete)
  EndEvent( )
  DispatchMissionContinueInfo(sceneId, selfId, targetId, x210303_g_ScriptId, x210303_g_MissionId);
end

--**********************************
--检测是否可以提交
--**********************************
function x210303_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210303_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210303_CheckSubmit( sceneId, selfId, selectRadioId ) then
		--添加任务奖励
		AddMoney(sceneId,selfId,x210303_g_MoneyBonus );
		DelMission( sceneId,selfId,  x210303_g_MissionId )
		--设置任务已经被完成过
		MissionCom( sceneId,selfId,  x210303_g_MissionId )
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210303_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210303_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210303_OnItemChanged( sceneId, selfId, itemdataId )
end
