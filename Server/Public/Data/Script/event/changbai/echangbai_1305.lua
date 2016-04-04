--送货任务
--寻找阿骨打
--MisDescBegin
--脚本号
x211305_g_ScriptId = 211305

--前提任务
--g_MissionIdPre  = 

--任务号
x211305_g_MissionId = 565

--任务归类
x211305_g_MissionKind = 33

--任务等级
x211305_g_MissionLevel = 80

--是否是精英任务
x211305_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x211305_g_IsMissionOkFail = 0		--变量的第0位

--以上是动态**************************************************************

--任务需要得到的物品
x211305_g_DemandItem={{id=40002102,num=1}}		--变量第1位

--任务文本描述
x211305_g_MissionName="寻找阿骨打"
x211305_g_MissionInfo="帮我把这封信带给阿骨打"
x211305_g_MissionTarget="任务目标：劾里钵的信交给完颜阿骨打"
x211305_g_ContinueInfo="这是给你的"
x211305_g_MissionComplete="谢谢"

--货物ID
x211305_g_ItemID = 40002102

--奖励

--收货人
x211305_g_Name = "完颜阿骨打"

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211305_OnDefaultEvent( sceneId, selfId, targetId )
	--如果已接此任务
    if IsMissionHaveDone( sceneId, selfId, x211305_g_MissionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x211305_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211305_g_Name then
			--发送交任务前的需求信息
    		BeginEvent(sceneId)
				AddText(sceneId,x211305_g_ContinueInfo);
				AddItemDemand( sceneId, x211305_g_ItemID, 1 );
    		EndEvent(sceneId)
    		done = x211305_CheckSubmit( sceneId, selfId );
   			DispatchMissionDemandInfo(sceneId,selfId,targetId,x211305_g_ScriptId,x211305_g_MissionId,done)
 		end
    --满足任务接收条件
    elseif x211305_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211305_g_Name then
			--发送任务接受时显示的信息
	    	BeginEvent(sceneId)
				AddText(sceneId,x211305_g_MissionName);
				AddText(sceneId,x211305_g_MissionInfo);
				AddText(sceneId,x211305_g_MissionTarget);
	    	EndEvent(sceneId)
	    	DispatchMissionInfo(sceneId,selfId,targetId,x211305_g_ScriptId,x211305_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x211305_OnEnumerate( sceneId, selfId, targetId )
	if IsMissionHaveDone( sceneId, selfId, x211305_g_MissionId ) > 0 then
		return 
	elseif IsHaveMission(sceneId,selfId,x211305_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211305_g_Name then
			AddNumText(sceneId, x211305_g_ScriptId,x211305_g_MissionName)
		end
	--满足任务接收条件
	elseif x211305_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211305_g_Name then
			AddNumText(sceneId, x211305_g_ScriptId, x211305_g_MissionName);
		end
	end
end

--**********************************
--检测触发条件
--**********************************
function x211305_CheckAccept( sceneId, selfId )
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
function x211305_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	--加入任务物品
	BeginAddItem( sceneId )
		AddItem( sceneId, x211305_g_ItemID, 1 )
	ret = EndAddItem( sceneId, selfId )
	if ret > 0 then 
		ret = AddMission( sceneId,selfId, x211305_g_MissionId, x211305_g_ScriptId, 0, 0, 0 )	
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			--下面2句必须写在AddMission之后
			misIndex = GetMissionIndexByID(sceneId,selfId,x211305_g_MissionId)			--得到任务的序列号
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)		--根据序列号把任务变量的第0位置1 (任务完成情况)
		else
			BeginEvent(sceneId)
				strText = "添加任务失败"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	else
		BeginEvent(sceneId)
			strText = "背包已满,无法接受任务"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

--**********************************
--放弃
--**********************************
function x211305_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x211305_g_MissionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, x211305_g_ItemID, 1 )
	end
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x211305_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x211305_g_MissionComplete);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x211305_g_ScriptId,x211305_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211305_CheckSubmit( sceneId, selfId )
    itemNum = GetItemCount( sceneId, selfId, x211305_g_ItemID );
    if itemNum > 0 then
    	return 1;
    end
	return 0
end

--**********************************
--提交（完成）
--**********************************
function x211305_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x211305_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = 	DelMission( sceneId, selfId, x211305_g_MissionId )
		if ret > 0 then
    		MissionCom( sceneId, selfId, x211305_g_MissionId )
			DelItem( sceneId,selfId,x211305_g_ItemID,1)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x211305_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x211305_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211305_OnItemChanged( sceneId, selfId, itemdataId )
end
