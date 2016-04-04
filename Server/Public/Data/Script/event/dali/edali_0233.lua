--八宝粥任务
--寻物
--MisDescBegin
--脚本号
x210233_g_ScriptId = 210233

--前提任务
--g_MissionIdPre =

--任务号
x210233_g_MissionId = 713

--任务目标npc
x210233_g_Name	="李工部"

--任务归类
x210233_g_MissionKind = 13

--任务等级
x210233_g_MissionLevel = 2

--是否是精英任务
x210233_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x210233_g_IsMissionOkFail = 0		--变量的第0位

--任务需要得到的物品
x210233_g_DemandItem={{id=20309001,num=1},{id=20309005,num=1}}		--从背包中计算
--以上是动态**************************************************************

--任务变量第一位用来存储随机得到的脚本号

--任务文本描述
x210233_g_MissionName="御赐精纺帽"
x210233_g_MissionInfo="大理皇宫本来要做很多的宫廷八宝粥，作为武林大会的美食的。但无量山的高山白猿首领偷走了一品糯米，剑阁的蜀道白猿首领偷走了一品红豆，如果你能够把它们找回来，我就送你一件御赐的精纺帽。"  --任务描述
x210233_g_MissionTarget="找到一品糯米和一品红豆"		--任务目标
x210233_g_ContinueInfo="一品糯米和一品红豆"		--未完成任务的npc对话
x210233_g_MissionComplete="年轻人，做的不错。"					--完成任务npc说话的话

--任务奖励
x210233_g_ItemBonus={{id=10410001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210233_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--发送任务需求的信息
	BeginEvent(sceneId)
		AddText(sceneId,x210233_g_MissionName)
		AddText(sceneId,x210233_g_MissionInfo)
		for i, item in x210233_g_DemandItem do
			AddItemDemand( sceneId, item.id, item.num )
		end
	EndEvent( )
	bDone = x210233_CheckSubmit( sceneId, selfId )
	DispatchMissionDemandInfo(sceneId,selfId,targetId,x210233_g_ScriptId,x210233_g_MissionId,bDone)
end

--**********************************
--列举事件
--**********************************
function x210233_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210233_g_MissionId) > 0 then
    	return
	--满足任务接收条件
	elseif x210233_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x210233_g_ScriptId,x210233_g_MissionName);
    end
end

--**********************************
--检测接受条件
--**********************************
function x210233_CheckAccept( sceneId, selfId )
	return 1
end

--**********************************
--接受
--**********************************
function x210233_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x210233_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210233_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210233_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x210233_g_MissionName)
    AddText(sceneId,x210233_g_MissionComplete)
    AddMoneyBonus( sceneId, g_MoneyBonus )
    for i, item in x210233_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210233_g_ScriptId,x210233_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210233_CheckSubmit( sceneId, selfId )
	for i, item in x210233_g_DemandItem do
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
function x210233_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x210233_CheckSubmit( sceneId, selfId, selectRadioId ) then
		BeginAddItem(sceneId)
			for i, item in x210233_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			--扣除任务物品
			for i, item in x210233_g_DemandItem do
				ret = DelItem( sceneId, selfId, item.id, item.num )
			end
			if	ret > 0 then
				AddMoney(sceneId,selfId,g_MoneyBonus );
				LuaFnAddExp( sceneId, selfId,250)
				ret = DelMission( sceneId, selfId, x210233_g_MissionId )
				if ret > 0 then
					MissionCom( sceneId, selfId, x210233_g_MissionId )
					AddItemListToHuman(sceneId,selfId)
					Msg2Player(  sceneId, selfId,"#Y完成任务：御赐精纺帽",MSG2PLAYER_PARA )
				end
			else
				--删除物品不成功
				BeginEvent(sceneId)
					strText = "无法完成任务"
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
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
function x210233_OnKillObject( sceneId, selfId, objdataId ,objId)--参数意思：场景号、玩家objId、怪物表位置号、怪物objId
end

--**********************************
--进入区域事件
--**********************************
function x210233_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210233_OnItemChanged( sceneId, selfId, itemdataId )
end
