--白马寺任务
--寻物
--MisDescBegin
--脚本号
x230004_g_ScriptId = 230004

--前提任务
--g_MissionIdPre =

--任务号
x230004_g_MissionId = 4011

--任务目标npc
x230004_g_Name	="智清大师"

--任务归类
x230004_g_MissionKind = 1

--任务等级
x230004_g_MissionLevel = 10

--是否是精英任务
x230004_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x230004_g_IsMissionOkFail = 0		--变量的第0位

--任务环数
x230004_g_MissionRound	= 10			--记录循环任务变量的第10个数

--任务需要得到的物品
x230004_g_DemandItem={{id=20104001,num=1}}		--从背包中计算
--以上是动态**************************************************************

--任务变量第一位用来存储随机得到的脚本号

--任务文本描述
x230004_g_MissionName="白马寺修行"
x230004_g_MissionInfo="  阿弥陀佛...#r  请少侠帮贫僧找来一株小麦。"  --任务描述
x230004_g_MissionTarget="帮智清大师找来一株小麦。#r"		--任务目标
x230004_g_ContinueInfo="  阿弥陀佛...#r  少侠可否把小麦带来了？"		--未完成任务的npc对话
x230004_g_MissionComplete="善哉善哉，少侠为人豪爽，关爱百姓，不爱钱财，日后必有一番作为。"					--完成任务npc说话的话

--任务奖励


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x230004_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x230004_g_MissionId) > 0 then
	--	return
	--end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x230004_g_MissionId) > 0 then
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x230004_g_MissionName)
			AddText(sceneId,x230004_g_ContinueInfo)
			for i, item in x230004_g_DemandItem do
				AddItemDemand( sceneId, item.id, item.num )
			end
		EndEvent( )
		bDone = x230004_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x230004_g_ScriptId,x230004_g_MissionId,bDone)
	--满足任务接收条件
	elseif x230004_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x230004_g_MissionName)
			AddText(sceneId,x230004_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x230004_g_MissionTarget)
			--AddMoneyBonus( sceneId, g_MoneyBonus )
			--for i, item in g_ItemBonus do
			--	AddItemBonus( sceneId, item.id, item.num )
			--end
			--for i, item in g_RadioItemBonus do
			--	AddRadioItemBonus( sceneId, item.id, item.num )
			--end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x230004_g_ScriptId,x230004_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x230004_OnEnumerate( sceneId, selfId, targetId )
    --如果已接此任务
    if IsHaveMission(sceneId,selfId,x230004_g_MissionId) > 0 then
		AddNumText(sceneId,x230004_g_ScriptId,x230004_g_MissionName);
    --满足任务接收条件
    elseif x230004_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x230004_g_ScriptId,x230004_g_MissionName);
    end
end

--**********************************
--检测接受条件
--**********************************
function x230004_CheckAccept( sceneId, selfId )
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
function x230004_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x230004_g_MissionId, x230004_g_ScriptId, 0, 0, 1 )
	misIndex = GetMissionIndexByID(sceneId,selfId,x230004_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0 (任务完成情况)
	SetMissionByIndex(sceneId,selfId,misIndex,1,x230004_g_ScriptId)						--根据序列号把任务变量的第1位置为任务脚本号
	--得到环数
	x230004_g_MissionRound = GetMissionData(sceneId,selfId,10)
	--环数增加1
	x230004_g_MissionRound = x230004_g_MissionRound + 1
	if	x230004_g_MissionRound >= 11 then
		SetMissionData(sceneId, selfId, 10, 1)
	else
		SetMissionData(sceneId, selfId, 10, x230004_g_MissionRound)
	end
	--检测玩家身上的道具是否已经满足完成条件，如果已经满足，则把完成任务的变量置为0
	if x230004_CheckSubmit( sceneId, selfId ) == 1 then
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)					--把任务完成标志置为1
	end
	--显示内容告诉玩家已经接受了任务
	BeginEvent(sceneId)
		AddText(sceneId,x230004_g_MissionInfo)
		AddText(sceneId,"#r        你接受了任务：白马寺修行")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--放弃
--**********************************
function x230004_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x230004_g_MissionId )
	SetMissionData(sceneId,selfId,10,0)	--环数清0
end

--**********************************
--继续
--**********************************
function x230004_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x230004_g_MissionName)
    AddText(sceneId,x230004_g_MissionComplete)
    --AddMoneyBonus( sceneId, g_MoneyBonus )
    --for i, item in g_ItemBonus do
	--	AddItemBonus( sceneId, item.id, item.num )
	--end
    --for i, item in g_RadioItemBonus do
	--	AddRadioItemBonus( sceneId, item.id, item.num )
	--end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x230004_g_ScriptId,x230004_g_MissionId)
	
end

--**********************************
--检测是否可以提交
--**********************************
function x230004_CheckSubmit( sceneId, selfId )
	for i, item in x230004_g_DemandItem do
		itemCount = HaveItemInBag (  sceneId, selfId, item.id )
		if itemCount < item.num then
			return 0
		end
	end
	return 1
end

--**********************************
--提交
--**********************************
function x230004_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x230004_CheckSubmit( sceneId, selfId, selectRadioId ) then
		--扣除任务物品
		for i, item in x230004_g_DemandItem do
			ret = DelItem( sceneId, selfId, item.id, item.num )
		end
		if	ret > 0 then
			DelMission( sceneId, selfId, x230004_g_MissionId )
			MissionCom( sceneId,selfId, x230004_g_MissionId )
			--得到环数
			x230004_g_MissionRound = GetMissionData(sceneId,selfId,10)
			--计算奖励经验的数量
			if mod(x230004_g_MissionRound,10) == 0 then
				x230004_g_Exp = Level * 10 * 10										--等级+环数函数，受经验调节常数的影响
			else
				x230004_g_Exp = Level * mod(x230004_g_MissionRound,10) * 10
			end
			if	floor((x230004_g_MissionRound - 1) / 10) >=1  then
				x230004_g_Exp = x230004_g_Exp +50												--11~20环任务，每环额外增加50点经验
			end
			--增加经验值
			AddExp( sceneId,selfId,x230004_g_Exp)
			AddMoney( sceneId, selfId, x230004_g_Exp)	
			--显示对话框
			BeginEvent(sceneId)
				AddText(sceneId,"恭喜你完成了任务，给你"..x230004_g_Exp.."点经验和"..x230004_g_Exp.."钱")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			BeginEvent(sceneId)
				AddText(sceneId,"你的任务不能完成，你的小麦怎么突然不见了？")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x230004_OnKillObject( sceneId, selfId, objdataId ,objId)--参数意思：场景号、玩家objId、怪物表位置号、怪物objId
end

--**********************************
--进入区域事件
--**********************************
function x230004_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x230004_OnItemChanged( sceneId, selfId, itemdataId )
	if itemdataId == x230004_g_DemandItem[1].id then
		x230004_g_ItemNum = GetItemCount(sceneId,selfId,x230004_g_DemandItem[1].id)		--检测当前玩家任务物品1拥有的数量
		if x230004_g_ItemNum < x230004_g_DemandItem[1].num then
			BeginEvent(sceneId)
				strText = format("已得到小麦%d/1", x230004_g_ItemNum )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			--取得任务变量的值
			misIndex = GetMissionIndexByID(sceneId,selfId,x230004_g_MissionId)
			num = GetMissionParam(sceneId,selfId,misIndex,0)
			if num == 1 then	--如果任务状态是1,说明任务完成的情况下又把物品减少到不能完成状态
				SetMissionByIndex(sceneId,selfId,misIndex,0,0)
			end
		elseif x230004_g_ItemNum == x230004_g_DemandItem[1].num then
			misIndex = GetMissionIndexByID(sceneId,selfId,x230004_g_MissionId)
			num = GetMissionParam(sceneId,selfId,misIndex,0)
			--当物品数量达到要求而此时任务完成标志仍然是0,则把任务标志设置成1
			if num == 0 then
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			end
			--显示得到物品数量
			BeginEvent(sceneId)
				strText = format("已得到小麦%d/1", x230004_g_ItemNum )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
end
