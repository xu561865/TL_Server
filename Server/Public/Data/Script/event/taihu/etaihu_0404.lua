--太湖  费保的头颅
--MisDescBegin
--脚本号
x210404_g_ScriptId = 210404

--任务号
x210404_g_MissionId = 474

--上一个任务的ID
x210404_g_MissionIdPre = 473

--货物ID
x210404_g_ItemID = 40002071

--任务道具需求数量
x210404_g_ItemNeedNum = 1

--任务归类
x210404_g_MissionKind = 15

--任务等级
x210404_g_MissionLevel = 10

--是否是精英任务
x210404_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x210404_g_IsMissionOkFail = 0		--变量的第0位

--以上是动态**************************************************************

--任务需要得到的物品
x210404_g_DemandItem={{id=40002071,num=1}}		--变量第1位

--任务文本描述
x210404_g_MissionName="费保的头颅"
x210404_g_MissionInfo="杀死水鬼头领费保，把他的头颅交给李纲"
x210404_g_MissionTarget="杀死水鬼头领费保，把他的头颅交给李纲"
x210404_g_ContinueInfo="你有什么事吗？"
x210404_g_MissionComplete="哦，收到"



--收货人
x210404_g_Name = "李纲"

x210404_g_MoneyBonus=10200
x210404_g_Exp = 3000
x210404_g_ItemBonus={{id=30002001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210404_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本



	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x210404_g_MissionId) > 0 then
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210404_g_MissionName)
			AddText(sceneId,x210404_g_ContinueInfo)
		for i, item in x210404_g_DemandItem do
			AddItemDemand( sceneId, item.id, item.num )
		end
		EndEvent( )
		bDone = x210404_CheckSubmit( sceneId, selfId )
	DispatchMissionDemandInfo(sceneId,selfId,targetId,x210404_g_ScriptId,x210404_g_MissionId,bDone)
		--满足任务接收条件
	elseif x210404_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210404_g_MissionName)
			AddText(sceneId,x210404_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x210404_g_MissionTarget)
			AddMoneyBonus( sceneId, x210404_g_MoneyBonus )
			for i, item in x210404_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
			
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x210404_g_ScriptId,x210404_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210404_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x210404_g_MissionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210404_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210404_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210404_g_Name then
			AddNumText(sceneId, x210404_g_ScriptId,x210404_g_MissionName,2,-1);
		end
	--满足任务接收条件
    elseif x210404_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210404_g_Name then
			AddNumText(sceneId,x210404_g_ScriptId,x210404_g_MissionName,1,-1);
		end
    end
end
--**********************************
--检测接受条件
--**********************************
function x210404_CheckAccept( sceneId, selfId )
	--需要10级才能接
	if GetLevel( sceneId, selfId ) >= 10 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210404_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210404_g_MissionId, x210404_g_ScriptId, 1, 0, 1 )
	misIndex = GetMissionIndexByID(sceneId,selfId,x210404_g_MissionId)		--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)	--根据序列号把任务变量的第0位置0 (任务完成情况)
end

--**********************************
--放弃
--**********************************
function x210404_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210404_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210404_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	BeginEvent(sceneId)
		AddText(sceneId,x210404_g_MissionName)
		AddText(sceneId,x210404_g_MissionComplete)
		AddMoneyBonus( sceneId, x210404_g_MoneyBonus )
		for i, item in x210404_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x210404_g_ScriptId,x210404_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210404_CheckSubmit( sceneId, selfId )
	for i, item in x210404_g_DemandItem do
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
function x210404_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x210404_CheckSubmit( sceneId, selfId, selectRadioId ) then
    		BeginAddItem(sceneId)
			for i, item in x210404_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
			
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then		
		
			AddExp(sceneId,selfId,x210404_g_Exp)
			AddMoney(sceneId,selfId,x210404_g_MoneyBonus );			
			
			
			ret = DelMission( sceneId, selfId, x210404_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId, selfId, x210404_g_MissionId )
				
				--扣除任务物品
				for i, item in x210404_g_DemandItem do
					DelItem( sceneId, selfId, item.id, item.num )
				end
				
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
function x210404_OnKillObject( sceneId, selfId, objdataId ,objId)
	if objdataId == 544 then  --费保
		num = GetMonsterOwnerCount(sceneId,objId)--取得这个怪物死后拥有分配权的人数
		for i=0,num-1 do
			humanObjId = GetMonsterOwnerID(sceneId,objId,i)--取得拥有分配权的人的objId
			if IsHaveMission(sceneId,humanObjId,x210404_g_MissionId) > 0 then	--如果这个人拥有任务	
				if (GetItemCount(sceneId,humanObjId,g_ItemId) < x210404_g_ItemNeedNum) then
					AddMonsterDropItem(sceneId,objId,humanObjId,g_ItemId)    --给这个人任务道具(道具会出现在尸体包里)
				end
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x210404_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210404_OnItemChanged( sceneId, selfId, itemdataId )
	if itemdataId == g_ItemId then
		x210404_g_ItemNum = GetItemCount(sceneId,selfId,g_ItemId)
		if x210404_g_ItemNum < x210404_g_ItemNeedNum then
			BeginEvent(sceneId)
				strText = format("已得到费保的头颅%d/1", x210404_g_ItemNum )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			--取得任务变量的值
			misIndex = GetMissionIndexByID(sceneId,selfId,x210404_g_MissionId)
			num = GetMissionParam(sceneId,selfId,misIndex,0)
			if num == 1 then	--如果任务状态是1,说明任务完成的情况下又把物品减少到不能完成状态
				SetMissionByIndex(sceneId,selfId,misIndex,0,0)
			end
		elseif x210404_g_ItemNum == x210404_g_ItemNeedNum then
			misIndex = GetMissionIndexByID(sceneId,selfId,x210404_g_MissionId)
			num = GetMissionParam(sceneId,selfId,misIndex,0)
			--当物品数量达到要求而此时任务完成标志仍然是0,则把任务标志设置成1
			if num == 0 then
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			end
			--显示得到物品数量
			BeginEvent(sceneId)
				strText = format("已得到费保的头颅%d/1", x210404_g_ItemNeedNum )
				AddText(sceneId,strText)
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
end
