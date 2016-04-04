--寻物任务
--钱龙要你给他找到一个馒头
--MisDescBegin
--脚本号
x210206_g_ScriptId = 210206

--任务号
x210206_g_MissionId = 446

--上一个任务的ID
x210206_g_MissionIdPre = 445

--目标NPC
x210206_g_Name	="钱龙"

--任务道具编号
x210206_g_ItemId = 30101001

--任务道具需求数量
x210206_g_ItemNeedNum = 2

--任务归类
x210206_g_MissionKind = 13

--任务等级
x210206_g_MissionLevel = 2

--是否是精英任务
x210206_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x210206_g_IsMissionOkFail = 0		--变量的第0位

--以上是动态**************************************************************

--任务需要得到的物品
x210206_g_DemandItem={{id=30101001,num=1}}		--变量第1位

--任务名
x210206_g_MissionName="新手：智力问答"
x210206_g_MissionInfo="给我做一个馒头，让我看看你的记忆力。"
x210206_g_MissionTarget="把馒头送给钱龙"
x210206_g_MissionComplete="你终于来了"
x210206_g_MoneyBonus=240
x210206_g_SignPost = {x = 149, z = 132, tip = "钱龙"}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210206_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x210206_g_MissionId) > 0 then
	--	return
	--end
    --如果已接此任务
		if IsHaveMission(sceneId,selfId,x210206_g_MissionId) > 0 then
			--发送任务需求的信息
			BeginEvent(sceneId)
			AddText(sceneId,x210206_g_MissionName)
			AddText(sceneId,x210206_g_MissionComplete)
			for i, item in x210206_g_DemandItem do
				AddItemDemand( sceneId, item.id, item.num )
			end
			AddMoneyBonus( sceneId, x210206_g_MoneyBonus )
			EndEvent( )
			bDone = x210206_CheckSubmit( sceneId, selfId )
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x210206_g_ScriptId,x210206_g_MissionId,bDone)
		--满足任务接收条件
		elseif x210206_CheckAccept(sceneId,selfId) > 0 then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210206_g_MissionName)
				AddText(sceneId,x210206_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210206_g_MissionTarget)
				AddMoneyBonus( sceneId, x210206_g_MoneyBonus )
				--for i, item in g_ItemBonus do
				--	AddItemBonus( sceneId, item.id, item.num )
				--end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210206_g_ScriptId,x210206_g_MissionId)
		end
end

--**********************************
--列举事件
--**********************************
function x210206_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x210206_g_MissionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210206_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
	if IsHaveMission(sceneId,selfId,x210206_g_MissionId) > 0 then
		AddNumText(sceneId,x210206_g_ScriptId,x210206_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x210206_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x210206_g_ScriptId,x210206_g_MissionName,1,-1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210206_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel( sceneId, selfId ) >= 2 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210206_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210206_g_MissionId, x210206_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#Y接受任务：智力问答",MSG2PLAYER_PARA )
	CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210206_g_SignPost.x, x210206_g_SignPost.z, x210206_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210206_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210206_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210206_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210206_g_MissionName)
		AddText(sceneId,x210206_g_MissionComplete)
		AddMoneyBonus( sceneId, x210206_g_MoneyBonus )
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210206_g_ScriptId,x210206_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210206_CheckSubmit( sceneId, selfId )
	for i, item in x210206_g_DemandItem do
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
function x210206_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210206_CheckSubmit( sceneId, selfId, selectRadioId ) then
		AddMoney(sceneId,selfId,x210206_g_MoneyBonus );
		LuaFnAddExp(sceneId, selfId,90)
		ret = DelMission( sceneId, selfId, x210206_g_MissionId )
		if ret > 0 then
			MissionCom( sceneId, selfId, x210206_g_MissionId )
			--扣除任务物品
			for i, item in x210206_g_DemandItem do
				DelItem( sceneId, selfId, item.id, item.num )
			end
			Msg2Player(  sceneId, selfId,"#Y完成任务：智力问答",MSG2PLAYER_PARA )
			CallScriptFunction( 210207, "OnDefaultEvent",sceneId, selfId, targetId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210206_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210206_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210206_OnItemChanged( sceneId, selfId, itemdataId )
end
