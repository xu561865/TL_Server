--找人任务
--不速之客2

--脚本号
x200102_g_scriptId = 200102

x200102_g_missionIdPre = 1	--上一个任务的ID
--任务号
x200102_g_missionId = 2

--目标NPC
x200102_g_name="段正淳"

--任务名
local  PlayerName=""
x200102_g_missionName="不速之客2"
x200102_g_missionText_0="我是伏牛派的过彦之"
--,我有急事找我师叔崔百泉,无意打扰王爷办公,请王爷多多包涵."
x200102_g_missionText_1="任务目标：\n把过彦之的事情转告镇南王段正淳"
x200102_g_MoneyBonus=166
x200102_g_ItemBonus={{id=10105001,num=1}}
x200102_g_missionText_2="做得不错"
--，奖励你"   --..x200102_g_MoneyBonus.."两银子"


--**********************************
--任务入口函数
--**********************************
function x200102_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x200102_g_missionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x200102_g_missionId) > 0)  then
		if GetName(sceneId,targetId) == x200102_g_name then
			x200102_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x200102_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200102_g_name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x200102_g_missionName)
			AddText(sceneId,x200102_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x200102_g_missionText_1)
			AddMoneyBonus( sceneId, x200102_g_MoneyBonus )
			for i, item in x200102_g_ItemBonus do
						AddItemBonus( sceneId, item.id, item.num )
					end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x200102_g_scriptId,x200102_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x200102_OnEnumerate( sceneId, selfId, targetId )
--AddNumText(sceneId,x200102_g_scriptId,x200102_g_missionName);
	
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x200102_g_missionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x200102_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x200102_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200102_g_name then
			AddNumText(sceneId, x200102_g_scriptId,x200102_g_missionName);
		end
    --满足任务接收条件
    elseif x200102_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200102_g_name then
			AddNumText(sceneId,x200102_g_scriptId,x200102_g_missionName);
		end
    end
    
end

--**********************************
--检测接受条件
--**********************************
function x200102_CheckAccept( sceneId, selfId )
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
function x200102_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x200102_g_missionId, x200102_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x200102_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x200102_g_missionId )
end

--**********************************
--继续
--**********************************
function x200102_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200102_g_missionName)
     AddText(sceneId,x200102_g_missionText_2)
   AddMoneyBonus( sceneId, x200102_g_MoneyBonus )
    for i, item in x200102_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200102_g_scriptId,x200102_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200102_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x200102_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x200102_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x200102_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x200102_g_MoneyBonus );
			DelMission( sceneId,selfId,  x200102_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x200102_g_missionId )
			CallScriptFunction( 200201, "OnDefaultEvent",sceneId, selfId, targetId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200102_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200102_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200102_OnItemChanged( sceneId, selfId, itemdataId )
end
