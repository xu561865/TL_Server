--找人任务
--安神药
--MisDescBegin
--脚本号
x210304_g_ScriptId = 210304

--任务号
x210304_g_MissionId = 464

--目标NPC
x210304_g_Name	="柴进"

--任务归类
x210304_g_MissionKind = 14

--任务等级
x210304_g_MissionLevel = 25

--是否是精英任务
x210304_g_IfMissionElite = 0

--任务名
x210304_g_MissionName="安神药"
x210304_g_MissionInfo=[[
    劳您把这份安神药交给柴大官人。]]
x210304_g_MissionTarget="把安神药交给柴进"
x210304_g_ContinueInfo="把安神药交给柴进了吗，快点去吧。"		--未完成任务的npc对话
x210304_g_MissionComplete="你终于来了。"
x210304_g_MoneyBonus=12000

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210304_OnDefaultEvent( sceneId, selfId, targetId )

	--如果玩家完成过这个任务
  if( IsMissionHaveDone(sceneId,selfId,x210304_g_MissionId) > 0 ) then
  	return
	elseif( IsHaveMission(sceneId,selfId,x210304_g_MissionId) > 0)  then
		if GetName(sceneId, targetId) == x210304_g_Name then
			x210304_OnComplete( sceneId, selfId, targetId );
		else
			x210304_OnContinue( sceneId, selfId, targetId );
		end
	elseif x210304_CheckAccept(sceneId,selfId) > 0 then --满足任务接收条件
		if GetName(sceneId,targetId) ~= x210304_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId);
				AddText(sceneId, x210304_g_MissionName);
				AddText(sceneId, x210304_g_MissionInfo);
				AddText(sceneId, "#{M_MUBIAO}");
				AddText(sceneId, x210304_g_MissionTarget);
			EndEvent( );
			DispatchMissionInfo(sceneId,selfId,targetId,x210304_g_ScriptId,x210304_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x210304_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210304_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210304_g_MissionId) > 0 then
			AddNumText(sceneId, x210304_g_ScriptId, x210304_g_MissionName);
    --满足任务接收条件
    elseif x210304_CheckAccept(sceneId,selfId) > 0 then
			if GetName(sceneId,targetId) ~= x210304_g_Name then
				AddNumText(sceneId, x210304_g_ScriptId, x210304_g_MissionName);
			end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210304_CheckAccept( sceneId, selfId )
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
function x210304_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId, selfId, x210304_g_MissionId, x210304_g_ScriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x210304_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210304_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210304_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	print("===============x210304_OnContinue============");
  BeginEvent(sceneId)
		AddText(sceneId, x210304_g_MissionName)
		AddText(sceneId, x210304_g_ContinueInfo)
  EndEvent( )
	DispatchMissionDemandInfo(sceneId, selfId, targetId, x210304_g_ScriptId, x210304_g_MissionId, 0);
end

--**********************************
--完成
--**********************************
function x210304_OnComplete( sceneId, selfId, targetId )
	--提交任务时的说明信息
  BeginEvent(sceneId)
		AddText(sceneId, x210304_g_MissionName)
		AddText(sceneId, x210304_g_MissionComplete)
  EndEvent( )
  DispatchMissionContinueInfo(sceneId, selfId, targetId, x210304_g_ScriptId, x210304_g_MissionId);
end

--**********************************
--检测是否可以提交
--**********************************
function x210304_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210304_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210304_CheckSubmit( sceneId, selfId, selectRadioId ) then
		--添加任务奖励
		AddMoney(sceneId,selfId,x210304_g_MoneyBonus );
		DelMission( sceneId,selfId,  x210304_g_MissionId )
		--设置任务已经被完成过
		MissionCom( sceneId,selfId,  x210304_g_MissionId )
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210304_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210304_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210304_OnItemChanged( sceneId, selfId, itemdataId )
end
