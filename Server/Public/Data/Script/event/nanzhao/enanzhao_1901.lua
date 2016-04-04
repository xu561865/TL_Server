--探索地图任务
--寻找蝴蝶神的图腾
--MisDescBegin
--脚本号
x211901_g_ScriptId = 211901

--前提任务
--g_MissionIdPre  = 

--任务号
x211901_g_MissionId = 621

--任务归类
x211901_g_MissionKind = 39

--任务等级
x211901_g_MissionLevel = 79

--是否是精英任务
x211901_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况*******
--任务是否已经完成
x211901_g_IsMissionOkFail = 0		--变量的第0位


--*******************以上是动态显示***********

--任务文本描述
x211901_g_MissionName="寻找蝴蝶神的图腾"
x211901_g_MissionInfo="请帮我到蝴蝶神祭坛找到蝴蝶神的图腾"
x211901_g_MissionTarget="任务目标：\n寻找蝴蝶神的图腾"
x211901_g_ContinueInfo="你找到蝴蝶神图腾了么？"		--未完成任务的npc对话
x211901_g_MissionComplete="你真的找到蝴蝶神祭坛了，谢天谢地"

--奖励

--交任务目标npc
x211901_g_Name = "阿旺"

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211901_OnDefaultEvent( sceneId, selfId, targetId )
	 --如果已完成任务
    if IsMissionHaveDone( sceneId, selfId, x211901_g_MissionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x211901_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211901_g_Name then
			--发送交任务前的需求信息
    		BeginEvent(sceneId)
    		AddText(sceneId,x211901_g_ContinueInfo);
    		EndEvent(sceneId)
    		
    		done = x211901_CheckSubmit( sceneId, selfId );
   			DispatchMissionDemandInfo(sceneId,selfId,targetId,x211901_g_ScriptId,x211901_g_MissionId,done)
 		end
    --满足任务接收条件
    elseif x211901_CheckAccept(sceneId,selfId) > 0 then
		--if GetName(sceneId,targetId) ~= x211901_g_Name then			--这个任务是探索地图,所以发任务和交任务是同一个npc,以前送货不是同一个npc,因此不需要这个判断
			--发送任务接受时显示的信息
	    	BeginEvent(sceneId)
    		AddText(sceneId,x211901_g_MissionName);
    		AddText(sceneId,x211901_g_MissionInfo);
    		AddText(sceneId,x211901_g_MissionTarget);
	    	EndEvent(sceneId)
	    	DispatchMissionInfo(sceneId,selfId,targetId,x211901_g_ScriptId,x211901_g_MissionId)
		--end
    end
end

--**********************************
--列举事件
--**********************************
function x211901_OnEnumerate( sceneId, selfId, targetId )
	
	if IsMissionHaveDone( sceneId, selfId, x211901_g_MissionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x211901_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211901_g_Name then
			AddNumText(sceneId, x211901_g_ScriptId,x211901_g_MissionName)
		end
    --满足任务接收条件
    elseif x211901_CheckAccept(sceneId,selfId) > 0 then
		--if GetName(sceneId,targetId) ~= x211901_g_Name then		--这个任务是探索地图,所以发任务和交任务是同一个npc,以前送货不是同一个npc,因此不需要这个判断
		AddNumText(sceneId, x211901_g_ScriptId, x211901_g_MissionName);
		--end
    end
end

--**********************************
--检测触发条件
--**********************************
function x211901_CheckAccept( sceneId, selfId )
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
function x211901_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x211901_g_MissionId, x211901_g_ScriptId, 0, 1, 0 )
	misIndex = GetMissionIndexByID(sceneId,selfId,x211901_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
end

--**********************************
--放弃
--**********************************
function x211901_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x211901_g_MissionId )
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x211901_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x211901_g_MissionComplete);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x211901_g_ScriptId,x211901_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211901_CheckSubmit( sceneId, selfId )
    misIndex = GetMissionIndexByID(sceneId,selfId,x211901_g_MissionId)	
	num = GetMissionParam(sceneId,selfId,misIndex,0)
	if num < 1 then
		return 0
	else
		return 1
	end
end

--**********************************
--提交（完成）
--**********************************
function x211901_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x211901_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = DelMission( sceneId, selfId, x211901_g_MissionId );
		if ret > 0 then
			MissionCom( sceneId, selfId, x211901_g_MissionId )
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x211901_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x211901_OnEnterArea( sceneId, selfId, areaId )
	if areaId ==2811  then
		misIndex=GetMissionIndexByID(sceneId,selfId,x211901_g_MissionId)		--取得任务在任务列表中的index
		num = GetMissionParam(sceneId,selfId,misIndex,0)				--根据index取得任务变量第一位的值
		if num < 1 then				--如果不满足任务完成得条件
			SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)		--任务变量第一位增加1
			BeginEvent(sceneId)										--显示提示信息
				strText = format("找到蝴蝶神的图腾%d/1", GetMissionParam(sceneId,selfId,misIndex,0) )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)						--将提示信息发出
		end
	end
end

--**********************************
--道具改变
--**********************************
function x211901_OnItemChanged( sceneId, selfId, itemdataId )
end
