--送货任务
--马疾香幽1

--脚本号
x201401_g_scriptId = 201401

--上一个任务的ID
x201401_g_missionIdPre = 33

--任务号
x201401_g_missionId = 34

--货物ID
x201401_g_ItemID = 10105003

--目标NPC
x201401_g_name	="段正淳"

--任务文本描述
x201401_g_missionName="马疾香幽1"
x201401_g_missionInfo="我脱不开身，但是小冤家的伤。。。唉，再请你帮个忙，把这个锦盒交给镇南王段正淳，让他帮忙搭救我女儿，他看到锦盒一定会出手相救的。对了，千万别让我丈夫看到这个锦盒。"
x201401_g_missionRenWuMuBiao="任务目标：\n将锦盒交给段正淳"
x201401_g_missionRenContinueInfo="这是钟夫人让我给你的锦盒，他女儿中了毒，请您快去帮忙"
x201401_g_missionRenSubmitInfo="这，这是宝宝的，钟夫人...钟夫人...宝宝，我对不起你。他女儿受伤了？在哪里，我马上赶去"

--**********************************
--任务入口函数
--**********************************
function x201401_OnDefaultEvent( sceneId, selfId, targetId )
	
    --如果已接此任务
    if IsMissionHaveDone( sceneId, selfId, x201401_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x201401_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201401_g_name then
			--发送交任务前的需求信息
    		BeginEvent(sceneId)
    		AddText(sceneId,x201401_g_missionRenContinueInfo);
    		AddItemDemand( sceneId, x201401_g_ItemID, 1 );
    		EndEvent(sceneId)
    		
    		done = x201401_CheckSubmit( sceneId, selfId );
   			DispatchMissionDemandInfo(sceneId,selfId,targetId,x201401_g_scriptId,x201401_g_missionId,done)
 		end
    --满足任务接收条件
    elseif x201401_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201401_g_name then
			--发送任务接受时显示的信息
	    	BeginEvent(sceneId)
    		AddText(sceneId,x201401_g_missionName);
    		AddText(sceneId,x201401_g_missionInfo);
    		AddText(sceneId,x201401_g_missionRenWuMuBiao);
	    	EndEvent(sceneId)
	    	DispatchMissionInfo(sceneId,selfId,targetId,x201401_g_scriptId,x201401_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x201401_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x201401_g_missionIdPre) <= 0 then
    	return
    end
	--如果玩家完成过这个任务
    if IsMissionHaveDone( sceneId, selfId, x201401_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x201401_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201401_g_name then
			AddNumText(sceneId, x201401_g_scriptId,x201401_g_missionName)
		end
    --满足任务接收条件
    elseif x201401_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201401_g_name then
			AddNumText(sceneId, x201401_g_scriptId, x201401_g_missionName);
		end
    end
end

--**********************************
--检测触发条件
--**********************************
function x201401_CheckAccept( sceneId, selfId )
	bDone = IsMissionHaveDone( sceneId, selfId, x201401_g_missionIdPre );
	if bDone > 0 then
		return 1;
	else
		return 0;
	end
end

--**********************************
--接受
--**********************************
function x201401_OnAccept( sceneId, selfId )

	--加入任务到玩家列表
	--加入任务物品
	BeginAddItem( sceneId )
	AddItem( sceneId, x201401_g_ItemID, 1 )
	ret = EndAddItem( sceneId, selfId )

	if ret > 0 then 
		AddItemListToHuman(sceneId,selfId)
		ret = AddMission( sceneId,selfId, x201401_g_missionId, x201401_g_scriptId, 0, 0, 0 )
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
		end
	end
end

--**********************************
--放弃
--**********************************
function x201401_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x201401_g_missionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, x201401_g_ItemID, 1 )
	end
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x201401_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x201401_g_missionRenSubmitInfo);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x201401_g_scriptId,x201401_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x201401_CheckSubmit( sceneId, selfId )
    itemNum = GetItemCount( sceneId, selfId, x201401_g_ItemID );
    if itemNum > 0 then
    	return 1;
    end
	return 0
end

--**********************************
--提交（完成）
--**********************************
function x201401_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x201401_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = DelMission( sceneId, selfId, x201401_g_missionId );
		if ret > 0 then
    		DelItem( sceneId,selfId,x201401_g_ItemID,1)
			MissionCom( sceneId, selfId, x201401_g_missionId )
			CallScriptFunction( 201402, "OnDefaultEvent",sceneId, selfId, targetId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x201401_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x201401_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x201401_OnItemChanged( sceneId, selfId, itemdataId )
end
