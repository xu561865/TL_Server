--找物任务
--清贫

--脚本号
x200501_g_scriptId = 200501

--前提任务
x200501_g_missionIdPre = 10

--任务号
x200501_g_missionId = 11

--任务文本描述
x200501_g_missionName="清贫1"
x200501_g_missionInfo="盐运的事情暂且免提"
--，这些破烂也不要留在我的府上……这些东西，也只有蔡卞看得上眼。"
x200501_g_missionRenWuMuBiao="任务目标：\n把礼物转送给蔡卞"
x200501_g_missionRenContinueInfo="这是送给我的吗？"
x200501_g_missionRenSubmitInfo="原来是这样"
--。\n我哥哥素来豪奢，上次他送我的一个厨师什么饭都不会做，后来才知道这厨师在他家是专业擀包子皮的。也难怪他看不上你的礼物。"

--货物ID
x200501_g_ItemID = 30002061

--奖励

--收货人
x200501_g_name ="蔡卞" 

--**********************************
--任务入口函数
--**********************************
function x200501_OnDefaultEvent( sceneId, selfId, targetId )

    --如果已接此任务
    if IsMissionHaveDone( sceneId, selfId, x200501_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x200501_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200501_g_name then
			--发送交任务前的需求信息
    		BeginEvent(sceneId)
    		AddText(sceneId,x200501_g_missionRenContinueInfo);
    		AddItemDemand( sceneId, x200501_g_ItemID, 1 );
    		EndEvent(sceneId)
    		
    		done = x200501_CheckSubmit( sceneId, selfId );
   			DispatchMissionDemandInfo(sceneId,selfId,targetId,x200501_g_scriptId,x200501_g_missionId,done)
 		end
    --满足任务接收条件
    elseif x200501_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200501_g_name then
			--发送任务接受时显示的信息
	    	BeginEvent(sceneId)
    		AddText(sceneId,x200501_g_missionName);
    		AddText(sceneId,x200501_g_missionInfo);
    		AddText(sceneId,x200501_g_missionRenWuMuBiao);
	    	EndEvent(sceneId)
	    	DispatchMissionInfo(sceneId,selfId,targetId,x200501_g_scriptId,x200501_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x200501_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x200501_g_missionIdPre) <= 0 then
    	return
    end
    if IsMissionHaveDone( sceneId, selfId, x200501_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x200501_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200501_g_name then
			AddNumText(sceneId, x200501_g_scriptId,x200501_g_missionName)
		end
    --满足任务接收条件
    elseif x200501_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200501_g_name then
			AddNumText(sceneId, x200501_g_scriptId, x200501_g_missionName);
		end
    end
end

--**********************************
--检测触发条件
--**********************************
function x200501_CheckAccept( sceneId, selfId )
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
function x200501_OnAccept( sceneId, selfId )

	--加入任务到玩家列表
	--加入任务物品
	BeginAddItem( sceneId )
	AddItem( sceneId, x200501_g_ItemID, 1 )
	ret = EndAddItem( sceneId, selfId )

	if ret > 0 then 
		AddItemListToHuman(sceneId,selfId)
		ret = AddMission( sceneId,selfId, x200501_g_missionId, x200501_g_scriptId, 0, 0, 0 )
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
		end
	end
end

--**********************************
--放弃
--**********************************
function x200501_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x200501_g_missionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, x200501_g_ItemID, 1 )
	end
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x200501_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200501_g_missionRenSubmitInfo);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200501_g_scriptId,x200501_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200501_CheckSubmit( sceneId, selfId )
    itemNum = GetItemCount( sceneId, selfId, x200501_g_ItemID );
    if itemNum > 0 then
    	return 1;
    end
	return 0
end

--**********************************
--提交（完成）
--**********************************
function x200501_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x200501_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = DelMission( sceneId, selfId, x200501_g_missionId );
		if ret > 0 then
    		DelItem( sceneId,selfId,x200501_g_ItemID,1)
			MissionCom( sceneId, selfId, x200501_g_missionId )
			CallScriptFunction( 200502, "OnDefaultEvent",sceneId, selfId, targetId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200501_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200501_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200501_OnItemChanged( sceneId, selfId, itemdataId )
end
