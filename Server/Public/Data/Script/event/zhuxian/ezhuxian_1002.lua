--送货任务
--无恶不作2

--脚本号
x201002_g_scriptId = 201002

--上一个任务的ID
x201002_g_missionIdPre = 25

--任务号
x201002_g_missionId = 26

--目标NPC
x201002_g_name	="傅思归"

--货物ID
x201002_g_ItemID = 10105003

--任务文本描述
x201002_g_missionName="无恶不作2"
x201002_g_missionInfo="什么，这是我的宝宝"
--，你有本事在夜晚来临之前把宝宝从我怀中抢走我自然无法弄死他，就怕你没这本事。除非你能找回我的孩子。。。\n（一段漫长的劝说）\n好吧，我暂且相信你，我暂时不害这些孩子了，你去把这个锁片交给大理城内的傅思归，让他来领他的孩子吧，如果不快点我可会改变主意的。"
x201002_g_missionRenWuMuBiao="任务目标：\n把金锁片交给傅思归"
x201002_g_missionRenContinueInfo="这是叶二娘让我带给你的"
--，你的孩子已经安全了，快到万劫谷去领回来吧，免得再生祸端"
x201002_g_missionRenSubmitInfo="恩人，如果我的孩儿能活着"
--，我给你做牛做马也愿意。"

--**********************************
--任务入口函数
--**********************************
function x201002_OnDefaultEvent( sceneId, selfId, targetId )
	
    --如果已接此任务
    if IsMissionHaveDone( sceneId, selfId, x201002_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x201002_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201002_g_name then
			--发送交任务前的需求信息
    		BeginEvent(sceneId)
    		AddText(sceneId,x201002_g_missionRenContinueInfo);
    		AddItemDemand( sceneId, x201002_g_ItemID, 1 );
    		EndEvent(sceneId)
    		
    		done = x201002_CheckSubmit( sceneId, selfId );
   			DispatchMissionDemandInfo(sceneId,selfId,targetId,x201002_g_scriptId,x201002_g_missionId,done)
 		end
    --满足任务接收条件
    elseif x201002_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201002_g_name then
			--发送任务接受时显示的信息
	    	BeginEvent(sceneId)
    		AddText(sceneId,x201002_g_missionName);
    		AddText(sceneId,x201002_g_missionInfo);
    		AddText(sceneId,x201002_g_missionRenWuMuBiao);
	    	EndEvent(sceneId)
	    	DispatchMissionInfo(sceneId,selfId,targetId,x201002_g_scriptId,x201002_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x201002_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x201002_g_missionIdPre) <= 0 then
    	return
    end
	--如果玩家完成过这个任务
    if IsMissionHaveDone( sceneId, selfId, x201002_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x201002_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201002_g_name then
			AddNumText(sceneId, x201002_g_scriptId,x201002_g_missionName)
		end
    --满足任务接收条件
    elseif x201002_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201002_g_name then
			AddNumText(sceneId, x201002_g_scriptId, x201002_g_missionName);
		end
    end
end

--**********************************
--检测触发条件
--**********************************
function x201002_CheckAccept( sceneId, selfId )
	bDone = IsMissionHaveDone( sceneId, selfId, x201002_g_missionIdPre );
	if bDone > 0 then
		return 1;
	else
		return 0;
	end
end

--**********************************
--接受
--**********************************
function x201002_OnAccept( sceneId, selfId )

	--加入任务到玩家列表
	--加入任务物品
	BeginAddItem( sceneId )
	AddItem( sceneId, x201002_g_ItemID, 1 )
	ret = EndAddItem( sceneId, selfId )

	if ret > 0 then 
		AddItemListToHuman(sceneId,selfId)
		ret = AddMission( sceneId,selfId, x201002_g_missionId, x201002_g_scriptId, 0, 0, 0 )
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
		end
	end
end

--**********************************
--放弃
--**********************************
function x201002_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x201002_g_missionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, x201002_g_ItemID, 1 )
	end
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x201002_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x201002_g_missionRenSubmitInfo);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x201002_g_scriptId,x201002_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x201002_CheckSubmit( sceneId, selfId )
    itemNum = GetItemCount( sceneId, selfId, x201002_g_ItemID );
    if itemNum > 0 then
    	return 1;
    end
	return 0
end

--**********************************
--提交（完成）
--**********************************
function x201002_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x201002_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = DelMission( sceneId, selfId, x201002_g_missionId );
		if ret > 0 then
    		DelItem( sceneId,selfId,x201002_g_ItemID,1)
			MissionCom( sceneId, selfId, x201002_g_missionId )
			CallScriptFunction( 201101, "OnDefaultEvent",sceneId, selfId, targetId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x201002_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x201002_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x201002_OnItemChanged( sceneId, selfId, itemdataId )
end
