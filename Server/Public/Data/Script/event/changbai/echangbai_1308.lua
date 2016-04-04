--寻物任务
--天涯海角
--MisDescBegin
--脚本号
x211308_g_ScriptId = 211308
--任务号
x211308_g_MissionId = 568

--上一个任务的ID
--g_MissionIdPre =

--任务目标npc
x211308_g_Name = "徒单福晋"

--任务道具编号
x211308_g_ItemId = 40001039

--任务道具需求数量
x211308_g_ItemNeedNum = 1

--任务归类
x211308_g_MissionKind = 33

--任务等级
x211308_g_MissionLevel = 80

--是否是精英任务
x211308_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x211308_g_IsMissionOkFail = 0		--变量的第0位

--以上是动态**************************************************************

--任务需要得到的物品
x211308_g_DemandItem={{id=40001039,num=1}}		--变量第1位

--任务名
x211308_g_MissionName="天涯海角"
x211308_g_MissionInfo="帮我弄来一块异种树皮"
x211308_g_MissionTarget="弄来一块异种树皮"
x211308_g_ContinueInfo="你找到异种树皮了么?"
x211308_g_MissionComplete="干的不错！"

x211308_g_MoneyBonus=1032
x211308_g_ItemBonus={{id=30002001,num=1},{id=10412001,num=1}}
x211308_g_RadioItemBonus={{id=10100001,num=1},{id=10210001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211308_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x211308_g_MissionId) > 0 then
	--	return
	--end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x211308_g_MissionId) > 0 then
		--发送任务需求的信息
		BeginEvent(sceneId)
		AddText(sceneId,x211308_g_MissionName)
		AddText(sceneId,x211308_g_ContinueInfo)
		for i, item in x211308_g_DemandItem do
			AddItemDemand( sceneId, item.id, item.num )
		end
		EndEvent( )
		bDone = x211308_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x211308_g_ScriptId,x211308_g_MissionId,bDone)
	--满足任务接收条件
	elseif x211308_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,x211308_g_MissionName)
		AddText(sceneId,x211308_g_MissionInfo)
		AddText(sceneId,"#{M_MUBIAO}")
		AddText(sceneId,x211308_g_MissionTarget)
		AddMoneyBonus( sceneId, x211308_g_MoneyBonus )
		for i, item in x211308_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
			for i, item in x211308_g_RadioItemBonus do
					AddRadioItemBonus( sceneId, item.id, item.num )
				end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x211308_g_ScriptId,x211308_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x211308_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x211308_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    if IsHaveMission(sceneId,selfId,x211308_g_MissionId) > 0 then
		AddNumText(sceneId,x211308_g_ScriptId,x211308_g_MissionName);
    --满足任务接收条件
    elseif x211308_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x211308_g_ScriptId,x211308_g_MissionName);
    end
end

--**********************************
--检测接受条件
--**********************************
function x211308_CheckAccept( sceneId, selfId )
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
function x211308_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x211308_g_MissionId, x211308_g_ScriptId, 0, 0, 1 )
	misIndex = GetMissionIndexByID(sceneId,selfId,x211308_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0 (任务完成情况)
end

--**********************************
--放弃
--**********************************
function x211308_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x211308_g_MissionId )
end

--**********************************
--继续
--**********************************
function x211308_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x211308_g_MissionName)
    AddText(sceneId,x211308_g_MissionComplete)
    AddMoneyBonus( sceneId, x211308_g_MoneyBonus )
    for i, item in x211308_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    for i, item in x211308_g_RadioItemBonus do
		AddRadioItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x211308_g_ScriptId,x211308_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211308_CheckSubmit( sceneId, selfId )
	for i, item in x211308_g_DemandItem do
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
function x211308_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x211308_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x211308_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		for i, item in x211308_g_RadioItemBonus do
			if item.id == selectRadioId then
				AddItem( sceneId,item.id, item.num )
			end
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x211308_g_MoneyBonus );
			ret = DelMission( sceneId, selfId, x211308_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId, x211308_g_MissionId )
				--扣除任务物品
				for i, item in x211308_g_DemandItem do
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
function x211308_OnKillObject( sceneId, selfId, objdataId ,objId)--参数意思：场景号、玩家objId、怪物表位置号、怪物objId
end

--**********************************
--进入区域事件
--**********************************
function x211308_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211308_OnItemChanged( sceneId, selfId, itemdataId )
	if itemdataId == x211308_g_ItemId then
		x211308_g_ItemNum = GetItemCount(sceneId,selfId,x211308_g_ItemId)		--检测当前玩家任务物品1拥有的数量
		if x211308_g_ItemNum < x211308_g_ItemNeedNum then
			BeginEvent(sceneId)
				strText = format("已得到异种树皮%d/1", x211308_g_ItemNum )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			--取得任务变量的值
			misIndex = GetMissionIndexByID(sceneId,selfId,x211308_g_MissionId)
			num = GetMissionParam(sceneId,selfId,misIndex,0)
			if num == 1 then	--如果任务状态是1,说明任务完成的情况下又把物品减少到不能完成状态
				SetMissionByIndex(sceneId,selfId,misIndex,0,0)
			end
		elseif x211308_g_ItemNum == x211308_g_ItemNeedNum then
			misIndex = GetMissionIndexByID(sceneId,selfId,x211308_g_MissionId)
			num = GetMissionParam(sceneId,selfId,misIndex,0)
			--当物品数量达到要求而此时任务完成标志仍然是0,则把任务标志设置成1
			if num == 0 then
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			end
			--显示得到物品数量
			BeginEvent(sceneId)
				strText = format("已得到异种树皮%d/1", x211308_g_ItemNeedNum )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
end
