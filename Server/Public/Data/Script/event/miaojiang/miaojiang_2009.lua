--勇闯寒玉塔
--苗疆
--MisDescBegin
--脚本号
x212009_g_ScriptId = 212009

--上一个任务的ID
--g_MissionIdPre =

--任务号
x212009_g_MissionId = 639

--任务目标npc
x212009_g_Name = "阿雨"

--任务归类
x212009_g_MissionKind = 40

--任务等级
x212009_g_MissionLevel = 79

--是否是精英任务
x212009_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x212009_g_IsMissionOkFail = 0		--变量的第0位

--以上是动态**************************************************************

--任务名
x212009_g_MissionName="勇闯寒玉塔"
x212009_g_MissionInfo="带我去寒玉塔"
x212009_g_MissionTarget="护送阿雨去寒玉塔"
x212009_g_MissionComplete="太感谢你了"

x212009_g_MoneyBonus=80000
x212009_g_ItemBonus={{id=10101001,num=1}}

x212009_g_PosX=184
x212009_g_PosZ=269

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x212009_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x212009_g_MissionId) > 0 then
		return
	elseif( IsHaveMission(sceneId,selfId,x212009_g_MissionId) > 0)  then	--如果玩家已经领取了任务
		if GetName(sceneId,targetId) ~= x212009_g_Name then					--点击的npc不是目标npc
			if x212009_CheckSubmit(sceneId,selfId) == 1 then				--如果可以完成任务
				BeginEvent(sceneId)
					AddText(sceneId,x212009_g_MissionName)
					AddMoneyBonus( sceneId, x212009_g_MoneyBonus )
				EndEvent()
				DispatchMissionDemandInfo(sceneId,selfId,targetId,x212009_g_ScriptId,x212009_g_MissionId,1)
			else
				BeginEvent(sceneId)
					AddText(sceneId,x212009_g_MissionName)
					AddText(sceneId,"无名之辈")
				EndEvent( )
				DispatchMissionDemandInfo(sceneId,selfId,targetId,x212009_g_ScriptId,x212009_g_MissionId,0)
			end
		end
	--满足任务接收条件
	elseif x212009_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x212009_g_Name then
			name = GetName(sceneId,selfId)
			--playname = format("玩家的名字是:%s",name)
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x212009_g_MissionName)
				AddText(sceneId,x212009_g_MissionInfo)
				--AddText(sceneId,playname)
				AddText(sceneId,x212009_g_MissionTarget)
				AddMoneyBonus( sceneId, x212009_g_MoneyBonus )
				for i, item in x212009_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x212009_g_ScriptId,x212009_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x212009_OnEnumerate( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x212009_g_MissionId) > 0 then		
		return
	elseif IsHaveMission(sceneId,selfId,x212009_g_MissionId) > 0 then		
		if GetName(sceneId,targetId) ~= x212009_g_Name then
			AddNumText(sceneId, x212009_g_ScriptId,x212009_g_MissionName);
		end
	--满足任务接收条件
	elseif x212009_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x212009_g_Name then
			AddNumText(sceneId,x212009_g_ScriptId,x212009_g_MissionName)
		end
	end
end

--**********************************
--检测接受条件
--**********************************
function x212009_CheckAccept( sceneId, selfId )
	return 1	
end

--**********************************
--接受
--**********************************
function x212009_OnAccept( sceneId, selfId ,targetId)
	--加入任务到玩家列表	
	AddMission( sceneId,selfId, x212009_g_MissionId, x212009_g_ScriptId, 0, 0, 0 )
	timerIndex =SetTimer(sceneId,selfId,x212009_g_ScriptId,"OnTimer",1000)
	misIndex = GetMissionIndexByID(sceneId,selfId,x212009_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)		--根据序列号把任务变量的第0位置0 (任务完成情况)
	SetPatrolId(sceneId,targetId,0)
	LuaFnSetCopySceneData_Param(sceneId, 0, targetId);--将护送目标的ObjID保存到临时场景数据里
end

--**********************************
--定时器事件
--**********************************
function x212009_OnTimer(sceneId,selfId,timeIndex)
	TargetId = LuaFnGetCopySceneData_Param(sceneId, 0) --从场景临时数据里取到护送目标的ObjID
	if LuaFnIsObjValid(sceneId,selfId)==1 then--此Obj存在
		if IsInDist(sceneId,selfId,TargetId,10)<1 --距离过远
			or LuaFnIsCharacterLiving(sceneId,TargetId)==0 --护送目标死了
			or LuaFnIsCharacterLiving(sceneId,selfId)==0 then --自己死了

			DelMission(sceneId,selfId,x212009_g_MissionId)
	  		BeginEvent(sceneId)
	  			strText = format("任务失败!!!!!!!" )
	  			AddText(sceneId,strText);
	  		EndEvent(sceneId)
	  		DispatchMissionTips(sceneId,selfId)

			SetPatrolId(sceneId,TargetId,-1) --将护送目标的巡逻取消
			StopTimer(sceneId,timeIndex)  --停止计时器
			SetPos(sceneId,TargetId,x212009_g_PosX,x212009_g_PosZ)  --将护送目标设置回到原来的地方
		end

		x,z = GetWorldPos(sceneId,TargetId) ;
		if x>88 and x<93 and z>259 and z<262 then --到达目的，任务完成
	  		BeginEvent(sceneId)
	  			strText = format("任务完成!" )
	  			AddText(sceneId,strText);
	  		EndEvent(sceneId)
	  		DispatchMissionTips(sceneId,selfId)

			misIndex = GetMissionIndexByID(sceneId,selfId,x212009_g_MissionId)
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)		--根据序列号把任务变量的第0位置1 (任务完成)
			StopTimer(sceneId,timeIndex)
			SetPatrolId(sceneId,TargetId,-1)
			SetPos(sceneId,TargetId,x212009_g_PosX,x212009_g_PosZ)
		end
	else--如果这个obj不存在（比如掉线了），则需要清除这个计时器
		StopTimer(sceneId,timeIndex)
		SetPatrolId(sceneId,TargetId,-1)
		SetPos(sceneId,TargetId,x212009_g_PosX,x212009_g_PosZ)  --将护送目标设置回到原来的地方
		SetMissionByIndex(sceneId,selfId,misIndex,0,2)		--根据序列号把任务变量的第0位置2 (任务失败)
	end
end

--**********************************
--放弃
--**********************************
function x212009_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x212009_g_MissionId )
end

--**********************************
--继续
--**********************************
function x212009_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	BeginEvent(sceneId)
		AddText(sceneId,x212009_g_MissionName)
		AddText(sceneId,x212009_g_MissionComplete)
		AddMoneyBonus( sceneId, x212009_g_MoneyBonus )
		for i, item in x212009_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
	EndEvent( )
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x212009_g_ScriptId,x212009_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x212009_CheckSubmit( sceneId, 	selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x212009_g_MissionId)
	num = GetMissionParam(sceneId,selfId,misIndex,0)
	if num == 1 then
		return 1
	else
		return 0
	end
	--if GetTitle(sceneId,selfId,3) == 0 then
	--	return 1
	--end
	--return 0
end

--**********************************
--提交
--**********************************
function x212009_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x212009_CheckSubmit( sceneId, selfId ) then
	BeginAddItem(sceneId)
		for i, item in x212009_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x212009_g_MoneyBonus );
			--DelItem(sceneId,selfId,20001003,1)
			DelMission( sceneId,selfId,  x212009_g_MissionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x212009_g_MissionId )
			AddItemListToHuman(sceneId,selfId)
		else
		--任务奖励没有加成功
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x212009_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x212009_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x212009_OnItemChanged( sceneId, selfId, itemdataId )
end
