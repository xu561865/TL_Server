--庞安时任务 七叶莲子 找人

--脚本号
x200803_g_scriptId = 200803

--前提任务
x200803_g_missionIdPre = 21

--任务号
x200803_g_missionId = 22

--目标NPC
x200803_g_name	="钟灵" 

--货物ID
x200803_g_ItemID = 10105001

--任务名
local  PlayerName=""
x200803_g_missionName="七叶莲子3"
x200803_g_missionText_0 = "这份七叶莲子交给你了。快拿它去救人吧。"
x200803_g_missionText_1 = "任务目标：\n把七叶莲子交给钟灵"
x200803_g_missionText_2 = "什么？这毒连七叶莲子都解不了吗？妈妈快来救我啊！！"
x200803_g_MoneyBonus=100
x200803_g_ItemBonus={{id=10105001,num=1}}

--**********************************
--任务入口函数
--**********************************
function x200803_OnDefaultEvent( sceneId, selfId, targetId )

	--如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x200803_g_missionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x200803_g_missionId) > 0)  then
		if GetName(sceneId,targetId) == x200803_g_name then
			x200803_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x200803_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200803_g_name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x200803_g_missionName)
			AddText(sceneId,x200803_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x200803_g_missionText_1)
			AddMoneyBonus( sceneId, x200803_g_MoneyBonus )
			for i, item in x200803_g_ItemBonus do
						AddItemBonus( sceneId, item.id, item.num )
					end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x200803_g_scriptId,x200803_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x200803_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x200803_g_missionIdPre) <= 0 then
    	return
    end
	--如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x200803_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x200803_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200803_g_name then
			AddNumText(sceneId, x200803_g_scriptId,x200803_g_missionName);
		end
    --满足任务接收条件
    elseif x200803_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200803_g_name then
			AddNumText(sceneId,x200803_g_scriptId,x200803_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x200803_CheckAccept( sceneId, selfId )
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
function x200803_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x200803_g_missionId, x200803_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x200803_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x200803_g_missionId )
end

--**********************************
--继续
--**********************************
function x200803_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200803_g_missionName)
     AddText(sceneId,x200803_g_missionText_2)
   AddMoneyBonus( sceneId, x200803_g_MoneyBonus )
    for i, item in x200803_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200803_g_scriptId,x200803_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200803_CheckSubmit( sceneId, selfId )
	itemNum = GetItemCount( sceneId, selfId, x200803_g_ItemID );
    if itemNum > 0 then
    	return 1;
    end
	return 0
end

--**********************************
--提交
--**********************************
function x200803_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x200803_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x200803_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x200803_g_MoneyBonus );
			DelMission( sceneId,selfId,  x200803_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x200803_g_missionId )
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200803_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200803_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200803_OnItemChanged( sceneId, selfId, itemdataId )
end
