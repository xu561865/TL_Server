--杀怪任务
--遗弃木人
--MisDescBegin
--脚本号
x210301_g_ScriptId = 210301

--上一个任务的ID
--g_MissionIdPre =

--任务号
x210301_g_MissionId = 461

--任务目标npc
x210301_g_Name	="柴进" 

--任务归类
x210301_g_MissionKind = 14

--任务等级
x210301_g_MissionLevel = 52

--是否是精英任务
x210301_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况
--任务是否已经完成
x210301_g_IsMissionOkFail = 0		--变量的第0位

--任务需要杀死的怪
x210301_g_DemandKill = {{id=1590,num=10,name="遗弃木人"}}		--变量第1位

--以上是动态**************************************************************

--任务文本描述
x210301_g_MissionName="遗弃木人"
x210301_g_MissionTarget="杀死10个遗弃木人"		--任务目标
x210301_g_ContinueInfo="真笨啊，快点去！"		--未完成任务的npc对话
x210301_g_MissionComplete="嗯？看来你有两下子嘛。"					--完成任务npc说话的话

--任务奖励
x210301_g_MoneyBonus=12000
x210301_g_ItemBonus={{id=30002001,num=1},{id=10412001,num=1}}
x210301_g_RadioItemBonus={{id=10100001,num=1},{id=10210001,num=1}}

--MisDescEnd
--Only used at server
x210301_g_MissionInfo=[[
    鬼啊！！！
    哦，是你啊，%s。抱歉，我最近已经被鬼吓得失魂落魄了。
    每当我闭上眼，我总是可以看见，那些白额虎啊，遗弃木人啊，遗弃铜人啊，向我迎面扑来。我还能看到我过世的祖父，就在旁边，满身是血的冷笑着。
    求求你，去帮我杀死%d只%s。]]  --任务描述
--**********************************
--任务入口函数
--**********************************
function x210301_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x210301_g_MissionId) > 0 then
	--	return
	--end
	--如果已接此任务
	if IsHaveMission(sceneId, selfId, x210301_g_MissionId) > 0 then
		--发送任务需求的信息
		--发送任务需求的信息
		if x210301_CheckSubmit(sceneId, selfId )==1 then
			x210301_OnComplete( sceneId, selfId, targetId);
		else
			x210301_OnContinue( sceneId, selfId, targetId);
		end
	elseif x210301_CheckAccept(sceneId, selfId) > 0 then --满足任务接收条件
		--发送任务接受时显示的信息
		local PlayerName = GetName(sceneId, selfId);
		local strText = format(x210301_g_MissionInfo, PlayerName, x210301_g_DemandKill[1].num, x210301_g_MissionName);
		BeginEvent(sceneId);
		AddText(sceneId, x210301_g_MissionName);
		AddText(sceneId, strText);
		AddText(sceneId, "#{M_MUBIAO}");
		AddText(sceneId, x210301_g_MissionTarget);
		AddMoneyBonus( sceneId, x210301_g_MoneyBonus );
		for i, item in x210301_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num );
		end
		for i, item in x210301_g_RadioItemBonus do
					AddRadioItemBonus( sceneId, item.id, item.num );
		end
		EndEvent();
		DispatchMissionInfo(sceneId, selfId, targetId, x210301_g_ScriptId, x210301_g_MissionId);
	end
end

--**********************************
--列举事件
--**********************************
function x210301_OnEnumerate( sceneId, selfId, targetId )
  --如果玩家完成过这个任务
  if IsMissionHaveDone(sceneId, selfId, x210301_g_MissionId) > 0 then
  	return 
  end
  --如果已接此任务
  --else
  if IsHaveMission(sceneId, selfId, x210301_g_MissionId) > 0 then
		AddNumText(sceneId, x210301_g_ScriptId, x210301_g_MissionName);
    --满足任务接收条件
  elseif x210301_CheckAccept(sceneId, selfId) > 0 then
		AddNumText(sceneId,x210301_g_ScriptId,x210301_g_MissionName);
  end
end

--**********************************
--检测接受条件
--**********************************
function x210301_CheckAccept( sceneId, selfId )
	--需要2级才能接
	if GetLevel( sceneId, selfId ) >= 15 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210301_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	--print(format("接受了%s任务", x210301_g_MissionName));
	AddMission( sceneId, selfId, x210301_g_MissionId, x210301_g_ScriptId, 1, 0, 0 );		--添加任务
	misIndex = GetMissionIndexByID(sceneId, selfId, x210301_g_MissionId);			--得到任务的序列号
	SetMissionByIndex(sceneId, selfId, misIndex, 0, 0);						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId, selfId, misIndex, 1, 0);						--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x210301_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210301_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210301_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	BeginEvent(sceneId);
	AddText(sceneId, x210301_g_MissionName);
	AddText(sceneId, x210301_g_ContinueInfo);
	EndEvent();
	bDone = x210301_CheckSubmit(sceneId, selfId );
	DispatchMissionDemandInfo(sceneId, selfId, targetId, x210301_g_ScriptId, x210301_g_MissionId, bDone);
end

--**********************************
--完成任务
--**********************************
function x210301_OnComplete( sceneId, selfId, targetId )
	--提交任务时的说明信息
  BeginEvent(sceneId)
	AddText(sceneId, x210301_g_MissionName);
	AddText(sceneId, x210301_g_MissionComplete);
	AddMoneyBonus( sceneId, x210301_g_MoneyBonus );
  for i, item in x210301_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num );
	end
  for i, item in x210301_g_RadioItemBonus do
		AddRadioItemBonus( sceneId, item.id, item.num );
	end
  EndEvent( )
  DispatchMissionContinueInfo(sceneId, selfId, targetId, x210301_g_ScriptId, x210301_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210301_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x210301_g_MissionId);
  num = GetMissionParam(sceneId, selfId, misIndex, 1);
  if num >= x210301_g_DemandKill[1].num then
  	return 1;
  end
	return 0;
end

--**********************************
--提交
--**********************************
function x210301_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x210301_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x210301_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		for i, item in x210301_g_RadioItemBonus do
			if item.id == selectRadioId then
				AddItem( sceneId,item.id, item.num )
			end
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x210301_g_MoneyBonus );
			--扣除任务物品
			ret = DelMission( sceneId, selfId, x210301_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId, x210301_g_MissionId )
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
function x210301_OnKillObject( sceneId, selfId, objdataId )
	local PlayerName = GetName(sceneId, selfId);
	--local misIndex = GetMissionIndexByID(sceneId, selfId, x210301_g_MissionId);
	--local nNum = GetMissionParam(sceneId, selfId, misIndex, 1);
	print("玩家:" .. PlayerName);
 	if objdataId == x210301_g_DemandKill[1].id then
		local misIndex = GetMissionIndexByID(sceneId, selfId, x210301_g_MissionId);
	  local num = GetMissionParam(sceneId, selfId, misIndex, 1);
	  if num < x210301_g_DemandKill[1].num then
		--把任务完成标志设置为1
		if num == 1 then
			SetMissionByIndex(sceneId, selfId, misIndex, 0, 1);
		end
		--设置打怪数量+1
	  SetMissionByIndex(sceneId, selfId, misIndex, 1, num+1);
	  BeginEvent(sceneId);
	  local strText = format("已杀死%s%d/%d", x210301_g_DemandKill[1].name, num+1, x210301_g_DemandKill[1].num );
	  AddText(sceneId, strText);
	  EndEvent(sceneId);
		DispatchMissionTips(sceneId, selfId);
	end
end
 
end

--**********************************
--进入区域事件
--**********************************
function x210301_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210301_OnItemChanged( sceneId, selfId, itemdataId )
end
