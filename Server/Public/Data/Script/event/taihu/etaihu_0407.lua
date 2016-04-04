--太湖 借刀杀人2
--MisDescBegin
--脚本号
x210407_g_ScriptId = 210407

--任务号
x210407_g_MissionId = 477

--任务目标npc
x210407_g_Name	="呼延庆"

--任务归类
x210407_g_MissionKind = 15

--任务等级
x210407_g_MissionLevel = 10

--是否是精英任务
x210407_g_IfMissionElite = 0


--任务是否已经完成
x210407_g_IsMissionOkFail = 0		--变量的第0位

--任务需要杀死的怪
x210407_g_DemandKill ={{id=1615,num=10}}		--变量第1位


--任务文本描述
x210407_g_MissionName="借刀杀人"
x210407_g_MissionInfo="杀死10名太湖水贼"
x210407_g_MissionTarget="杀死10名太湖水贼"
x210407_g_ContinueInfo="你已经杀了10太湖水贼？没有就继续吧"
x210407_g_MissionComplete="恭喜你杀完了"

--任务奖励
x210407_g_MoneyBonus=10200
x210407_g_Exp = 3000
x210407_g_ItemBonus={{id=30002001,num=1}}
x210407_g_DemandTrueKill ={{name="太湖水贼",num=10}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210407_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x210407_g_MissionId) > 0 then
	--	return
	--end
		--如果已接此任务
		if IsHaveMission(sceneId,selfId,x210407_g_MissionId) > 0 then
			--发送任务需求的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210407_g_MissionName)
				AddText(sceneId,x210407_g_ContinueInfo)
			--for i, item in g_DemandItem do
			--	AddItemDemand( sceneId, item.id, item.num )
			--end
			EndEvent( )
			bDone = x210407_CheckSubmit( sceneId, selfId )
	DispatchMissionDemandInfo(sceneId,selfId,targetId,x210407_g_ScriptId,x210407_g_MissionId,bDone)
			--满足任务接收条件
		elseif x210407_CheckAccept(sceneId,selfId) > 0 then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210407_g_MissionName)
				AddText(sceneId,x210407_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210407_g_MissionTarget)
				AddMoneyBonus( sceneId, x210407_g_MoneyBonus )
				for i, item in x210407_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
			
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210407_g_ScriptId,x210407_g_MissionId)
		end
	end

--**********************************
--列举事件
--**********************************
function x210407_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210407_g_MissionId) > 0 then
		return 
	end
		--如果已接此任务
    --else
		if IsHaveMission(sceneId,selfId,x210407_g_MissionId) > 0 then
			AddNumText(sceneId,x210407_g_ScriptId,x210407_g_MissionName);
			--满足任务接收条件
		elseif x210407_CheckAccept(sceneId,selfId) > 0 then
			AddNumText(sceneId,x210407_g_ScriptId,x210407_g_MissionName);
		end
	end

--**********************************
--检测接受条件
--**********************************
function x210407_CheckAccept( sceneId, selfId )
	--需要10级才能接
	if GetLevel( sceneId, selfId ) >= 10 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210407_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210407_g_MissionId, x210407_g_ScriptId, 1, 0, 0 )	--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x210407_g_MissionId)	--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)	--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)	--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x210407_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210407_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210407_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	BeginEvent(sceneId)
		AddText(sceneId,x210407_g_MissionName)
		AddText(sceneId,x210407_g_MissionComplete)
		AddMoneyBonus( sceneId, x210407_g_MoneyBonus )
		for i, item in x210407_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end		
    EndEvent( )
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x210407_g_ScriptId,x210407_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210407_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x210407_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,1)
    if num == x210407_g_DemandTrueKill[1].num then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210407_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x210407_CheckSubmit( sceneId, selfId, selectRadioId ) then
    		BeginAddItem(sceneId)
			for i, item in x210407_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
			
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then		
		
			AddExp(sceneId,selfId,x210407_g_Exp)
			AddMoney(sceneId,selfId,x210407_g_MoneyBonus );
			
			ret = DelMission( sceneId, selfId, x210407_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId, selfId, x210407_g_MissionId )
					AddItemListToHuman(sceneId,selfId)
			end
		else
		--任务奖励没有加成功
			BeginEvent(sceneId)
				strText = "背包已满,无法完成任务"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210407_OnKillObject( sceneId, selfId, objdataId ,objId)
 if GetName(sceneId,objId) == x210407_g_DemandTrueKill[1].name	  then
		misIndex = GetMissionIndexByID(sceneId,selfId,x210407_g_MissionId)
		num = GetMissionParam(sceneId,selfId,misIndex,1)
	  if num < x210407_g_DemandTrueKill[1].num then
		--把任务完成标志设置为1
		if num == x210407_g_DemandTrueKill[1].num - 1 then
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		end
		--设置打怪数量+1
	    SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
	  	BeginEvent(sceneId)
			strText = format("已杀死太湖水贼%d/10", GetMissionParam(sceneId,selfId,misIndex,1) )
			AddText(sceneId,strText);
	  	EndEvent(sceneId)
	  	DispatchMissionTips(sceneId,selfId)
	  end
	end
end

--**********************************
--进入区域事件
--**********************************
function x210407_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210407_OnItemChanged( sceneId, selfId, itemdataId )
end
