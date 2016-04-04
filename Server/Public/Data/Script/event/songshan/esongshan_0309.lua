--杀怪掉落任务
--哑巴黄莲
--MisDescBegin
--脚本号
x210309_g_ScriptId = 210309

--上一个任务的ID
--g_MissionIdPre =

--任务号
x210309_g_MissionId = 469

--任务目标npc
x210309_g_Name	="陆松" 

--任务道具编号
x210309_g_ItemId = 1

--任务道具需求数量
--g_ItemNeedNum = 1

--任务归类
x210309_g_MissionKind = 14

--任务等级
x210309_g_MissionLevel = 51

--是否是精英任务
x210309_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x210309_g_IsMissionOkFail = 0		--变量的第0位

--以上是动态**************************************************************

--任务需要得到的物品
x210309_g_DemandItem = {{id=40002129,num=1,name="哑巴黄连"}}
x210309_g_DemandKill = {{id=552,num=1,name="哑巴恶猿"}}

--任务文本描述
x210309_g_MissionName="哑巴黄连"
x210309_g_MissionInfo=[[
        现在只要再有一味“哑巴黄连”就可以彻底清除柴大官人的惊吓病，不过这味“哑巴黄连”只有一只不会说话，但力大无穷的恶猿才能挖到。
        ]]  --任务描述
x210309_g_MissionTarget=[[
        杀死哑巴恶猿，得到哑巴黄连.
]]		--任务目标
x210309_g_ContinueInfo="杀死哑巴恶猿了吗，快点去找吧。"		--未完成任务的npc对话
x210309_g_MissionComplete="你真太感谢你了!"					--完成任务npc说话的话

x210309_g_MoneyBonus=1032
x210309_g_ItemBonus={{id=30002001,num=1},{id=10412001,num=1}}
x210309_g_RadioItemBonus={{id=10100001,num=1},{id=10210001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210309_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x210309_g_MissionId) > 0 then
	--	return
	--end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x210309_g_MissionId) > 0 then
		--发送任务需求的信息
		if x210309_CheckSubmit(sceneId, selfId )==1 then
			x210309_OnComplete( sceneId, selfId, targetId);
		else
			x210309_OnContinue( sceneId, selfId, targetId);
		end
	elseif x210309_CheckAccept(sceneId,selfId) > 0 then
	  --满足任务接收条件
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId, x210309_g_MissionName)
			AddText(sceneId, x210309_g_MissionInfo)
			AddText(sceneId, "#{M_MUBIAO}")
			AddText(sceneId, x210309_g_MissionTarget)
			AddMoneyBonus( sceneId, x210309_g_MoneyBonus )
			for i, item in x210309_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
			for i, item in x210309_g_RadioItemBonus do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x210309_g_ScriptId,x210309_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210309_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x210309_g_MissionId) > 0 then
    	return 
	end
  --如果已接此任务
  if IsHaveMission(sceneId,selfId,x210309_g_MissionId) > 0 then
		AddNumText(sceneId,x210309_g_ScriptId,x210309_g_MissionName);
	--满足任务接收条件
  elseif x210309_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x210309_g_ScriptId,x210309_g_MissionName);
  end
end

--**********************************
--检测接受条件
--**********************************
function x210309_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel( sceneId, selfId ) >= 15 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210309_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210309_g_MissionId, x210309_g_ScriptId, 1, 0, 1 );
	misIndex = GetMissionIndexByID(sceneId, selfId, x210309_g_MissionId);			--得到任务的序列号
	SetMissionByIndex(sceneId, selfId, misIndex, 0, 0);						--根据序列号把任务变量的第0位置0 (任务完成情况)
end

--**********************************
--放弃
--**********************************
function x210309_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
  DelMission( sceneId, selfId, x210309_g_MissionId );
end

--**********************************
--继续
--**********************************
function x210309_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
  BeginEvent(sceneId);
	AddText(sceneId, x210309_g_MissionName);
	AddText(sceneId, x210309_g_ContinueInfo);
	for i, item in x210309_g_DemandItem do
		AddItemDemand( sceneId, item.id, item.num )
	end
	EndEvent();
	bDone = x210309_CheckSubmit(sceneId, selfId );
	DispatchMissionDemandInfo(sceneId, selfId, targetId, x210309_g_ScriptId, x210309_g_MissionId, bDone);
end

--**********************************
--完成任务
--**********************************
function x210309_OnComplete( sceneId, selfId, targetId )
	--提交任务时的说明信息
  BeginEvent(sceneId)
	AddText(sceneId, x210309_g_MissionName);
	AddText(sceneId, x210309_g_MissionComplete);
	AddMoneyBonus( sceneId, x210309_g_MoneyBonus );
  for i, item in x210309_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num );
	end
  for i, item in x210309_g_RadioItemBonus do
		AddRadioItemBonus( sceneId, item.id, item.num );
	end
  EndEvent( )
  DispatchMissionContinueInfo(sceneId, selfId, targetId, x210309_g_ScriptId, x210309_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210309_CheckSubmit( sceneId, selfId )
	for i, item in x210309_g_DemandItem do
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
function x210309_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x210309_CheckSubmit( sceneId, selfId, selectRadioId ) then
  	BeginAddItem(sceneId);
		for i, item in x210309_g_ItemBonus do
			AddItem( sceneId, item.id, item.num );
		end
		for i, item in x210309_g_RadioItemBonus do
			if item.id == selectRadioId then
				AddItem( sceneId,item.id, item.num );
			end
		end
		ret = EndAddItem(sceneId, selfId);
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId, selfId, x210309_g_MoneyBonus );
			ret = DelMission( sceneId, selfId, x210309_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId, selfId, x210309_g_MissionId );
				--扣除任务物品
				for i, item in x210309_g_DemandItem do
					DelItem( sceneId, selfId, item.id, item.num );
				end
				AddItemListToHuman(sceneId, selfId);
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
function x210309_OnKillObject( sceneId, selfId, objdataId, objId)--参数意思：场景号、玩家objId、怪物表位置号、怪物objId
  print(x210309_g_MissionName .. " 需要杀死的怪物id:".. x210309_g_DemandKill[1].id .. "杀死的怪物id=" .. objdataId);
	if objdataId == x210309_g_DemandKill[1].id then
		num = GetMonsterOwnerCount(sceneId, objId)--取得这个怪物死后拥有分配权的人数
		for i=0,num-1 do
			humanObjId = GetMonsterOwnerID(sceneId, objId, i)--取得拥有分配权的人的objId
			if IsHaveMission(sceneId, humanObjId, x210309_g_MissionId) > 0 then	--如果这个人拥有任务	
				for i, item in x210309_g_DemandItem do
					if( GetItemCount(sceneId,humanObjId, item.id) < item.num ) then
						AddMonsterDropItem(sceneId, objId, humanObjId, item.id)    --给这个人任务道具(道具会出现在尸体包里)
					end
				end
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x210309_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210309_OnItemChanged( sceneId, selfId, itemdataId )
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210309_g_MissionId);
	SetMissionByIndex(sceneId, selfId, misIndex, 0, 0); --首先认为没有完成任务
	local bMissionDone = true;
  BeginEvent(sceneId)
  
	for i, item in x210309_g_DemandItem do
		if itemdataId == item.id then
			local nItemNum = GetItemCount(sceneId, selfId, item.id);
			local strText = format("已得到%s%d/%d", item.name, nItemNum, item.num );
			AddText(sceneId, strText);
			if nItemNum < item.num then
				bMissionDone = false;
			end
		end
	end
	--当物品数量达到要求而此时任务完成标志仍然是0,则把任务标志设置成1
	if bMissionDone then
		SetMissionByIndex(sceneId, selfId, misIndex, 0, 1) --确实完成任务了
	end
	
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
