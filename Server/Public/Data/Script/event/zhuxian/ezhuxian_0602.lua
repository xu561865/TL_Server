--送货
--重归于好2

--脚本号
x200602_g_scriptId = 200602

--前提任务
x200602_g_missionIdPre  = 13;

--任务号
x200602_g_missionId = 14

--任务文本描述
x200602_g_missionName="重归于好2"
x200602_g_missionInfo="这份药请你送给吕惠卿"
--，还是老方法，一日两次，温酒吞服。唉，每个人都应当保重身体啊。"
x200602_g_missionRenWuMuBiao="任务目标：\n将药交给吕惠卿。"
x200602_g_missionRenContinueInfo="吕大人，这是庞安时大夫给您的药，请您马上用温酒服下吧。"
x200602_g_missionRenSubmitInfo="我感到舒服多了。实在是太劳烦你了！"

--货物ID
x200602_g_ItemID = 10105001

--奖励

--收货人
x200602_g_name="吕惠卿" 

--**********************************
--任务入口函数
--**********************************
function x200602_OnDefaultEvent( sceneId, selfId, targetId )
	
    --如果已接此任务
    if IsMissionHaveDone( sceneId, selfId, x200602_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x200602_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200602_g_name then
			--发送交任务前的需求信息
    		BeginEvent(sceneId)
    		AddText(sceneId,x200602_g_missionRenContinueInfo);
    		AddItemDemand( sceneId, x200602_g_ItemID, 1 );
    		EndEvent(sceneId)
    		
    		done = x200602_CheckSubmit( sceneId, selfId );
   			DispatchMissionDemandInfo(sceneId,selfId,targetId,x200602_g_scriptId,x200602_g_missionId,done)
 		end
    --满足任务接收条件
    elseif x200602_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200602_g_name then
			--发送任务接受时显示的信息
	    	BeginEvent(sceneId)
    		AddText(sceneId,x200602_g_missionName);
    		AddText(sceneId,x200602_g_missionInfo);
    		AddText(sceneId,x200602_g_missionRenWuMuBiao);
	    	EndEvent(sceneId)
	    	DispatchMissionInfo(sceneId,selfId,targetId,x200602_g_scriptId,x200602_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x200602_OnEnumerate( sceneId, selfId, targetId )

    if IsMissionHaveDone( sceneId, selfId, x200602_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x200602_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200602_g_name then
			AddNumText(sceneId, x200602_g_scriptId,x200602_g_missionName)
		end
    --满足任务接收条件
    elseif x200602_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200602_g_name then
			AddNumText(sceneId, x200602_g_scriptId, x200602_g_missionName);
		end
    end
end

--**********************************
--检测触发条件
--**********************************
function x200602_CheckAccept( sceneId, selfId )
	bDone = IsMissionHaveDone( sceneId, selfId, x200602_g_missionIdPre );
	if bDone > 0 then
		return 1;
	else
		return 0;
	end
end

--**********************************
--接受
--**********************************
function x200602_OnAccept( sceneId, selfId )

	--加入任务到玩家列表
	--加入任务物品
	BeginAddItem( sceneId )
	AddItem( sceneId, x200602_g_ItemID, 1 )
	ret = EndAddItem( sceneId, selfId )

	if ret > 0 then 
		AddItemListToHuman(sceneId,selfId)
		ret = AddMission( sceneId,selfId, x200602_g_missionId, x200602_g_scriptId, 0, 0, 0 )
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
		end
	end
end

--**********************************
--放弃
--**********************************
function x200602_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x200602_g_missionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, x200602_g_ItemID, 1 )
	end
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x200602_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200602_g_missionRenSubmitInfo);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200602_g_scriptId,x200602_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200602_CheckSubmit( sceneId, selfId )
    itemNum = GetItemCount( sceneId, selfId, x200602_g_ItemID );
    if itemNum > 0 then
    	return 1;
    end
	return 0
end

--**********************************
--提交（完成）
--**********************************
function x200602_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x200602_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = DelMission( sceneId, selfId, x200602_g_missionId );
		if ret > 0 then
    		DelItem( sceneId,selfId,x200602_g_ItemID,1)
			MissionCom( sceneId, selfId, x200602_g_missionId )
			CallScriptFunction( 200603, "OnDefaultEvent",sceneId, selfId, targetId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200602_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200602_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200602_OnItemChanged( sceneId, selfId, itemdataId )
end
