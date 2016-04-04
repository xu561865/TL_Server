--找人任务
--杜子腾寻找卢三七
--MisDescBegin
--脚本号
x210203_g_ScriptId = 210203

--任务号
x210203_g_MissionId = 443

--上一个任务的ID
x210203_g_MissionIdPre = 442

--目标NPC
x210203_g_Name	="卢三七"

--任务归类
x210203_g_MissionKind = 13

--任务等级
x210203_g_MissionLevel = 1

--是否是精英任务
x210203_g_IfMissionElite = 0

--任务名
x210203_g_MissionName="新手：武林大会"
x210203_g_MissionInfo="你可以顺便去找一下药店老板卢三七，也许会有意外的收获哦！"
x210203_g_MissionTarget="找到卢三七，他是药店[103,133]老板"
x210203_g_MissionComplete="行走江湖，没有舒筋活血的药怎么可以呢！"
x210203_g_MoneyBonus=120
x210203_g_SignPost = {x = 103, z = 133, tip = "卢三七"}
x210203_g_RadioItemBonus={{id=30001001,num=5},{id=30003001,num=5},{id=30002001,num=5}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210203_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x210203_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x210203_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x210203_g_Name then
			x210203_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x210203_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210203_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210203_g_MissionName)
				AddText(sceneId,x210203_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210203_g_MissionTarget)
				for i, item in x210203_g_RadioItemBonus do
					AddRadioItemBonus( sceneId, item.id, item.num )
				end
				AddMoneyBonus( sceneId, x210203_g_MoneyBonus )
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210203_g_ScriptId,x210203_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x210203_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x210203_g_MissionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210203_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210203_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210203_g_Name then
			AddNumText(sceneId, x210203_g_ScriptId,x210203_g_MissionName,2,-1);
		end
    --满足任务接收条件
    elseif x210203_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210203_g_Name then
			AddNumText(sceneId,x210203_g_ScriptId,x210203_g_MissionName,1,-1);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210203_CheckAccept( sceneId, selfId )
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
function x210203_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210203_g_MissionId, x210203_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#Y接受任务：武林大会",MSG2PLAYER_PARA )
	CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210203_g_SignPost.x, x210203_g_SignPost.z, x210203_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210203_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210203_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210203_OnContinue( sceneId, selfId, targetId )
    BeginEvent(sceneId)
		AddText(sceneId,x210203_g_MissionName)
		AddText(sceneId,x210203_g_MissionComplete)
		AddMoneyBonus( sceneId, x210203_g_MoneyBonus )
		for i, item in x210203_g_RadioItemBonus do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210203_g_ScriptId,x210203_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210203_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210203_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210203_CheckSubmit( sceneId, selfId, selectRadioId ) then
		BeginAddItem(sceneId)
			for i, item in x210203_g_RadioItemBonus do
				if item.id == selectRadioId then
					AddItem( sceneId,item.id, item.num )
				end
			end
		ret = EndAddItem(sceneId,selfId)
		if ret > 0 then
		--添加任务奖励
			AddMoney(sceneId,selfId,x210203_g_MoneyBonus );
			LuaFnAddExp( sceneId, selfId,50)
			DelMission( sceneId,selfId,  x210203_g_MissionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x210203_g_MissionId )
			AddItemListToHuman(sceneId,selfId)
			Msg2Player(  sceneId, selfId,"#Y完成任务：武林大会",MSG2PLAYER_PARA )
			CallScriptFunction( 210204, "OnDefaultEvent",sceneId, selfId, targetId)
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
function x210203_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210203_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210203_OnItemChanged( sceneId, selfId, itemdataId )
end
