--杀怪任务
--为国为民
--新手村杀闪电豹和山蛛任务
--MisDescBegin
--脚本号
x210217_g_ScriptId = 210217

--上一个任务的ID
--g_MissionIdPre = 

--任务号
x210217_g_MissionId = 457

--目标NPC
x210217_g_Name	="赵天师"

--任务归类
x210217_g_MissionKind = 13

--任务等级
x210217_g_MissionLevel = 6

--是否是精英任务
x210217_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x210217_g_IsMissionOkFail = 0		--变量的第0位

--任务需要杀死的怪
x210217_g_DemandKill ={{id=1520,num=8},{id=1535,num=8}}		--变量第1位

--以上是动态**************************************************************

--任务文本描述
x210217_g_MissionName="新手：保护漕路"
x210217_g_MissionInfo="最近常常有人来对我说漕运的路上不怎么太平，特别是在无量山，总有闪电豹和山蛛袭击漕运的人，你去看看，杀8只闪电豹和山蛛来向我交差。"
x210217_g_MissionTarget="去无量山杀死8个闪电豹[6,186,133]和8个山蛛[6,166,181]"
x210217_g_ContinueInfo="事情做完了吗？"
x210217_g_MissionComplete="做的好，年轻人，这是给你的奖励。"
x210217_g_SignPost = {x = 160, z = 141, tip = "赵天师"}
--任务奖励
x210217_g_MoneyBonus=100
x210217_g_ItemBonus={{id=40002108,num=1},{id=10113000,num=1}}

--MisDescEnd

x210217_g_DemandTrueKill ={{name="闪电豹",num=8},{name="山蛛",num=8}}	

--**********************************
--任务入口函数
--**********************************
function x210217_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x210217_g_MissionId) > 0 then
	--	return
	--end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x210217_g_MissionId) > 0 then
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210217_g_MissionName)
			AddText(sceneId,x210217_g_ContinueInfo)
			--for i, item in g_DemandItem do
			--	AddItemDemand( sceneId, item.id, item.num )
			--end
			AddMoneyBonus( sceneId, x210217_g_MoneyBonus )
		EndEvent( )
		bDone = x210217_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210217_g_ScriptId,x210217_g_MissionId,bDone)		
    --满足任务接收条件
    elseif x210217_CheckAccept(sceneId,selfId) > 0 then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210217_g_MissionName)
				AddText(sceneId,x210217_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210217_g_MissionTarget)
				for i, item in x210217_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
				AddMoneyBonus( sceneId, x210217_g_MoneyBonus )
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210217_g_ScriptId,x210217_g_MissionId)
    end
end

--**********************************
--列举事件
--**********************************
function x210217_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210217_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    if IsHaveMission(sceneId,selfId,x210217_g_MissionId) > 0 then
			AddNumText(sceneId,x210217_g_ScriptId,x210217_g_MissionName,2,-1);
		--满足任务接收条件
	elseif x210217_CheckAccept(sceneId,selfId) > 0 then
			AddNumText(sceneId,x210217_g_ScriptId,x210217_g_MissionName,1,-1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210217_CheckAccept( sceneId, selfId )
	--需要6级才能接
	if GetLevel( sceneId, selfId ) >= 6 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210217_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210217_g_MissionId, x210217_g_ScriptId, 1, 0, 0 )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x210217_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
	SetMissionByIndex(sceneId,selfId,misIndex,2,0)						--根据序列号把任务变量的第2位置0
	Msg2Player(  sceneId, selfId,"#Y接受任务：保护漕路",MSG2PLAYER_PARA )
	CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210217_g_SignPost.x, x210217_g_SignPost.z, x210217_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210217_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210217_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210217_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210217_g_MissionName)
		AddText(sceneId,x210217_g_MissionComplete)
		AddMoneyBonus( sceneId, x210217_g_MoneyBonus )
		for i, item in x210217_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210217_g_ScriptId,x210217_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210217_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x210217_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,0)
    if num == 1 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210217_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x210217_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in x210217_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
	if ret > 0 then
			AddMoney(sceneId,selfId,x210217_g_MoneyBonus );
			LuaFnAddExp( sceneId, selfId,1000)
			--扣除任务物品
			--for i, item in g_DemandItem do
			--	DelItem( sceneId, selfId, item.id, item.num )
			--end
		ret = DelMission( sceneId, selfId, x210217_g_MissionId )
		if ret > 0 then
			MissionCom( sceneId, selfId, x210217_g_MissionId )
				AddItemListToHuman(sceneId,selfId)
				Msg2Player(  sceneId, selfId,"#Y完成任务：保护漕路",MSG2PLAYER_PARA )
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
function x210217_OnKillObject( sceneId, selfId, objdataId ,objId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x210217_g_MissionId)
	num_1 = GetMissionParam(sceneId,selfId,misIndex,1)
	num_2 = GetMissionParam(sceneId,selfId,misIndex,2)
	if GetName(sceneId,objId) == x210217_g_DemandTrueKill[1].name	  then
		if num_1 < x210217_g_DemandTrueKill[1].num then
			--设置打怪数量+1
			SetMissionByIndex(sceneId,selfId,misIndex,1,num_1+1)
	  		BeginEvent(sceneId)
				strText = format("已杀死闪电豹%d/8", GetMissionParam(sceneId,selfId,misIndex,1) )
				AddText(sceneId,strText);
	  		EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			num_1 = GetMissionParam(sceneId,selfId,misIndex,1)
			num_2 = GetMissionParam(sceneId,selfId,misIndex,2)
			if	num_1 == x210217_g_DemandTrueKill[1].num	and	num_2 == x210217_g_DemandTrueKill[2].num	then
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			end
		end
	elseif	GetName(sceneId,objId) == x210217_g_DemandTrueKill[2].name	  then
		if num_2 < x210217_g_DemandTrueKill[2].num then
			--设置打怪数量+1
			SetMissionByIndex(sceneId,selfId,misIndex,2,num_2+1)
	  		BeginEvent(sceneId)
				strText = format("已杀死山蛛%d/8", GetMissionParam(sceneId,selfId,misIndex,2) )
				AddText(sceneId,strText);
	  		EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			num_1 = GetMissionParam(sceneId,selfId,misIndex,1)
			num_2 = GetMissionParam(sceneId,selfId,misIndex,2)
			if	num_1 == x210217_g_DemandTrueKill[1].num	and	num_2 == x210217_g_DemandTrueKill[2].num	then
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x210217_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210217_OnItemChanged( sceneId, selfId, itemdataId )
end
