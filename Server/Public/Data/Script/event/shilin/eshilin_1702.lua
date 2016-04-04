--石林 绝望之地   --临时的文件，还没有完成
--MisDescBegin
--脚本号
x211702_g_ScriptId = 211702

--任务号
x211702_g_MissionId = 602

--目标NPC
x211702_g_Name	="郑玄"

--任务归类
x211702_g_MissionKind = 29

--任务等级
x211702_g_MissionLevel = 25

--是否是精英任务
x211702_g_IfMissionElite = 0

--任务名
x211702_g_MissionName="绝望之地"
x211702_g_MissionInfo="听郑玄讲他的故事"
x211702_g_MissionTarget="听郑玄讲他的故事"
x211702_g_ContinueInfo="听郑玄讲他的故事"		
x211702_g_MissionComplete="听郑玄讲他的故事"

x211702_g_MoneyBonus=10200
x211702_g_Exp = 3000
x211702_g_ItemBonus={{id=30002001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211702_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x211702_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x211702_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x211702_g_Name then
			BeginEvent(sceneId)
				AddText(sceneId,x211702_g_MissionName)
				AddText(sceneId,x211702_g_ContinueInfo)
				AddMoneyBonus( sceneId, x211702_g_MoneyBonus )
			EndEvent()
			bDone = x211702_CheckSubmit( sceneId, selfId )
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x211702_g_ScriptId,x211702_g_MissionId,bDone)	
		end
    --满足任务接收条件
    elseif x211702_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x211702_g_MissionName)
			AddText(sceneId,x211702_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x211702_g_MissionTarget)
			
			AddMoneyBonus( sceneId, x211702_g_MoneyBonus )
			for i, item in x211702_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
		
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x211702_g_ScriptId,x211702_g_MissionId)
		
    end
end

--**********************************
--列举事件
--**********************************
function x211702_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x211702_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x211702_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211702_g_Name then
			AddNumText(sceneId, x211702_g_ScriptId,x211702_g_MissionName);
		end
    --满足任务接收条件
    elseif x211702_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x211702_g_Name then
			AddNumText(sceneId,x211702_g_ScriptId,x211702_g_MissionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x211702_CheckAccept( sceneId, selfId )
	--需要60级才能接
	if GetLevel( sceneId, selfId ) >= 60 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x211702_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x211702_g_MissionId, x211702_g_ScriptId, 0, 0, 0 )
	misIndex = GetMissionIndexByID(sceneId,selfId,x211702_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x211702_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x211702_g_MissionId )
end

--**********************************
--继续
--**********************************
function x211702_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x211702_g_MissionName)
		AddText(sceneId,x211702_g_ContinueInfo)
		AddMoneyBonus( sceneId, x211702_g_MoneyBonus )
		
		for i, item in x211702_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end	
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x211702_g_ScriptId,x211702_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211702_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x211702_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,0)
    if num == 1 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x211702_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x211702_CheckSubmit( sceneId, selfId, selectRadioId ) then
    		BeginAddItem(sceneId)
			for i, item in x211702_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
			
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then		
		
			AddExp(sceneId,selfId,x211702_g_Exp)
			AddMoney(sceneId,selfId,x211702_g_MoneyBonus );
			
			ret = DelMission( sceneId, selfId, x211702_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId, selfId, x211702_g_MissionId )
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
function x211702_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x211702_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211702_OnItemChanged( sceneId, selfId, itemdataId )
end
