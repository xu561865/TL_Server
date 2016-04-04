--找人任务
--天皇巨星3
--明教14级主线任务第3步

--脚本号
x201313_g_scriptId = 201313

--上一个任务的ID
x201313_g_missionIdPre = 52	

--任务号
x201313_g_missionId = 53

--目标NPC
x201313_g_name	="蔡卞"

--任务名
local  PlayerName=""
x201313_g_missionName="天皇巨星3"
x201313_g_missionText_0="高太尉真是难得的人才，踢得一脚好球，送礼都这么大方，将来必成大器。\n我母亲大寿，大家都这么客气，送了我不少礼物，我这个孝子自然把礼物都送回老家孝敬她老人家了"
x201313_g_missionText_1="把生辰纲已被送回童贯老家的事告诉蔡卞"
x201313_g_missionText_2="得到什么消息了？"
x201313_g_MoneyBonus=166
x201313_g_ItemBonus={{id=10105001,num=1}}

--**********************************
--任务入口函数
--**********************************
function x201313_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x201313_g_missionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x201313_g_missionId) > 0)  then
		if GetName(sceneId,targetId) == x201313_g_name then
			x201313_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x201313_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201313_g_name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x201313_g_missionName)
			AddText(sceneId,x201313_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x201313_g_missionText_1)
			AddMoneyBonus( sceneId, x201313_g_MoneyBonus )
			for i, item in x201313_g_ItemBonus do
						AddItemBonus( sceneId, item.id, item.num )
					end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x201313_g_scriptId,x201313_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x201313_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x201313_g_missionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x201313_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x201313_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201313_g_name then
			AddNumText(sceneId, x201313_g_scriptId,x201313_g_missionName);
		end
    --满足任务接收条件
    elseif x201313_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201313_g_name then
			AddNumText(sceneId,x201313_g_scriptId,x201313_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x201313_CheckAccept( sceneId, selfId )
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
function x201313_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x201313_g_missionId, x201313_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x201313_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x201313_g_missionId )
end

--**********************************
--继续
--**********************************
function x201313_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x201313_g_missionName)
     AddText(sceneId,x201313_g_missionText_2)
   AddMoneyBonus( sceneId, x201313_g_MoneyBonus )
    for i, item in x201313_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x201313_g_scriptId,x201313_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x201313_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x201313_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x201313_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x201313_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x201313_g_MoneyBonus );
			DelMission( sceneId,selfId,  x201313_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x201313_g_missionId )
			CallScriptFunction( 201411, "OnDefaultEvent",sceneId, selfId, targetId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x201313_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x201313_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x201313_OnItemChanged( sceneId, selfId, itemdataId )
end
