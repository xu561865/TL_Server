--送货任务
--心有灵犀1

--脚本号
x201601_g_scriptId = 201601

--上一个任务的ID
x201601_g_missionIdPre = 37

--任务号
x201601_g_missionId = 38

--货物ID
x201601_g_ItemID = 10105003

--目标NPC
x201601_g_name	="黄眉僧"

--任务文本描述
x201601_g_missionName="心有灵犀1"
x201601_g_missionInfo="这件事不好办了，我和他已经交过手，他的一阳指功力在我之上。一阳指是段家世代相传，传子不传女，更加不传外人，这个四大恶人之首\"恶贯满盈\"就是当年上德帝之子段延庆。\n这皇帝位子本来就是他的，我岂能去对付他。\n这样吧，我写一道圣旨，你带给黄眉僧，让他带我去救誉儿。"
x201601_g_missionRenWuMuBiao="任务目标：\n圣旨交给黄眉僧"
x201601_g_missionRenContinueInfo="黄眉大师，圣上希望你去搭救世子，这是圣旨"
x201601_g_missionRenSubmitInfo="阿弥陀佛，世子有难，我定当相助，请转告圣上，我这就动身去拖住延庆太子"

--**********************************
--任务入口函数
--**********************************
function x201601_OnDefaultEvent( sceneId, selfId, targetId )
	
    --如果已接此任务
    if IsMissionHaveDone( sceneId, selfId, x201601_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x201601_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201601_g_name then
			--发送交任务前的需求信息
    		BeginEvent(sceneId)
    		AddText(sceneId,x201601_g_missionRenContinueInfo);
    		AddItemDemand( sceneId, x201601_g_ItemID, 1 );
    		EndEvent(sceneId)
    		
    		done = x201601_CheckSubmit( sceneId, selfId );
   			DispatchMissionDemandInfo(sceneId,selfId,targetId,x201601_g_scriptId,x201601_g_missionId,done)
 		end
    --满足任务接收条件
    elseif x201601_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201601_g_name then
			--发送任务接受时显示的信息
	    	BeginEvent(sceneId)
    		AddText(sceneId,x201601_g_missionName);
    		AddText(sceneId,x201601_g_missionInfo);
    		AddText(sceneId,x201601_g_missionRenWuMuBiao);
	    	EndEvent(sceneId)
	    	DispatchMissionInfo(sceneId,selfId,targetId,x201601_g_scriptId,x201601_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x201601_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x201601_g_missionIdPre) <= 0 then
    	return
    end
	--如果玩家完成过这个任务
    if IsMissionHaveDone( sceneId, selfId, x201601_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x201601_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201601_g_name then
			AddNumText(sceneId, x201601_g_scriptId,x201601_g_missionName)
		end
    --满足任务接收条件
    elseif x201601_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201601_g_name then
			AddNumText(sceneId, x201601_g_scriptId, x201601_g_missionName);
		end
    end
end

--**********************************
--检测触发条件
--**********************************
function x201601_CheckAccept( sceneId, selfId )
	bDone = IsMissionHaveDone( sceneId, selfId, x201601_g_missionIdPre );
	if bDone > 0 then
		return 1;
	else
		return 0;
	end
end

--**********************************
--接受
--**********************************
function x201601_OnAccept( sceneId, selfId )

	--加入任务到玩家列表
	--加入任务物品
	BeginAddItem( sceneId )
	AddItem( sceneId, x201601_g_ItemID, 1 )
	ret = EndAddItem( sceneId, selfId )

	if ret > 0 then 
		AddItemListToHuman(sceneId,selfId)
		ret = AddMission( sceneId,selfId, x201601_g_missionId, x201601_g_scriptId, 0, 0, 0 )
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
		end
	end
end

--**********************************
--放弃
--**********************************
function x201601_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x201601_g_missionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, x201601_g_ItemID, 1 )
	end
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x201601_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x201601_g_missionRenSubmitInfo);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x201601_g_scriptId,x201601_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x201601_CheckSubmit( sceneId, selfId )
    itemNum = GetItemCount( sceneId, selfId, x201601_g_ItemID );
    if itemNum > 0 then
    	return 1;
    end
	return 0
end

--**********************************
--提交（完成）
--**********************************
function x201601_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x201601_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = DelMission( sceneId, selfId, x201601_g_missionId );
		if ret > 0 then
    		DelItem( sceneId,selfId,x201601_g_ItemID,1)
			MissionCom( sceneId, selfId, x201601_g_missionId )
			CallScriptFunction( 201602, "OnDefaultEvent",sceneId, selfId, targetId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x201601_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x201601_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x201601_OnItemChanged( sceneId, selfId, itemdataId )
end
