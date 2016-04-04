--大理派师门任务事件脚本
--任务

--脚本号
x224000_g_ScriptId = 220400

--任务号
x224000_g_MissionId = 1064

--任务目标npc
x224000_g_Name	="本凡" 

--任务等级
x224000_g_MissionLevel = 1

--任务文本描述
x224000_g_MissionName="私门"
x224000_g_MissionInfo="我有很多任务，你要帮我哦"  --任务描述
x224000_g_MissionTarget="这些任务够你做的了"		--任务目标
x224000_g_ContinueInfo="完成了吗？"		--未完成任务的npc对话
x224000_g_MissionComplete="多谢啊"					--完成任务npc说话的话

--任务奖励
x224000_g_MoneyBonus=100
x224000_g_ItemBonus={{id=30002002,num=1}}

--角色Mission变量说明
--0号：未用
--1号：未用
--2号：未用
--3号：未用
--4号：未用
--5号：未用
--6号：未用
--7号：未用

--**********************************
--任务入口函数
--**********************************
function x224000_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	
	if IsHaveMission(sceneId,selfId,x224000_g_MissionId) > 0 then --如果已接此任务
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x224000_g_MissionName)
			AddText(sceneId,x224000_g_ContinueInfo)
		EndEvent( )
		bDone = x224000_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x224000_g_ScriptId,x224000_g_MissionId,bDone)
	
	elseif x224000_CheckAccept(sceneId,selfId) > 0 then --满足任务接收条件
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x224000_g_MissionName)
			AddText(sceneId,x224000_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x224000_g_MissionTarget)
			AddMoneyBonus( sceneId, x224000_g_MoneyBonus )
			for i, item in x224000_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x224000_g_ScriptId,x224000_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x224000_OnEnumerate( sceneId, selfId, targetId )

    --如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x224000_g_MissionId) > 0 then
		return 
	end

    if IsHaveMission(sceneId,selfId,x224000_g_MissionId) > 0 then  --如果已接此任务
		AddNumText(sceneId,x224000_g_ScriptId,x224000_g_MissionName);
    elseif x224000_CheckAccept(sceneId,selfId) > 0 then		--满足任务接收条件
		AddNumText(sceneId,x224000_g_ScriptId,x224000_g_MissionName);
    end
end

--**********************************
--检测接受条件
--**********************************
function x224000_CheckAccept( sceneId, selfId )
	--接收条件
	if GetLevel( sceneId, selfId ) >= x224000_g_MissionLevel then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x224000_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x224000_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x224000_g_MissionId )
end

--**********************************
--继续
--**********************************
function x224000_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x224000_g_MissionName)
		AddText(sceneId,x224000_g_MissionComplete)
		AddMoneyBonus( sceneId, x224000_g_MoneyBonus )
		for i, item in x224000_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x224000_g_ScriptId,x224000_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x224000_CheckSubmit( sceneId, selfId )
	return 0
end

--**********************************
--提交
--**********************************
function x224000_OnSubmit( sceneId, selfId, targetId,selectRadioId )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x224000_OnKillObject( sceneId, selfId, objdataId, objId )
end

--**********************************
--进入区域事件
--**********************************
function x224000_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x224000_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--玩家提交的物品及宠物
--**********************************
function x224000_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
end

