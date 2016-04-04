--特殊找人任务找3个人
--捉迷藏
--MisDescBegin
--脚本号
x211301_g_ScriptId = 211301

--任务号
x211301_g_MissionId = 561

--目标NPC
x211301_g_Name	="完颜兀术"

--任务归类
x211301_g_MissionKind = 33

--任务等级
x211301_g_MissionLevel = 80

--是否是精英任务
x211301_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况*************
--任务是否已经完成
x211301_g_IsMissionOkFail = 0		--变量的第0位

--自定义，找到3个人
x211301_g_Custom={{id="找到完颜斡离不",num=1},{id="找到完颜粘没喝",num=1},{id="找到完颜斡本",num=1}}
--以上是动态内容************************************
--任务名
x211301_g_MissionName="捉迷藏"
x211301_g_MissionInfo="找到3个人:完颜斡离不,完颜粘没喝,完颜斡本"		--任务描述
x211301_g_MissionTarget="找到3个人:完颜斡离不,完颜粘没喝,完颜斡本"		--任务目标
x211301_g_ContinueInfo="你找到他们3个了么?"		--未完成任务的npc对话
x211301_g_MissionComplete="太感谢了，你这么快就找到他们了！"		--提交时npc的话
x211301_g_MoneyBonus=100
x211301_g_ItemBonus={{id=10105001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211301_OnDefaultEvent( sceneId, selfId, targetId )

    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x211301_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x211301_g_MissionId) > 0)  then
		
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x211301_g_MissionName)
			AddText(sceneId,x211301_g_ContinueInfo)
		EndEvent( )
		bDone = x211301_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x211301_g_ScriptId,x211301_g_MissionId,bDone)
		
	--满足任务接收条件
    elseif x211301_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,x211301_g_MissionName)
		AddText(sceneId,x211301_g_MissionInfo)
		AddText(sceneId,"#{M_MUBIAO}")
		AddText(sceneId,x211301_g_MissionTarget)
		AddText(sceneId,"#{M_SHOUHUO}")
		AddMoneyBonus( sceneId, x211301_g_MoneyBonus )
		for i, item in x211301_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x211301_g_ScriptId,x211301_g_MissionId)
    end
end

--**********************************
--列举事件
--**********************************
function x211301_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x211301_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x211301_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211301_g_Name then
			AddNumText(sceneId, x211301_g_ScriptId,x211301_g_MissionName);
		end
    --满足任务接收条件
    elseif x211301_CheckAccept(sceneId,selfId) > 0 then
			AddNumText(sceneId,x211301_g_ScriptId,x211301_g_MissionName);
    end
end

--**********************************
--检测接受条件
--**********************************
function x211301_CheckAccept( sceneId, selfId )
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
function x211301_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x211301_g_MissionId, x211301_g_ScriptId, 0, 0, 0 )
	misIndex = GetMissionIndexByID(sceneId,selfId,x211301_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0(完成状态）
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0（完颜斡离不）
	SetMissionByIndex(sceneId,selfId,misIndex,2,0)						--根据序列号把任务变量的第2位置0（完颜粘没喝）
	SetMissionByIndex(sceneId,selfId,misIndex,3,0)						--根据序列号把任务变量的第3位置0（完颜斡本）
end

--**********************************
--放弃
--**********************************
function x211301_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x211301_g_MissionId )
end

--**********************************
--继续
--**********************************
function x211301_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x211301_g_MissionName)
		AddText(sceneId,x211301_g_MissionComplete)
		AddMoneyBonus( sceneId, x211301_g_MoneyBonus )
		for i, item in x211301_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x211301_g_ScriptId,x211301_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211301_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x211301_g_MissionId)			--得到任务的序列号
	num2 = GetMissionParam(sceneId,selfId,misIndex,1)
	num3 = GetMissionParam(sceneId,selfId,misIndex,2)
	num4 = GetMissionParam(sceneId,selfId,misIndex,3)
	if num2 == 1 and num3 == 1 and num4 ==1 then
		return 1
	else
		return 0
	end
end

--**********************************
--提交
--**********************************
function x211301_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x211301_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x211301_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x211301_g_MoneyBonus );
			ret = DelMission( sceneId,selfId,  x211301_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId,  x211301_g_MissionId )
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
function x211301_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x211301_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211301_OnItemChanged( sceneId, selfId, itemdataId )
end







