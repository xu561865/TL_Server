--找人任务
--声东击西1

--脚本号
x201801_g_scriptId = 201801

--上一个任务的ID
x201801_g_missionIdPre = 39

--任务号
x201801_g_missionId = 41

--目标NPC
x201801_g_name	="段延庆"

--任务名
local  PlayerName=""
x201801_g_missionName="声东击西1"
x201801_g_missionText_0="干的不错，这么快就杀死了10个草人，好吧，你可以做黄眉僧的先锋，去会会段延庆，不可大意"
x201801_g_missionText_1="任务目标：\n找到段延庆"
x201801_g_missionText_2="你是谁，没事躲远点，否则小命不保"
x201801_g_MoneyBonus=166
x201801_g_ItemBonus={{id=10105001,num=1}}

--**********************************
--任务入口函数
--**********************************
function x201801_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x201801_g_missionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x201801_g_missionId) > 0)  then
		if GetName(sceneId,targetId) == x201801_g_name then
			x201801_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x201801_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201801_g_name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x201801_g_missionName)
			AddText(sceneId,x201801_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x201801_g_missionText_1)
			AddMoneyBonus( sceneId, x201801_g_MoneyBonus )
			for i, item in x201801_g_ItemBonus do
						AddItemBonus( sceneId, item.id, item.num )
					end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x201801_g_scriptId,x201801_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x201801_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x201801_g_missionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x201801_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x201801_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201801_g_name then
			AddNumText(sceneId, x201801_g_scriptId,x201801_g_missionName);
		end
    --满足任务接收条件
    elseif x201801_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201801_g_name then
			AddNumText(sceneId,x201801_g_scriptId,x201801_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x201801_CheckAccept( sceneId, selfId )
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
function x201801_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x201801_g_missionId, x201801_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x201801_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x201801_g_missionId )
end

--**********************************
--继续
--**********************************
function x201801_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x201801_g_missionName)
     AddText(sceneId,x201801_g_missionText_2)
   AddMoneyBonus( sceneId, x201801_g_MoneyBonus )
    for i, item in x201801_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x201801_g_scriptId,x201801_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x201801_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x201801_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x201801_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x201801_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x201801_g_MoneyBonus );
			DelMission( sceneId,selfId,  x201801_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x201801_g_missionId )
			CallScriptFunction( 201802, "OnDefaultEvent",sceneId, selfId, targetId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x201801_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x201801_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x201801_OnItemChanged( sceneId, selfId, itemdataId )
end
