--找人任务
--赵天师寻找钱龙
--MisDescBegin
--脚本号
x210205_g_ScriptId = 210205

--任务号
x210205_g_MissionId = 445

--上一个任务的ID
--g_MissionIdPre = 

--目标NPC
x210205_g_Name	="钱龙"

--任务归类
x210205_g_MissionKind = 13

--任务等级
x210205_g_MissionLevel = 2

--是否是精英任务
x210205_g_IfMissionElite = 0

--任务名
x210205_g_MissionName="新手：智力问答"
x210205_g_MissionInfo="要行走江湖，不单要知道一些江湖上的事情，还更要通今博古，去钱龙那里智力问答一下，看看你知道多少。。"
x210205_g_MissionTarget="找到钱龙[149,132]"
x210205_g_MissionComplete="你终于来了"
x210205_g_MoneyBonus=240
x210205_g_SignPost = {x = 149, z = 132, tip = "钱龙"}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210205_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x210205_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x210205_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x210205_g_Name then
			x210205_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x210205_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210205_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210205_g_MissionName)
				AddText(sceneId,x210205_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210205_g_MissionTarget)
				AddMoneyBonus( sceneId, x210205_g_MoneyBonus )
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210205_g_ScriptId,x210205_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x210205_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    --if 	IsMissionHaveDone(sceneId,selfId,g_MissionIdPre) <= 0 then
    --	return
    --end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210205_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210205_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210205_g_Name then
			AddNumText(sceneId, x210205_g_ScriptId,x210205_g_MissionName,2,-1);
		end
    --满足任务接收条件
    elseif x210205_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210205_g_Name then
			AddNumText(sceneId,x210205_g_ScriptId,x210205_g_MissionName,1,-1);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210205_CheckAccept( sceneId, selfId )
	--需要2级才能接
	if GetLevel( sceneId, selfId ) >= 2 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210205_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210205_g_MissionId, x210205_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#Y接受任务：智力问答",MSG2PLAYER_PARA )
	CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210205_g_SignPost.x, x210205_g_SignPost.z, x210205_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210205_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210205_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210205_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210205_g_MissionName)
		AddText(sceneId,x210205_g_MissionComplete)
		AddMoneyBonus( sceneId, x210205_g_MoneyBonus )
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210205_g_ScriptId,x210205_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210205_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210205_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210205_CheckSubmit( sceneId, selfId, selectRadioId ) then
		--添加任务奖励
		AddMoney(sceneId,selfId,x210205_g_MoneyBonus );
		LuaFnAddExp( sceneId, selfId,120)
		DelMission( sceneId,selfId,  x210205_g_MissionId )
		--设置任务已经被完成过
		MissionCom( sceneId,selfId,  x210205_g_MissionId )
		Msg2Player(  sceneId, selfId,"#Y完成任务：智力问答",MSG2PLAYER_PARA )
		CallScriptFunction( 210207, "OnDefaultEvent",sceneId, selfId, targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210205_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210205_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210205_OnItemChanged( sceneId, selfId, itemdataId )
end
