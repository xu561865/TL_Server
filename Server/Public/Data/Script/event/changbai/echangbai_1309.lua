--杀怪掉落任务
--突袭
--MisDescBegin
--脚本号
x211309_g_ScriptId = 211309

--上一个任务的ID
--g_MissionIdPre =

--任务号
x211309_g_MissionId = 569

--任务目标npc
x211309_g_Name	="完颜阿骨打" 

--任务道具编号
x211309_g_ItemId = 40002099

--任务道具需求数量
x211309_g_ItemNeedNum = 1

--任务归类
x211309_g_MissionKind = 33

--任务等级
x211309_g_MissionLevel = 80

--是否是精英任务
x211309_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x211309_g_IsMissionOkFail = 0		--变量的第0位

--任务需要杀死的怪
x211309_g_DemandKill = {{id=1955,num=5}}		--变量第1位

--任务需要得到的物品
x211309_g_DemandItem={{id=40002099,num=1}}
--以上是动态**************************************************************

--任务文本描述
x211309_g_MissionName="突袭"
x211309_g_MissionInfo="我们的贡品刚刚送给辽国，现在他们肯定疏于防范，这个机会可不能错过，去杀死5个雪山莽盖和纥石烈部落首领阿疏，把女真首领的旗帜带回来"  --任务描述
x211309_g_MissionTarget="杀死5个雪山莽盖，杀死纥石烈阿疏，得到女真首领的旗帜"		--任务目标
x211309_g_ContinueInfo="你把女真首领的旗帜带来了么？还要杀死5个雪山莽盖"		--未完成任务的npc对话
x211309_g_MissionComplete="哈哈，我们大获全胜，要好好庆祝一下"					--完成任务npc说话的话

x211309_g_MoneyBonus=1032
x211309_g_ItemBonus={{id=30002001,num=1},{id=10412001,num=1}}
x211309_g_RadioItemBonus={{id=10100001,num=1},{id=10210001,num=1}}
x211309_g_DemandTrueKill ={{name="雪山莽盖",num=5}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211309_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x211309_g_MissionId) > 0 then
	--	return
	--end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x211309_g_MissionId) > 0 then
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x211309_g_MissionName)
			AddText(sceneId,x211309_g_ContinueInfo)
			for i, item in x211309_g_DemandItem do
				AddItemDemand( sceneId, item.id, item.num )
			end
		EndEvent( )
		bDone = x211309_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x211309_g_ScriptId,x211309_g_MissionId,bDone)
	--满足任务接收条件
	elseif x211309_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x211309_g_MissionName)
			AddText(sceneId,x211309_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x211309_g_MissionTarget)
			AddMoneyBonus( sceneId, x211309_g_MoneyBonus )
			for i, item in x211309_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
			for i, item in x211309_g_RadioItemBonus do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x211309_g_ScriptId,x211309_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x211309_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x211309_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    if IsHaveMission(sceneId,selfId,x211309_g_MissionId) > 0 then
		AddNumText(sceneId,x211309_g_ScriptId,x211309_g_MissionName);
	--满足任务接收条件
    elseif x211309_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x211309_g_ScriptId,x211309_g_MissionName);
    end
end

--**********************************
--检测接受条件
--**********************************
function x211309_CheckAccept( sceneId, selfId )
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
function x211309_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x211309_g_MissionId, x211309_g_ScriptId, 1, 0, 1 )
	misIndex = GetMissionIndexByID(sceneId,selfId,x211309_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0 (任务完成情况)
SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x211309_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    ret = DelMission( sceneId, selfId, x211309_g_MissionId )
	if ret > 0 then
		--计算玩家有几个任务道具
		ItemCount = GetItemCount(sceneId,selfId,x211309_g_ItemId)
		--删除任务道具
		if ItemCount > 0 then
			DelItem(sceneId,selfId,x211309_g_ItemId,ItemCount)
		end
	else
		BeginEvent(sceneId)
			strText = "无法删除任务"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

--**********************************
--继续
--**********************************
function x211309_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x211309_g_MissionName)
		AddText(sceneId,x211309_g_MissionComplete)
		AddMoneyBonus( sceneId, x211309_g_MoneyBonus )
		for i, item in x211309_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
		for i, item in x211309_g_RadioItemBonus do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x211309_g_ScriptId,x211309_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211309_CheckSubmit( sceneId, selfId )
	for i, item in x211309_g_DemandItem do
		itemCount = GetItemCount( sceneId, selfId, item.id )
		if itemCount < item.num then
			return 0
		end
	end
	misIndex = GetMissionIndexByID(sceneId,selfId,x211309_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,1)
    if num < x211309_g_DemandTrueKill[1].num then
       return 0
    end
	return 1
end

--**********************************
--提交
--**********************************
function x211309_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x211309_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in x211309_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
			for i, item in x211309_g_RadioItemBonus do
				if item.id == selectRadioId then
					AddItem( sceneId,item.id, item.num )
				end
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x211309_g_MoneyBonus );
			ret = DelMission( sceneId, selfId, x211309_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId, x211309_g_MissionId )
				--扣除任务物品
				for i, item in x211309_g_DemandItem do
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
function x211309_OnKillObject( sceneId, selfId, objdataId ,objId)--参数意思：场景号、玩家objId、怪物表位置号、怪物objId
	if objdataId == 537 then
		num = GetMonsterOwnerCount(sceneId,objId)--取得这个怪物死后拥有分配权的人数
		for i=0,num-1 do
			humanObjId = GetMonsterOwnerID(sceneId,objId,i)--取得拥有分配权的人的objId
			if IsHaveMission(sceneId,humanObjId,x211309_g_MissionId) > 0 then	--如果这个人拥有任务	
				if (GetItemCount(sceneId,humanObjId,x211309_g_ItemId) < x211309_g_ItemNeedNum) then
					AddMonsterDropItem(sceneId,objId,humanObjId,x211309_g_ItemId)    --给这个人任务道具(道具会出现在尸体包里)
				end
			end
		end
	end
	if GetName(sceneId,objId) == x211309_g_DemandTrueKill[1].name	  then
		misIndex = GetMissionIndexByID(sceneId,selfId,x211309_g_MissionId)
		num = GetMissionParam(sceneId,selfId,misIndex,1)
		if num < x211309_g_DemandTrueKill[1].num then
			--如果此时杀死了5只怪并且已经得到了任务物品,则把完成标志置1
			if num == 4 and GetItemCount( sceneId, selfId, x211309_g_ItemId ) >= x211309_g_ItemNeedNum then
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			end				
			SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
			BeginEvent(sceneId)
				strText = format("已杀死雪山莽盖 %d/5", GetMissionParam(sceneId,selfId,misIndex,1) )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x211309_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211309_OnItemChanged( sceneId, selfId, itemdataId )
	if itemdataId == x211309_g_ItemId then
		x211309_g_ItemNum = GetItemCount(sceneId,selfId,x211309_g_ItemId)
		if x211309_g_ItemNum < x211309_g_ItemNeedNum then
			BeginEvent(sceneId)
				strText = format("已得到女真首领的旗帜%d/1", x211309_g_ItemNum )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			--取得任务变量的值
			misIndex = GetMissionIndexByID(sceneId,selfId,x211309_g_MissionId)
			num = GetMissionParam(sceneId,selfId,misIndex,0)
			if num == 1 then	--如果任务状态是1,说明任务完成的情况下又把物品减少到不能完成状态
				SetMissionByIndex(sceneId,selfId,misIndex,0,0)
			end
		elseif x211309_g_ItemNum == x211309_g_ItemNeedNum then
			misIndex = GetMissionIndexByID(sceneId,selfId,x211309_g_MissionId)
			num = GetMissionParam(sceneId,selfId,misIndex,0)
			--当物品数量达到要求而此时任务完成标志仍然是0,则把任务标志设置成1
			if num == 0 then
				if x211309_CheckSubmit( sceneId, selfId ) == 1 then
					SetMissionByIndex(sceneId,selfId,misIndex,0,1)
				end
			end
			--显示得到物品数量
			BeginEvent(sceneId)
				strText = format("已得到女真首领的旗帜%d/1", x211309_g_ItemNeedNum )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
end
