--太湖 亢龙有悔
--MisDescBegin
--脚本号
x210403_g_ScriptId = 210403

--任务号
x210403_g_MissionId = 473

--上一个任务的ID
x210403_g_MissionIdPre = 472


--任务目标npc
x210403_g_Name	="曹纯"

--任务归类
x210403_g_MissionKind = 15

--任务等级
x210403_g_MissionLevel = 10

--是否是精英任务
x210403_g_IfMissionElite = 0


--任务是否已经完成
x210403_g_IsMissionOkFail = 0		--变量的第0位

--任务文本描述
x210403_g_MissionName="亢龙有悔"
x210403_g_MissionInfo="找到曹纯"
x210403_g_MissionTarget="找到曹纯"
x210403_g_ContinueInfo="找到曹纯"
x210403_g_MissionComplete="你终于来了"

--任务奖励
x210403_g_MoneyBonus=10200
x210403_g_Exp = 3000

x210403_g_ItemBonus={{id=30002001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210403_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x210403_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x210403_g_MissionId) > 0)  then
		x210403_OnContinue( sceneId, selfId, targetId )
    --满足任务接收条件
    elseif x210403_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210403_g_MissionName)
			AddText(sceneId,x210403_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x210403_g_MissionTarget)
			for i, item in x210403_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
			AddMoneyBonus( sceneId, x210403_g_MoneyBonus )
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x210403_g_ScriptId,x210403_g_MissionId)
    end
end

--**********************************
--列举事件
--**********************************
function x210403_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x210403_g_MissionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210403_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210403_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210403_g_Name then
			AddNumText(sceneId, x210403_g_ScriptId,x210403_g_MissionName,2,-1);
		end
	--满足任务接收条件
    elseif x210403_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210403_g_Name then
			AddNumText(sceneId,x210403_g_ScriptId,x210403_g_MissionName,1,-1);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210403_CheckAccept( sceneId, selfId )
	--需要3级才能接
	if GetLevel( sceneId, selfId ) >= 3 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210403_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210403_g_MissionId, x210403_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#Y接受任务：亢龙有悔",MSG2PLAYER_PARA )
end

--**********************************
--放弃
--**********************************
function x210403_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210403_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210403_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210403_g_MissionName)
		AddText(sceneId,x210403_g_MissionComplete)
		AddMoneyBonus( sceneId, x210403_g_MoneyBonus )
		for i, item in x210403_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210403_g_ScriptId,x210403_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210403_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210403_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210403_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in x210403_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
			if ret > 0 then
					AddMoney(sceneId,selfId,x210403_g_MoneyBonus );
					LuaFnAddExp( sceneId, selfId,250)
					ret = DelMission( sceneId, selfId, x210403_g_MissionId )
				if ret > 0 then
					MissionCom( sceneId, selfId, x210403_g_MissionId )
					AddItemListToHuman(sceneId,selfId)
					Msg2Player(  sceneId, selfId,"#Y完成任务：亢龙有悔",MSG2PLAYER_PARA )
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
function x210403_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210403_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210403_OnItemChanged( sceneId, selfId, itemdataId )
end
