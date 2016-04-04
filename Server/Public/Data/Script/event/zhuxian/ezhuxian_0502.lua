--找物任务
--清贫

--脚本号
x200502_g_scriptId = 200502

--前提任务
x200502_g_missionIdPre = 11

--任务号
x200502_g_missionId = 12

--任务文本描述
x200502_g_missionName="清贫2"
x200502_g_missionInfo="礼物我收下了"
--。大理乃我国友邦，盐运的事情不能不管，我现在就着手办理。\n这段时间里还有件事情麻烦你。多年前为了青苗法之事，我曾经和吕惠卿宰相反目为仇，现在听说他罢官之后生活很是清贫，我想起用他做官，先请你去向他表达我的诚意。"
x200502_g_missionRenWuMuBiao="任务目标：\n找到吕惠卿表达蔡卞和好的诚意"
x200502_g_missionRenSubmitInfo="咳咳"
--……你来的正好……我一直在等你呢。"

--货物ID
x200502_g_ItemID = 30002061

--奖励

--收货人
x200502_g_name="吕惠卿" 

--**********************************
--任务入口函数
--**********************************
function x200502_OnDefaultEvent( sceneId, selfId, targetId )

    --如果已接此任务
    if IsMissionHaveDone( sceneId, selfId, x200502_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x200502_g_missionId) > 0 then
		if g_targetId == targetId then
			--发送交任务前的需求信息
    		BeginEvent(sceneId)
    		AddText(sceneId,g_missionRenContinueInfo);
    		AddItemDemand( sceneId, x200502_g_ItemID, 1 );
    		EndEvent(sceneId)
    		
    		done = x200502_CheckSubmit( sceneId, selfId );
   			DispatchMissionDemandInfo(sceneId,selfId,targetId,x200502_g_scriptId,x200502_g_missionId,done)
 		end
    --满足任务接收条件
    elseif x200502_CheckAccept(sceneId,selfId) > 0 then
		if g_targetId ~= targetId then
			--发送任务接受时显示的信息
	    	BeginEvent(sceneId)
    		AddText(sceneId,x200502_g_missionName);
    		AddText(sceneId,x200502_g_missionInfo);
    		AddText(sceneId,x200502_g_missionRenWuMuBiao);
	    	EndEvent(sceneId)
	    	DispatchMissionInfo(sceneId,selfId,targetId,x200502_g_scriptId,x200502_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x200502_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x200502_g_missionIdPre) <= 0 then
    	return
    end	
    if IsMissionHaveDone( sceneId, selfId, x200502_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x200502_g_missionId) > 0 then
		if g_targetId == targetId then
			AddNumText(sceneId, x200502_g_scriptId,x200502_g_missionName)
		end
    --满足任务接收条件
    elseif x200502_CheckAccept(sceneId,selfId) > 0 then
		if g_targetId ~= targetId then
			AddNumText(sceneId, x200502_g_scriptId, x200502_g_missionName);
		end
    end
end

--**********************************
--检测触发条件
--**********************************
function x200502_CheckAccept( sceneId, selfId )
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
function x200502_OnAccept( sceneId, selfId )

	--加入任务到玩家列表
	--加入任务物品
	BeginAddItem( sceneId )
	AddItem( sceneId, x200502_g_ItemID, 1 )
	ret = EndAddItem( sceneId, selfId )

	if ret > 0 then 
		AddItemListToHuman(sceneId,selfId)
		ret = AddMission( sceneId,selfId, x200502_g_missionId, x200502_g_scriptId, 0, 0, 0 )
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
		end
	end
end

--**********************************
--放弃
--**********************************
function x200502_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x200502_g_missionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, x200502_g_ItemID, 1 )
	end
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x200502_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200502_g_missionRenSubmitInfo);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200502_g_scriptId,x200502_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200502_CheckSubmit( sceneId, selfId )
    itemNum = GetItemCount( sceneId, selfId, x200502_g_ItemID );
    if itemNum > 0 then
    	return 1;
    end
	return 0
end

--**********************************
--提交（完成）
--**********************************
function x200502_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x200502_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = DelMission( sceneId, selfId, x200502_g_missionId );
		if ret > 0 then
    		DelItem( sceneId,selfId,x200502_g_ItemID,1)
			MissionCom( sceneId, selfId, x200502_g_missionId )
			CallScriptFunction( 200601, "OnDefaultEvent",sceneId, selfId, targetId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200502_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200502_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200502_OnItemChanged( sceneId, selfId, itemdataId )
end
