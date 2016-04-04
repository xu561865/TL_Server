--探索地图任务
--侦查军情
--MisDescBegin
--脚本号
x210908_g_ScriptId = 210908

--上一个任务的ID
--g_MissionIdPre = 

--任务号
x210908_g_MissionId = 528

--任务归类
x210908_g_MissionKind = 29

--任务等级
x210908_g_MissionLevel = 25

--是否是精英任务
x210908_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况*******
--任务是否已经完成
x210908_g_IsMissionOkFail = 0		--变量的第0位


--*******************以上是动态显示***********

--任务文本描述
x210908_g_MissionName="侦查军情"
x210908_g_MissionInfo="雁北的辽军或许在酝酿新的攻势，你去雁北的战场上侦查一下敌人的情况，然后回来向我报告"
x210908_g_MissionTarget="到雁北古战场上去侦查敌情"
x210908_g_ContinueInfo="你已经侦查完了吗？"
x210908_g_MissionComplete="恭喜你侦查完了"

--奖励
x210908_g_MoneyBonus=908

--交任务目标npc
x210908_g_Name	="种世衡"

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210908_OnDefaultEvent( sceneId, selfId, targetId )

    --如果玩家完成过这个任务
    --if IsMissionHaveDone(sceneId,selfId,x210908_g_MissionId) > 0 then
    --	return
    	
    --如果已接此任务
    --else
    if IsHaveMission(sceneId,selfId,x210908_g_MissionId) > 0 then
    	--发送任务需求的信息
        BeginEvent(sceneId)
        AddText(sceneId,x210908_g_MissionName)
        AddText(sceneId,x210908_g_ContinueInfo)
        EndEvent( )
        bDone = x210908_CheckSubmit( sceneId, selfId )
        DispatchMissionDemandInfo(sceneId,selfId,targetId,x210908_g_ScriptId,x210908_g_MissionId,bDone)
    		
    --满足任务接收条件
    elseif x210908_CheckAccept(sceneId,selfId) > 0 then
    	--发送任务接受时显示的信息
        BeginEvent(sceneId)
			AddText(sceneId,x210908_g_MissionName)
			AddText(sceneId,x210908_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x210908_g_MissionTarget)
			AddText(sceneId,"#{M_SHOUHUO}")
			AddMoneyBonus( sceneId, x210908_g_MoneyBonus )
      	EndEvent( )
      	DispatchMissionInfo(sceneId,selfId,targetId,x210908_g_ScriptId,x210908_g_MissionId)
    end
end

--**********************************
--列举事件
--**********************************
function x210908_OnEnumerate( sceneId, selfId, targetId )
	
    if IsMissionHaveDone(sceneId,selfId,x210908_g_MissionId) > 0 then
    	return 
    elseif IsHaveMission(sceneId,selfId,x210908_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210908_g_Name then
			AddNumText(sceneId, x210908_g_ScriptId,x210908_g_MissionName)
		end
		--满足任务接收条件
		elseif x210908_CheckAccept(sceneId,selfId) > 0 then
		--if GetName(sceneId,targetId) ~= x210908_g_Name then      --这个任务是探索地图,所以发任务和交任务是同一个npc,以前送货不是同一个npc,因此不需要这个判断
			AddNumText(sceneId,x210908_g_ScriptId,x210908_g_MissionName);
		--end
	end
end

--**********************************
--检测触发条件
--**********************************
function x210908_CheckAccept( sceneId, selfId )
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
function x210908_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210908_g_MissionId, x210908_g_ScriptId, 0, 1, 0 )
	misIndex = GetMissionIndexByID(sceneId,selfId,x210908_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
end

--**********************************
--放弃
--**********************************
function x210908_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210908_g_MissionId )
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x210908_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x210908_g_MissionComplete);
    EndEvent(sceneId)

    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210908_g_ScriptId,x210908_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210908_CheckSubmit( sceneId, selfId )
		misIndex = GetMissionIndexByID(sceneId,selfId,x210908_g_MissionId)
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
function x210908_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x210908_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = DelMission( sceneId, selfId, x210908_g_MissionId );
		if ret > 0 then
			MissionCom( sceneId, selfId, x210908_g_MissionId )
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210908_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210908_OnEnterArea( sceneId, selfId, areaId )
		if areaId ==1911  then
			misIndex=GetMissionIndexByID(sceneId,selfId,x210908_g_MissionId)
			num = GetMissionParam(sceneId,selfId,misIndex,0)
			if num < 1 then
				SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
				BeginEvent(sceneId)
					strText = format("已经探索古战场%d/1", GetMissionParam(sceneId,selfId,misIndex,0) )
					AddText(sceneId,strText);
				EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)						--将提示信息发出
			end
		end
end

--**********************************
--道具改变
--**********************************
function x210908_OnItemChanged( sceneId, selfId, itemdataId )
end
