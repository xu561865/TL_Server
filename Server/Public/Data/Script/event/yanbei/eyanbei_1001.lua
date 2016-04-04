--杀怪任务
--秦家寨亲兵
--MisDescBegin
--脚本号
x211001_g_ScriptId = 211001

--上一个任务的ID
--g_MissionIdPre = 

--任务号
x211001_g_MissionId = 531

--目标NPC
x211001_g_Name	="耶律余睹"

--任务归类
x211001_g_MissionKind = 30

--任务等级
x211001_g_MissionLevel = 26

--是否是精英任务
x211001_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x211001_g_IsMissionOkFail = 0		--变量的第0位

--任务需要杀死的怪
x211001_g_DemandKill ={{id=1695,num=1}}		--变量第1位

--以上是动态**************************************************************

--任务文本描述
x211001_g_MissionName="杀死亲兵"
x211001_g_MissionInfo="杀一个秦家寨亲兵，让他们认为是宋朝军队下的手。"
x211001_g_MissionTarget="杀死秦家寨亲兵"
x211001_g_ContinueInfo="你已经杀了秦家寨亲兵了吗？"
x211001_g_MissionComplete="恭喜你杀完了"

--任务奖励
x211001_g_MoneyBonus=100
x211001_g_ItemBonus={{id=30002001,num=1}}
x211001_g_RadioItemBonus={{id=10100001,num=1},{id=10210001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211001_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x211001_g_MissionId) > 0 then
	--	return
	--end
	--如果已接此任务
		if IsHaveMission(sceneId,selfId,x211001_g_MissionId) > 0 then
			--发送任务需求的信息
			BeginEvent(sceneId)
				AddText(sceneId,x211001_g_MissionName)
				AddText(sceneId,x211001_g_ContinueInfo)
			--for i, item in g_DemandItem do
			--	AddItemDemand( sceneId, item.id, item.num )
			--end
			EndEvent( )
			bDone = x211001_CheckSubmit( sceneId, selfId )
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x211001_g_ScriptId,x211001_g_MissionId,bDone)
			--满足任务接收条件
		elseif x211001_CheckAccept(sceneId,selfId) > 0 then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x211001_g_MissionName)
				AddText(sceneId,x211001_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x211001_g_MissionTarget)
				AddMoneyBonus( sceneId, x211001_g_MoneyBonus )
			for i, item in x211001_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
			for i, item in x211001_g_RadioItemBonus do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x211001_g_ScriptId,x211001_g_MissionId)
		end
	end

--**********************************
--列举事件
--**********************************
function x211001_OnEnumerate( sceneId, selfId, targetId )

	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x211001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
    --else
		if IsHaveMission(sceneId,selfId,x211001_g_MissionId) > 0 then
			AddNumText(sceneId,x211001_g_ScriptId,x211001_g_MissionName);
		--满足任务接收条件
		elseif x211001_CheckAccept(sceneId,selfId) > 0 then
			AddNumText(sceneId,x211001_g_ScriptId,x211001_g_MissionName);
		end
	end

--**********************************
--检测接受条件
--**********************************
function x211001_CheckAccept( sceneId, selfId )
	--需要2级才能接
	if GetLevel( sceneId, selfId ) >= 1 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x211001_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x211001_g_MissionId, x211001_g_ScriptId, 1, 0, 0 )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x211001_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x211001_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x211001_g_MissionId )
end

--**********************************
--继续
--**********************************
function x211001_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	BeginEvent(sceneId)
		AddText(sceneId,x211001_g_MissionName)
		AddText(sceneId,x211001_g_MissionComplete)
		AddMoneyBonus( sceneId, x211001_g_MoneyBonus )
		for i, item in x211001_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
		for i, item in x211001_g_RadioItemBonus do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x211001_g_ScriptId,x211001_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211001_CheckSubmit( sceneId, selfId )
		misIndex = GetMissionIndexByID(sceneId,selfId,x211001_g_MissionId)
		num = GetMissionParam(sceneId,selfId,misIndex,1)
    if num == x211001_g_DemandKill[1].num then
			return 1
		end
	return 0
end

--**********************************
--提交
--**********************************
function x211001_OnSubmit( sceneId, selfId,targetId,selectRadioId )
	if x211001_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in x211001_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
			for i, item in x211001_g_RadioItemBonus do
				if item.id == selectRadioId then
					AddItem( sceneId,item.id, item.num )
				end
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
	if ret > 0 then
			AddMoney(sceneId,selfId,x211001_g_MoneyBonus );
			--扣除任务物品
			--for i, item in g_DemandItem do
			--	DelItem( sceneId, selfId, item.id, item.num )
			--end
		ret = DelMission( sceneId, selfId, x211001_g_MissionId )
		if ret > 0 then
			MissionCom( sceneId, selfId, x211001_g_MissionId )
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
function x211001_OnKillObject( sceneId, selfId, objdataId )

	if objdataId == x211001_g_DemandKill[1].id then
		misIndex = GetMissionIndexByID(sceneId,selfId,x211001_g_MissionId)
		num = GetMissionParam(sceneId,selfId,misIndex,1)
		if num < x211001_g_DemandKill[1].num then
		--把任务完成标志设置为1
		if num == x211001_g_DemandKill[1].num - 1 then
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		end
		--设置打怪数量+1
	    SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
			BeginEvent(sceneId)
				strText = format("已杀死秦家寨亲兵%d/1", GetMissionParam(sceneId,selfId,misIndex,1) )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
 
end

--**********************************
--进入区域事件
--**********************************
function x211001_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211001_OnItemChanged( sceneId, selfId, itemdataId )
end
