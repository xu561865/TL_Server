--找人任务
--赵天师寻找段延庆
--MisDescBegin
--脚本号
x210225_g_ScriptId = 210225

--任务号
x210225_g_MissionId = 705

--上一个任务的ID
x210225_g_MissionIdPre = 704

--目标NPC
x210225_g_Name	="段延庆"

--任务归类
x210225_g_MissionKind = 13

--任务等级
x210225_g_MissionLevel = 9

--是否是精英任务
x210225_g_IfMissionElite = 0

--任务名
x210225_g_MissionName="新手：人之初"
x210225_g_MissionInfo="这件事情肯定是四大恶人之首的段延庆所为，你去把他找出来！"
x210225_g_MissionTarget="找到段延庆[215,284]"
x210225_g_MissionComplete="不知死活的东西，竟敢挡在老子的前面。## 你是为了大理城贴出的告示来的？你认为我是凶手？其实那件事情啊……"
x210225_g_MoneyBonus=360
x210225_g_SignPost = {x = 215, z = 284, tip = "段延庆"}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210225_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x210225_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x210225_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x210225_g_Name then
			x210225_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x210225_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210225_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210225_g_MissionName)
				AddText(sceneId,x210225_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210225_g_MissionTarget)
				AddMoneyBonus( sceneId, x210225_g_MoneyBonus )
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210225_g_ScriptId,x210225_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x210225_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x210225_g_MissionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210225_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210225_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210225_g_Name then
			AddNumText(sceneId, x210225_g_ScriptId,x210225_g_MissionName,2,-1);
		end
    --满足任务接收条件
    elseif x210225_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210225_g_Name then
			AddNumText(sceneId,x210225_g_ScriptId,x210225_g_MissionName,1,-1);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210225_CheckAccept( sceneId, selfId )
	--需要8级才能接
	if GetLevel( sceneId, selfId ) >= 8 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210225_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210225_g_MissionId, x210225_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#Y接受任务：人之初",MSG2PLAYER_PARA )
	CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210225_g_SignPost.x, x210225_g_SignPost.z, x210225_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210225_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210225_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210225_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210225_g_MissionName)
		AddText(sceneId,x210225_g_MissionComplete)
		AddMoneyBonus( sceneId, x210225_g_MoneyBonus )
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210225_g_ScriptId,x210225_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210225_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210225_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210225_CheckSubmit( sceneId, selfId, selectRadioId ) then
		--添加任务奖励
		AddMoney(sceneId,selfId,x210225_g_MoneyBonus );
		LuaFnAddExp( sceneId, selfId,200)
		DelMission( sceneId,selfId,  x210225_g_MissionId )
		--设置任务已经被完成过
		MissionCom( sceneId,selfId,  x210225_g_MissionId )
		Msg2Player(  sceneId, selfId,"#Y完成任务：人之初",MSG2PLAYER_PARA )
		CallScriptFunction( 210226, "OnDefaultEvent",sceneId, selfId, targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210225_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210225_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210225_OnItemChanged( sceneId, selfId, itemdataId )
end
