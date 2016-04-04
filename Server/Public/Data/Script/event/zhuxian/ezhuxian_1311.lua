--寻物任务
--天皇巨星1
--明教14级主线任务第1步

--脚本号
x201311_g_scriptId = 201311

--上一个任务的ID
x201311_g_missionIdPre = 50	

--任务号
x201311_g_missionId = 51

--目标NPC
x201311_g_name	="高俅"

--任务名
local  PlayerName=""
x201311_g_missionName="天皇巨星1"
x201311_g_missionText_0="读书？习武？那么枯燥辛苦的事情谁会去做，看我，每天玩玩蹴鞠，强身健体、陶冶情操，端王也佩服我技艺高超，让我到端王府任职...\n（这高俅只凭蹴鞠就能身穿华服，位居高官？的确令人怀疑。都说酒后吐真言，我灌他一灌，看看能不能套出些有用的消息。"
x201311_g_missionText_1="用杜康酒灌醉高俅"
x201311_g_missionText_2="来来来，再喝一杯，这真是天下少有的美酒。\n童贯这匹夫，10万两，10万两啊！总有一天，你要连本带利还给我，哈哈哈哈...哈!哈!哈!哈!哈哈..."
x201311_g_MoneyBonus=166
x201311_g_ItemBonus={{id=10105001,num=1}}

--**********************************
--任务入口函数
--**********************************
function x201311_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x201311_g_missionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x201311_g_missionId) > 0)  then
		if targetId == g_targetId then
			x201311_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x201311_CheckAccept(sceneId,selfId) > 0 then
   		if targetId ~= g_targetId then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x201311_g_missionName)
			AddText(sceneId,x201311_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x201311_g_missionText_1)
			AddMoneyBonus( sceneId, x201311_g_MoneyBonus )
			for i, item in x201311_g_ItemBonus do
						AddItemBonus( sceneId, item.id, item.num )
					end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x201311_g_scriptId,x201311_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x201311_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家不是少林派的
	
	--如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x201311_g_missionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x201311_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x201311_g_missionId) > 0 then
		if targetId == g_targetId then
			AddNumText(sceneId, x201311_g_scriptId,x201311_g_missionName);
		end
    --满足任务接收条件
    elseif x201311_CheckAccept(sceneId,selfId) > 0 then
		if targetId~= g_targetId then
			AddNumText(sceneId,x201311_g_scriptId,x201311_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x201311_CheckAccept( sceneId, selfId )
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
function x201311_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x201311_g_missionId, x201311_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x201311_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x201311_g_missionId )
end

--**********************************
--继续
--**********************************
function x201311_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x201311_g_missionName)
     AddText(sceneId,x201311_g_missionText_2)
   AddMoneyBonus( sceneId, x201311_g_MoneyBonus )
    for i, item in x201311_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x201311_g_scriptId,x201311_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x201311_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x201311_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x201311_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x201311_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x201311_g_MoneyBonus );
			DelMission( sceneId,selfId,  x201311_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x201311_g_missionId )
			CallScriptFunction( 201312, "OnDefaultEvent",sceneId, selfId, targetId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x201311_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x201311_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x201311_OnItemChanged( sceneId, selfId, itemdataId )
end







