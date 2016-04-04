--使用道具任务
--修罗王的指示
--MisDescBegin
--脚本号
x212007_g_ScriptId = 212007

--上一个任务的Id
x212007_g_MissionIdPre1 = 634
x212007_g_MissionIdPre2 = 635
x212007_g_MissionIdPre3 = 636

--任务号
x212007_g_MissionId = 637

--任务归类
x212007_g_MissionKind = 40

--任务等级
x212007_g_MissionLevel = 78

--是否是精英任务
x212007_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况
--任务是否已经完成
x212007_g_IsMissionOkFail = 0		--变量的第0位

--任务需要物品
x212007_g_DemandItem={{id=40002090,num=1}}		--变量第1位

--任务文本描述
x212007_g_MissionName="修罗王的指示"
x212007_g_MissionInfo="得到修罗王的指示"
x212007_g_MissionTarget="得到修罗王的指示"
x212007_g_missionRenContinueInfo="修罗王的指示你带来了么?"
x212007_g_MissionComplete="干得不错"


--物品编号
x212007_g_ItemId1 = 40002087		--厄修罗护身符
x212007_g_ItemId2 =	40002088		--永夜修罗护身符
x212007_g_ItemId3 =	40002089		--万劫修罗护身符
x212007_g_ItemId4 = 40002090		--修罗王的指示

--任务道具需求数量
x212007_g_ItemNeedNum1 = 1
x212007_g_ItemNeedNum2 = 1
x212007_g_ItemNeedNum3 = 1
x212007_g_ItemNeedNum4 = 1



--奖励

--收货人
x212007_g_Name = "杨明"

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x212007_OnDefaultEvent( sceneId, selfId, targetId )
	--如果已接此任务
    --if IsMissionHaveDone( sceneId, selfId, x212007_g_MissionId ) > 0 then
	--	return 
    --else
	if IsHaveMission(sceneId,selfId,x212007_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x212007_g_Name then
			--发送交任务前的需求信息
    		BeginEvent(sceneId)
				AddText(sceneId,x212007_g_missionRenContinueInfo);
				AddItemDemand( sceneId, g_ItemId, 1 );
    		EndEvent(sceneId)
    		done = x212007_CheckSubmit( sceneId, selfId );
   			DispatchMissionDemandInfo(sceneId,selfId,targetId,x212007_g_ScriptId,x212007_g_MissionId,done)
 		end
    --满足任务接收条件
    elseif x212007_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x212007_g_Name then
			--发送任务接受时显示的信息
	    	BeginEvent(sceneId)
				AddText(sceneId,x212007_g_MissionName);
				AddText(sceneId,x212007_g_MissionInfo);
				AddText(sceneId,x212007_g_MissionTarget);
	    	EndEvent(sceneId)
	    	DispatchMissionInfo(sceneId,selfId,targetId,x212007_g_ScriptId,x212007_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x212007_OnEnumerate( sceneId, selfId, targetId )
	if IsMissionHaveDone( sceneId, selfId, x212007_g_MissionId ) > 0 then
		return 
	elseif IsMissionHaveDone( sceneId, selfId, x212007_g_MissionIdPre1 ) == 0 then
		return
	elseif	IsMissionHaveDone( sceneId, selfId, x212007_g_MissionIdPre2 ) == 0 then
		return
	elseif	IsMissionHaveDone( sceneId, selfId, x212007_g_MissionIdPre3 ) == 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x212007_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x212007_g_Name then
			AddNumText(sceneId, x212007_g_ScriptId,x212007_g_MissionName)
		end
	--满足任务接收条件
	elseif x212007_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x212007_g_Name then
			AddNumText(sceneId, x212007_g_ScriptId, x212007_g_MissionName);
		end
	end
end

--**********************************
--检测触发条件
--**********************************
function x212007_CheckAccept( sceneId, selfId )
	--bDone = IsMissionHaveDone( sceneId, selfId, g_MissionIdPre );
	--if bDone > 0 then
		return 1;
	--else
	--	return 0;
	--end
end

--**********************************
--接受
--**********************************
function x212007_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	--加入任务物品
	BeginAddItem( sceneId )
		AddItem( sceneId, x212007_g_ItemId1, 1 )
		AddItem( sceneId, x212007_g_ItemId2, 1 )
		AddItem( sceneId, x212007_g_ItemId3, 1 )
	ret = EndAddItem( sceneId, selfId )
	if ret > 0 then 
		ret = AddMission( sceneId,selfId, x212007_g_MissionId, x212007_g_ScriptId, 0, 0, 0 )	
		--if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
		--end
	else
		BeginEvent(sceneId)
			AddText(sceneId,"背包已满")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

--**********************************
--放弃
--**********************************
function x212007_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x212007_g_MissionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, x212007_g_ItemId1, 1 )
		DelItem( sceneId, selfId, x212007_g_ItemId2, 1 )
		DelItem( sceneId, selfId, x212007_g_ItemId3, 1 )
	end
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x212007_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x212007_g_MissionComplete);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x212007_g_ScriptId,x212007_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x212007_CheckSubmit( sceneId, selfId )
    itemNum = GetItemCount( sceneId, selfId, x212007_g_ItemId4 );
    if itemNum > 0 then
    	return 1;
    end
	return 0
end

--**********************************
--提交（完成）
--**********************************
function x212007_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x212007_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = 	DelMission( sceneId, selfId, x212007_g_MissionId )
		if ret > 0 then
    		MissionCom( sceneId, selfId, x212007_g_MissionId )
			DelItem( sceneId,selfId,x212007_g_ItemId4,1)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x212007_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x212007_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x212007_OnItemChanged( sceneId, selfId, itemdataId )
end
