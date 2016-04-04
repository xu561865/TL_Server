--石林  可怕的真相
--MisDescBegin
--脚本号
x211708_g_ScriptId = 211708

--任务号
x211708_g_MissionId = 608

--任务归类
x211708_g_MissionKind = 32

--任务等级
x211708_g_MissionLevel = 63

--是否是精英任务
x211708_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x211708_g_IsMissionOkFail = 0		--变量的第0位

--以上是动态**************************************************************

--任务需要得到的物品
x211708_g_DemandItem={{id=40002112,num=1}}		--变量第1位

--任务文本描述
x211708_g_MissionName="可怕的真相"
x211708_g_MissionInfo="当房间中的尘埃逐渐落定的时候，你努力整理着自己的思路。在回忆了一遍刚刚发生的事情之后，你似乎还是无法相信这一切。偃师社的首领阿支是一个奇怪的人物，好像就是传说中的修罗恶魔。你小心地将修罗的头颅砍下，然后装入包中。显然，如果没有证据的话没有人会相信你所说的。你必须马上让郑玄村长得知这个消息！"
x211708_g_MissionTarget="把阿支的头颅交给圆月村的村长郑玄"
x211708_g_ContinueInfo="你有什么事吗？"
x211708_g_MissionComplete="哦，收到"

--货物ID
x211708_g_ItemID = 40002112

--收货人
x211708_g_Name = "郑玄"

x211708_g_MoneyBonus=10200
x211708_g_Exp = 3000
x211708_g_ItemBonus={{id=30002001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211708_OnDefaultEvent( sceneId, selfId, targetId )
	--如果已接此任务
	if IsMissionHaveDone( sceneId, selfId, x211708_g_MissionId ) > 0 then
		return 
	elseif IsHaveMission(sceneId,selfId,x211708_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211708_g_Name then
			--发送交任务前的需求信息
			BeginEvent(sceneId)
				AddText(sceneId,x211708_g_MissionName);
				AddText(sceneId,x211708_g_ContinueInfo);
				AddItemDemand( sceneId, x211708_g_ItemID, 1 );
			EndEvent(sceneId)
    		done = x211708_CheckSubmit( sceneId, selfId );
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x211708_g_ScriptId,x211708_g_MissionId,done)
		end
	--满足任务接收条件
	elseif GetLevel( sceneId, selfId ) >= 60 then
		if GetName(sceneId,targetId) ~= x211708_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x211708_g_MissionName);
				AddText(sceneId,x211708_g_MissionInfo);
				AddText(sceneId,"#{M_MUBIAO}");
				AddText(sceneId,x211708_g_MissionTarget);
				AddMoneyBonus( sceneId, x211708_g_MoneyBonus )
				for i, item in x211708_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			--加入任务到玩家列表
			ret = AddMission( sceneId,selfId, x211708_g_MissionId, x211708_g_ScriptId, 0, 0, 0 )
			if ret > 0 then
				misIndex = GetMissionIndexByID(sceneId,selfId,x211708_g_MissionId)			--得到任务的序列号
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)		--根据序列号把任务变量的第0位置1 (任务完成情况)
			end
		end
	end
end

--**********************************
--列举事件
--**********************************
function x211708_OnEnumerate( sceneId, selfId, targetId )
	if IsMissionHaveDone( sceneId, selfId, x211708_g_MissionId ) > 0 then
		return 
	elseif IsHaveMission(sceneId,selfId,x211708_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211708_g_Name then
			AddNumText(sceneId, x211708_g_ScriptId,x211708_g_MissionName)
		end
	--满足任务接收条件
	elseif x211708_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211708_g_Name then
			AddNumText(sceneId, x211708_g_ScriptId, x211708_g_MissionName);
		end
	end
end

--**********************************
--检测触发条件
--**********************************
function x211708_CheckAccept( sceneId, selfId )
--	--需要60级才能接
--	if GetLevel( sceneId, selfId ) >= 60 then
--		return 1
--	else
--		return 0
--	end
end

--**********************************
--接受
--**********************************
function x211708_OnAccept( sceneId, selfId )
--	--加入任务到玩家列表
--	ret = AddMission( sceneId,selfId, x211708_g_MissionId, x211708_g_ScriptId, 0, 0, 0 )
--	if ret > 0 then
--		AddItemListToHuman(sceneId,selfId)
--		misIndex = GetMissionIndexByID(sceneId,selfId,x211708_g_MissionId)			--得到任务的序列号
--		SetMissionByIndex(sceneId,selfId,misIndex,0,1)		--根据序列号把任务变量的第0位置1 (任务完成情况)
--	end
end

--**********************************
--放弃
--**********************************
function x211708_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x211708_g_MissionId )
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x211708_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	BeginEvent(sceneId)
		AddText(sceneId,x211708_g_MissionComplete);
		AddMoneyBonus( sceneId, x211708_g_MoneyBonus )
		for i, item in x211708_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
	EndEvent(sceneId)
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x211708_g_ScriptId,x211708_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211708_CheckSubmit( sceneId, selfId )
	itemNum = GetItemCount( sceneId, selfId, x211708_g_ItemID );
	if itemNum > 0 then
		return 1;
	end
	return 0
end

--**********************************
--提交（完成）
--**********************************
function x211708_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	if x211708_CheckSubmit( sceneId, selfId, selectRadioId ) then
    		BeginAddItem(sceneId)
			for i, item in x211708_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
			
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then		
			AddExp(sceneId,selfId,x211708_g_Exp)
			AddMoney(sceneId,selfId,x211708_g_MoneyBonus );
			for i, item in x211708_g_DemandItem do
				DelItem( sceneId, selfId, item.id, item.num )
			end
			ret = DelMission( sceneId, selfId, x211708_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId, selfId, x211708_g_MissionId )
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
function x211708_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x211708_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211708_OnItemChanged( sceneId, selfId, itemdataId )
end
