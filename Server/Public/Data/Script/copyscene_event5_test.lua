--夜访马夫人
--雁北

--脚本号
x805005_g_scriptId = 805005
--任务号
x805005_g_missionId = 4013


local  PlayerName="aaa"
--任务名
x805005_g_missionName="夜访马夫人"
x805005_g_missionText_0="夜访马夫人,护送任务"
x805005_g_missionText_1="护送段正淳"

x805005_g_missionText_2="你是谁？到我谷里干什么？"

x805005_g_MoneyBonus=80000
x805005_g_ItemBonus={{id=10101007,num=1}}

--**********************************
--任务入口函数
--**********************************
function x805005_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if( IsHaveMission(sceneId,selfId,x805005_g_missionId) > 0)  then
		if x805005_CheckSubmit(sceneId,selfId) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId,x805005_g_missionName)
				AddMoneyBonus( sceneId, x805005_g_MoneyBonus )
			EndEvent()
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x805005_g_scriptId,x805005_g_missionId,1)
		else
			BeginEvent(sceneId)
				AddText(sceneId,x805005_g_missionName)
				AddText(sceneId,"无名之辈")
			EndEvent( )
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x805005_g_scriptId,x805005_g_missionId,0)
		end

	--满足任务接收条件
	elseif x805005_CheckAccept(sceneId,selfId) > 0 then
		name = GetName(sceneId,selfId)
		playname = format("玩家的名字是:%s\n",name)
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x805005_g_missionName)
			AddText(sceneId,x805005_g_missionText_0)
			AddText(sceneId,playname)
			AddText(sceneId,x805005_g_missionText_1)
			AddMoneyBonus( sceneId, x805005_g_MoneyBonus )
			for i, item in x805005_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x805005_g_scriptId,x805005_g_missionId)
	end
end

--**********************************
--列举事件
--**********************************
function x805005_OnEnumerate( sceneId, selfId, targetId )
	if IsHaveMission(sceneId,selfId,x805005_g_missionId) > 0 then
		if GetName(sceneId,targetId) == g_name then
			AddNumText(sceneId, x805005_g_scriptId,x805005_g_missionName);
		end
	--满足任务接收条件
	elseif x805005_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x805005_g_scriptId,x805005_g_missionName)
	end
end

--**********************************
--检测接受条件
--**********************************
function x805005_CheckAccept( sceneId, selfId )
	return 1	
end

--**********************************
--接受
--**********************************
function x805005_OnAccept( sceneId, selfId ,targetId)
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x805005_g_missionId, x805005_g_scriptId, 0, 0, 0 )
	timerIndex =SetTimer(sceneId,selfId,x805005_g_scriptId,"OnTimer",1000)
	misIndex = GetMissionIndexByID(sceneId,selfId,x805005_g_missionId)
	SetPatrolId(sceneId,targetId,0)

	LuaFnSetCopySceneData_Param(sceneId, 0, targetId);--将护送目标的ObjID保存到临时场景数据里

	--生成一个npc
	npcobjid = LuaFnCreateMonster( sceneId, 16, 238,54, 3,2, -1 ) ;
	LuaFnSetCopySceneData_Param(sceneId, 1, npcobjid);

end

function x805005_OnTimer(sceneId,selfId,timeIndex)
	x805005_g_sdhyTargetId = LuaFnGetCopySceneData_Param(sceneId, 0) --从场景临时数据里取到护送目标的ObjID
	if LuaFnIsObjValid(sceneId,selfId)==1 then--此Obj存在
		if IsInDist(sceneId,selfId,x805005_g_sdhyTargetId,10)<0 --距离过远
			or LuaFnIsCharacterLiving(sceneId,x805005_g_sdhyTargetId)==0 --护送目标死了
			or LuaFnIsCharacterLiving(sceneId,selfId)==0 then --自己死了

			DelMission(sceneId,selfId,x805005_g_missionId)
	  		BeginEvent(sceneId)
	  			strText = format("很遗憾，任务失败!" )
	  			AddText(sceneId,strText);
	  		EndEvent(sceneId)
	  		DispatchMissionTips(sceneId,selfId)

			SetPatrolId(sceneId,x805005_g_sdhyTargetId,-1) --将护送目标的巡逻取消
			StopTimer(sceneId,timeIndex)  --停止计时器
			SetPos(sceneId,x805005_g_sdhyTargetId,239,55)  --将护送目标设置回到原来的地方

			--删除创建出来的npc
			npcobjid = LuaFnGetCopySceneData_Param(sceneId, 1)
			LuaFnDeleteMonster( sceneId, npcobjid ) ;
		end

		x,z = GetWorldPos(sceneId,x805005_g_sdhyTargetId) ;
		if x>200 and x<210 and z>55 and z<65 then --到达目的，任务完成
	  		BeginEvent(sceneId)
	  			strText = format("恭喜，任务完成!" )
	  			AddText(sceneId,strText);
	  		EndEvent(sceneId)
	  		DispatchMissionTips(sceneId,selfId)

			StopTimer(sceneId,timeIndex)
			SetPatrolId(sceneId,x805005_g_sdhyTargetId,-1)
			SetPos(sceneId,x805005_g_sdhyTargetId,239,55)

			--删除创建出来的npc
			npcobjid = LuaFnGetCopySceneData_Param(sceneId, 1)
			LuaFnDeleteMonster( sceneId, npcobjid ) ;
		end
	else--如果这个obj不存在（比如掉线了），则需要清除这个计时器
		StopTimer(sceneId,timeIndex)
		SetPatrolId(sceneId,x805005_g_sdhyTargetId,-1)
		SetPos(sceneId,x805005_g_sdhyTargetId,239,55)

		--删除创建出来的npc
		npcobjid = LuaFnGetCopySceneData_Param(sceneId, 1)
		LuaFnDeleteMonster( sceneId, npcobjid ) ;
	end
end

--**********************************
--放弃
--**********************************
function x805005_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x805005_g_missionId )
end

--**********************************
--继续
--**********************************
function x805005_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	BeginEvent(sceneId)
		AddText(sceneId,x805005_g_missionName)
		AddText(sceneId,x805005_g_missionText_2)
		AddMoneyBonus( sceneId, x805005_g_MoneyBonus )
		for i, item in x805005_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
	EndEvent( )
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x805005_g_scriptId,x805005_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x805005_CheckSubmit( sceneId, 	selfId )
	if GetTitle(sceneId,selfId,3) == 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x805005_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x805005_CheckSubmit( sceneId, selfId ) then
	BeginAddItem(sceneId)
		for i, item in x805005_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x805005_g_MoneyBonus );
			DelItem(sceneId,selfId,20001003,1)
			DelMission( sceneId,selfId,  x805005_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x805005_g_missionId )
			CallScriptFunction( 201001, "OnDefaultEvent",sceneId, selfId, targetId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x805005_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x805005_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x805005_OnItemChanged( sceneId, selfId, itemdataId )
end








