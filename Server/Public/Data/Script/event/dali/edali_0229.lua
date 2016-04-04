--找人任务
--段延庆寻找赵天师
--MisDescBegin
--脚本号
x210229_g_ScriptId = 210229

--任务号
x210229_g_MissionId = 709

--上一个任务的ID
x210229_g_MissionIdPre = 708

--目标NPC
x210229_g_Name	="赵天师"

--任务归类
x210229_g_MissionKind = 13

--任务等级
x210229_g_MissionLevel = 3

--是否是精英任务
x210229_g_IfMissionElite = 0

--任务名
x210229_g_MissionName="新手：人之初"
x210229_g_MissionInfo="回去找赵天师吧，他还有话和你说。"
x210229_g_MissionTarget="找到赵天师[160,141]"
x210229_g_MissionComplete="年轻人，做的不错，这是给你的奖励。"
x210229_g_MoneyBonus=360
x210229_g_SignPost = {x = 160, z = 141, tip = "赵天师"}
x210229_g_ItemBonus={{id=40002108,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210229_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x210229_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x210229_g_MissionId) > 0)  then
			x210229_OnContinue( sceneId, selfId, targetId )
    --满足任务接收条件
    elseif x210229_CheckAccept(sceneId,selfId) > 0 then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210229_g_MissionName)
				AddText(sceneId,x210229_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210229_g_MissionTarget)
				for i, item in x210229_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
				AddMoneyBonus( sceneId, x210229_g_MoneyBonus )
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210229_g_ScriptId,x210229_g_MissionId)
    end
end

--**********************************
--列举事件
--**********************************
function x210229_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x210229_g_MissionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210229_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210229_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210229_g_Name then
			AddNumText(sceneId, x210229_g_ScriptId,x210229_g_MissionName,2,-1);
		end
    --满足任务接收条件
    elseif x210229_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210229_g_Name then
			AddNumText(sceneId,x210229_g_ScriptId,x210229_g_MissionName,1,-1);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210229_CheckAccept( sceneId, selfId )
	--需要9级才能接
	if GetLevel( sceneId, selfId ) >= 9 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210229_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210229_g_MissionId, x210229_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#Y接受任务：人之初",MSG2PLAYER_PARA )
	CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210229_g_SignPost.x, x210229_g_SignPost.z, x210229_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210229_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210229_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210229_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210229_g_MissionName)
		AddText(sceneId,x210229_g_MissionComplete)
		AddMoneyBonus( sceneId, x210229_g_MoneyBonus )
		for i, item in x210229_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210229_g_ScriptId,x210229_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210229_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210229_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210229_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in x210229_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
			if ret > 0 then
					AddMoney(sceneId,selfId,x210229_g_MoneyBonus );
					LuaFnAddExp( sceneId, selfId,300)
					ret = DelMission( sceneId, selfId, x210229_g_MissionId )
				if ret > 0 then
					MissionCom( sceneId, selfId, x210229_g_MissionId )
					AddItemListToHuman(sceneId,selfId)
					Msg2Player(  sceneId, selfId,"#Y完成任务：人之初",MSG2PLAYER_PARA )
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
function x210229_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210229_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210229_OnItemChanged( sceneId, selfId, itemdataId )
end
