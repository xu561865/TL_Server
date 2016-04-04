--找人，重归于好D，蔡卞找保定帝

--脚本号
x200604_g_scriptId = 200604

--前提任务
x200604_g_missionIdPre = 15

--任务号
x200604_g_missionId = 16

--目标NPC
x200604_g_name	="保定帝" 

--任务名
local  PlayerName=""
x200604_g_missionName="重归于好4"
x200604_g_missionText_0="你已经出色的完成了你对我的承诺"
--。\n有个好消息告诉你，我也完成了对你的承诺，盐运的事情已经解决，你可以回大理交差了。"
x200604_g_missionText_1="快些回大理向保定帝复命吧。"
x200604_g_missionText_2="是"..PlayerName.."回来了吧"
--，朕真是太高兴了。"
x200604_g_MoneyBonus=100
x200604_g_ItemBonus={{id=10105001,num=1}}

--**********************************
--任务入口函数
--**********************************
function x200604_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x200604_g_missionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x200604_g_missionId) > 0)  then
		if GetName(sceneId,targetId) == x200604_g_name then
			x200604_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x200604_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200604_g_name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x200604_g_missionName)
			AddText(sceneId,x200604_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x200604_g_missionText_1)
			AddMoneyBonus( sceneId, x200604_g_MoneyBonus )
			for i, item in x200604_g_ItemBonus do
						AddItemBonus( sceneId, item.id, item.num )
					end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x200604_g_scriptId,x200604_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x200604_OnEnumerate( sceneId, selfId, targetId )
    
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x200604_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x200604_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200604_g_name then
			AddNumText(sceneId, x200604_g_scriptId,x200604_g_missionName);
		end
    --满足任务接收条件
    elseif x200604_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200604_g_name then
			AddNumText(sceneId,x200604_g_scriptId,x200604_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x200604_CheckAccept( sceneId, selfId )
	bDone = IsMissionHaveDone( sceneId, selfId, x200604_g_missionIdPre );
	if bDone > 0 then
		return 1;
	else
		return 0;
	end
end

--**********************************
--接受
--**********************************
function x200604_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x200604_g_missionId, x200604_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x200604_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x200604_g_missionId )
end

--**********************************
--继续
--**********************************
function x200604_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200604_g_missionName)
     AddText(sceneId,x200604_g_missionText_2)
   AddMoneyBonus( sceneId, x200604_g_MoneyBonus )
    for i, item in x200604_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200604_g_scriptId,x200604_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200604_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x200604_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x200604_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x200604_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x200604_g_MoneyBonus );
			DelMission( sceneId,selfId,  x200604_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x200604_g_missionId )
			CallScriptFunction( 200701, "OnDefaultEvent",sceneId, selfId, targetId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200604_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200604_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200604_OnItemChanged( sceneId, selfId, itemdataId )
end
