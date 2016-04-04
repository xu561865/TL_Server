--副本传送

--脚本号
x805001_g_scriptId =805001

x805001_g_copysceneName="血色修道院－任务（杀光怪）"

--任务号
x805001_g_missionId = 4001


x805001_g_missionName="副本:血色修道院"
x805001_g_missionText0="血色里面有怪，为百姓除掉一害！"
x805001_g_missionText1="杀死2只西北狼"
x805001_g_missionText2="你已经杀了2只西北狼吗？"
x805001_g_missionText3="恭喜你杀完了"

x805001_g_MoneyBonus=900

--**********************************
--入口函数
--**********************************
function x805001_OnDefaultEvent( sceneId, selfId, targetId )

    	--如果玩家完成过这个任务
    	if IsMissionHaveDone(sceneId,selfId,x805001_g_missionId) > 0 then
    		return
    	--如果已接此任务
    	else
		if IsHaveMission(sceneId,selfId,x805001_g_missionId) > 0 then
			--发送任务需求的信息
			BeginEvent(sceneId)
				AddText(sceneId,x805001_g_missionName)
				AddText(sceneId,x805001_g_missionText2)
			EndEvent( )
			bDone = x805001_CheckSubmit( sceneId, selfId )
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x805001_g_scriptId,x805001_g_missionId,bDone)
		--满足任务接收条件
		elseif x805001_CheckAccept(sceneId,selfId) > 0 then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x805001_g_missionName)
				AddText(sceneId,x805001_g_missionText0)
				AddText(sceneId,"目标")
				AddText(sceneId,x805001_g_missionText1)
				AddText(sceneId,"收获")
				AddMoneyBonus( sceneId, x805001_g_MoneyBonus )
			DispatchMissionInfo(sceneId,selfId,targetId,x805001_g_scriptId,x805001_g_missionId)
		end
	end
end

--**********************************
--副本事件
--**********************************
function x805001_OnCopySceneReady( sceneId, destsceneId )

	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId);--设置副本入口场景号

	leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId) ;	
	leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
	NewWorld( sceneId, leaderObjId, destsceneId, 11, 11 ) ;
end

--**********************************
--副本场景定时器事件
--**********************************
function x805001_OnCopySceneTimer( sceneId, nowTime )
	
	TickCount = LuaFnGetCopySceneData_Param(sceneId, 2) ;--取得已经执行的定时次数
	TickCount = TickCount+1 ;
	LuaFnSetCopySceneData_Param(sceneId, 2, TickCount);--设置新的定时器调用次数
	
	leaveFlag = LuaFnGetCopySceneData_Param(sceneId, 4) ;
	if leaveFlag == 1 then --需要离开
		leaveTickCount = LuaFnGetCopySceneData_Param(sceneId, 5) ;
		leaveTickCount = leaveTickCount+1 ;
		LuaFnSetCopySceneData_Param(sceneId, 5, leaveTickCount) ;
		if leaveTickCount == 10 then
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
			leaderguid  = LuaFnGetCopySceneData_TeamLeader(sceneId) ;	
			leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
			NewWorld( sceneId, leaderObjId, oldsceneId, 238, 52 ) ;
		elseif leaveTickCount<10 then
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
			leaderguid  = LuaFnGetCopySceneData_TeamLeader(sceneId) ;	
			leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
	  		BeginEvent(sceneId)
	  			strText = format("你将在%d秒后离开场景!", 10-leaveTickCount )
	  			AddText(sceneId,strText);
	  		EndEvent(sceneId)
	  		DispatchMissionTips(sceneId,leaderObjId)
		end
	elseif TickCount == 300 then --副本总时间限制到了, 第300次计时器激活

		--此处设置副本任务有时间限制的情况，当时间到后处理...
		DelMission( sceneId, selfId, x805001_g_missionId );--任务失败,删除之

		oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
		leaderguid  = LuaFnGetCopySceneData_TeamLeader(sceneId) ;	
		leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
		NewWorld( sceneId, leaderObjId, oldsceneId, 238, 52 ) ;
	end
end


--**********************************
--列举事件
--**********************************
function x805001_OnEnumerate( sceneId, selfId, targetId )

	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x805001_g_missionId) > 0 then
		return 
	--如果已接此任务
	else
		if IsHaveMission(sceneId,selfId,x805001_g_missionId) > 0 then
			AddNumText(sceneId,x805001_g_scriptId,x805001_g_missionName);
		--满足任务接收条件
		elseif x805001_CheckAccept(sceneId,selfId) > 0 then
			AddNumText(sceneId,x805001_g_scriptId,x805001_g_missionName);
		end
	end
end

--**********************************
--检测接受条件
--**********************************
function x805001_CheckAccept( sceneId, selfId )
	return 1
end

--**********************************
--接受
--**********************************
function x805001_OnAccept( sceneId, selfId )

	ret = AddMission( sceneId,selfId, x805001_g_missionId, x805001_g_scriptId,1, 0, 0 )
	if ret > 0 then
	end

	leaderguid=LuaFnObjId2Guid(sceneId,selfId)

	LuaFnSetSceneLoad_Map(sceneId, "taihu.nav"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好

	LuaFnSetSceneLoad_Monster(sceneId, "taihu_monster.ini");
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, 15000);
	LuaFnSetCopySceneData_Timer(sceneId, 1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, 999);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, 805001);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);--设置任务完成标志, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, 6, 0);--杀死的狼的数量


	LuaFnCreateCopyScene(); --初始化完成后调用创建副本函数

end

--**********************************
--放弃
--**********************************
function x805001_OnAbandon( sceneId, selfId )
end

--**********************************
--继续
--**********************************
function x805001_OnContinue( sceneId, selfId, targetId )
    BeginEvent(sceneId)
	AddText(sceneId,x805001_g_missionText3);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x805001_g_scriptId,x805001_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x805001_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x805001_g_missionId)
	num = GetMissionParam(sceneId,selfId,misIndex,0)
	if num < 1 then
		return 0
	else
		return 1
	end
end

--**********************************
--提交
--**********************************
function x805001_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	ret = x805001_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		ret = DelMission( sceneId, selfId, x805001_g_missionId );
		if ret > 0 then
			MissionCom( sceneId, selfId, x805001_g_missionId )
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x805001_OnKillObject( sceneId, selfId, objdataId ,objId)--参数意思：场景号、玩家objId、怪物表位置号、怪物objId

	if objdataId == 620 then

		killednumber = LuaFnGetCopySceneData_Param(sceneId, 6) ;--杀死狼的数量
		if killednumber<2 then

			killednumber = killednumber+1 ;
			LuaFnSetCopySceneData_Param(sceneId, 6, killednumber);--设置杀死的狼的数量

			num = LuaFnGetCopyScene_HumanCount(sceneId)--取得当前场景里的人数
			for i=0,num-1 do

				humanObjId = LuaFnGetCopyScene_HumanObjId(sceneId,i)--取得当前场景里人的objId
				
				misIndex = GetMissionIndexByID(sceneId,humanObjId,x805001_g_missionId)--取得任务数据索引值
				
				SetMissionByIndex(sceneId,humanObjId,misIndex,0,killednumber)--设置任务数据
		  		
				if killednumber>=2 then 
					BeginEvent(sceneId)
	  					strText = format("已杀死西北狼%d/2，任务完成，将在10秒后传送到入口位置", killednumber )
	  					AddText(sceneId,strText);
	  				EndEvent(sceneId)
				else
					BeginEvent(sceneId)
	  					strText = format("已杀死西北狼%d/2", killednumber )
	  					AddText(sceneId,strText);
	  				EndEvent(sceneId)
	  			end

				DispatchMissionTips(sceneId,humanObjId)
			end

			if killednumber>=2 then 
				LuaFnSetCopySceneData_Param(sceneId, 4, 1);--设置任务完成标志
			end
		end

		--misIndex = GetMissionIndexByID(sceneId,selfId,x805001_g_missionId)
		--num = GetMissionParam(sceneId,selfId,misIndex,0)
		--if num < 1 then
			--SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
	  		--BeginEvent(sceneId)
	  			--strText = format("已杀死西北狼%d/1, 任务完成，将在5秒后离开场景", GetMissionParam(sceneId,selfId,misIndex,0) )
	  			--AddText(sceneId,strText);
	  		--EndEvent(sceneId)
			--DispatchMissionTips(sceneId,selfId)
			--LuaFnSetCopySceneData_Param(sceneId, 4, 1);--设置任务完成标志
		--end
	end
end

--**********************************
--进入区域事件
--**********************************
function x805001_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x805001_OnItemChanged( sceneId, selfId, itemdataId )
end







