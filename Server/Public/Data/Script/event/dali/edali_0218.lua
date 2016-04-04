--特殊任务 给新手一只兔子
--角色等级小于10级就给一只兔子，一个角色一次
--MisDescBegin
--脚本号
x210218_g_ScriptId = 210218

--任务号
x210218_g_MissionId = 458

--任务目标npc
x210218_g_Name	="云飘飘" 

--任务归类
x210218_g_MissionKind = 13

--任务等级
x210218_g_MissionLevel = 1

--是否是精英任务
x210218_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x210218_g_IsMissionOkFail = 0		--变量的第0位

--以上是动态**************************************************************

x210218_g_PetDataID = 3010

--任务文本描述
x210218_g_MissionName="我想要只兔子"
x210218_g_MissionInfo="好吧，看你是新来的，就给你一只兔子吧，你要好好的爱护它。"  --任务描述
x210218_g_MissionTarget="叫我一声飘飘姐"		--任务目标
x210218_g_ContinueInfo="这是我养的兔子中最可爱的一只，你要好好照顾它。"		--未完成任务的npc对话
x210218_g_MissionComplete="在大理好好玩。"					--完成任务npc说话的话

--任务奖励
x210218_g_MoneyBonus=100
x210218_g_ItemBonus={{id=30002002,num=1}}
x210218_g_RadioItemBonus={{id=10100001,num=1},{id=10210001,num=1}}
x210218_g_DemandTrueKill = {{name="草原狼",num=5}}	

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210218_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    if IsMissionHaveDone(sceneId,selfId,x210218_g_MissionId) > 0 then
		return
	end
	
	ret = LuaFnCreatePet(sceneId, selfId, x210218_g_PetDataID ) --给玩家生成一只宠物
	if ret == 1 then 
		--下个窗口，提示玩家一些话
		BeginEvent(sceneId)
		AddText(sceneId,x210218_g_ContinueInfo)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		--完成任务
		MissionCom( sceneId,selfId, x210218_g_MissionId )
	else
		BeginEvent(sceneId)
			AddText(sceneId,"你已经不能携带更多宠物了。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--列举事件
--**********************************
function x210218_OnEnumerate( sceneId, selfId, targetId )

    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210218_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    --else
    if IsHaveMission(sceneId,selfId,x210218_g_MissionId) > 0 then
		AddNumText(sceneId,x210218_g_ScriptId,x210218_g_MissionName);
    --满足任务接收条件
    elseif x210218_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x210218_g_ScriptId,x210218_g_MissionName);
    end
end

--**********************************
--检测接受条件
--**********************************
function x210218_CheckAccept( sceneId, selfId )
	--需要2级才能接
	if GetLevel( sceneId, selfId ) >= 1 and GetLevel( sceneId, selfId ) <= 10 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210218_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210218_g_MissionId, x210218_g_ScriptId, 1, 0, 0 )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x210218_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x210218_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210218_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210218_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210218_g_MissionName)
		AddText(sceneId,x210218_g_MissionComplete)
		AddMoneyBonus( sceneId, x210218_g_MoneyBonus )
		for i, item in x210218_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
		for i, item in x210218_g_RadioItemBonus do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210218_g_ScriptId,x210218_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210218_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x210218_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,1)
    if num == x210218_g_DemandTrueKill[1].num then
       return 1
    end
	return 0
end

--**********************************
--提交
--**********************************
function x210218_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x210218_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in x210218_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
			
			for i, item in x210218_g_RadioItemBonus do
				if item.id == selectRadioId then
					AddItem( sceneId,item.id, item.num )
				end
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x210218_g_MoneyBonus );
			--扣除任务物品
			--for i, item in g_DemandItem do
			--	DelItem( sceneId, selfId, item.id, item.num )
			--end
			ret = DelMission( sceneId, selfId, x210218_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId, x210218_g_MissionId )
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
function x210218_OnKillObject( sceneId, selfId, objdataId )
	if GetName(sceneId,objId) == x210218_g_DemandTrueKill[1].name	  then
		misIndex = GetMissionIndexByID(sceneId,selfId,x210218_g_MissionId)
		num = GetMissionParam(sceneId,selfId,misIndex,1)
			if num < x210218_g_DemandTrueKill[1].num then
			--把任务完成标志设置为1
			if num == x210218_g_DemandTrueKill[1].num - 1 then
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			end
			--设置打怪数量+1
			SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
	  		BeginEvent(sceneId)
	  			strText = format("已杀死草原狼 %d/5", GetMissionParam(sceneId,selfId,misIndex,1) )
	  			AddText(sceneId,strText);
	  		EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x210218_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210218_OnItemChanged( sceneId, selfId, itemdataId )
end
