--副本任务
--水牢

--************************************************************************
--MisDescBegin

--脚本号
x231000_g_ScriptId = 231000

--副本名称
x231000_g_CopySceneName="水牢"

--任务号
x231000_g_MissionId = 4012

--上一个任务的ID
x231000_g_MissionIdPre = 4011

--目标NPC
x231000_g_Name = "杨铮"

--是否是精英任务
x231000_g_IfMissionElite = 1

--任务等级
x231000_g_MissionLevel = 10

--任务归类
x231000_g_MissionKind = 1

--********下面几项是动态显示的内容，用于在任务列表中动态显示任务情况******
--循环任务的数据索引，里面存着已做的环数 MD_SHUILAO_HUAN
--任务是否已经完成
x231000_g_IsMissionOkFail = 0		--变量的第0位

--g_MissionRound = 
--**********************************以上是动态****************************

--任务文本描述
x231000_g_MissionName="水牢"
x231000_g_MissionInfo="杀死全部怪物，一个不留！"  --任务描述
x231000_g_MissionTarget="杀死全部怪物"	--任务目标
x231000_g_ContinueInfo="你要继续努力啊！"	--未完成任务的npc对话
x231000_g_MissionComplete="谢谢啊，俺们终于敢出门了"	--完成任务npc说话的话


--任务奖励
x231000_g_MoneyBonus=9999

--MisDescEnd
--************************************************************************

--角色Mission变量说明
x231000_g_Param_huan		=0	--0号：已经完成的环数，在接收任务时候赋值
x231000_g_Param_ok			=1	--1号：当前任务是否完成(0未完成；1完成)
x231000_g_Param_sceneid		=2	--2号：当前副本任务的场景号
x231000_g_Param_teamid		=3	--3号：接副本任务时候的队伍号
x231000_g_Param_killcount	=4	--4号：杀死任务怪的数量
x231000_g_Param_time		=5	--5号：完成副本所用时间(单位：秒)
--6号：未用
--7号：未用

x231000_g_CopySceneType=FUBEN_SHUILAO	--副本类型，定义在ScriptGlobal.lua里面
x231000_g_LimitMembers=1			--可以进副本的最小队伍人数
x231000_g_TickTime=5				--回调脚本的时钟时间（单位：秒/次）
x231000_g_LimitTotalHoldTime=360	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败
x231000_g_LimitTimeSuccess=500		--副本时间限制（单位：次数），如果此时间到了，任务完成
x231000_g_CloseTick=6				--副本关闭前倒计时（单位：次数）
x231000_g_NoUserTime=300			--副本中没有人后可以继续保存的时间（单位：秒）
x231000_g_DeadTrans=1				--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x231000_g_Fuben_X=64				--进入副本的位置X
x231000_g_Fuben_Z=64				--进入副本的位置Z
x231000_g_Back_X=234				--源场景位置X
x231000_g_Back_Z=69					--源场景位置Z
x231000_g_NeedMonsterGroupID=1		--需要杀死的Boss的GroupID
x231000_g_TotalNeedKillBoss=10		--需要杀死Boss数量

--**********************************
--任务入口函数
--**********************************
function x231000_OnDefaultEvent( sceneId, selfId, targetId )
	if( IsHaveMission(sceneId,selfId,x231000_g_MissionId) > 0)  then	--如果玩家已经接了这个任务
		misIndex = GetMissionIndexByID(sceneId,selfId,x231000_g_MissionId)
		bDone = x231000_CheckSubmit( sceneId, selfId )
		if bDone==0 then						--任务未完成
			BeginEvent(sceneId)
				AddText(sceneId,x231000_g_MissionName)
				AddText(sceneId,"准备好了吗！")
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x231000_g_ScriptId,x231000_g_MissionId)
		elseif bDone==1 then					--任务已经完成
			BeginEvent(sceneId)
				AddText(sceneId,x231000_g_MissionName)
				AddText(sceneId,x231000_g_MissionComplete)
				AddText(sceneId,"你将得到：")
				AddMoneyBonus(sceneId,x231000_g_MoneyBonus)
			EndEvent( )
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x231000_g_ScriptId,x231000_g_MissionId,bDone)
		end
    elseif x231000_CheckAccept(sceneId,selfId) > 0 then		--没有任务，满足任务接收条件
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x231000_g_MissionName)
			AddText(sceneId,x231000_g_MissionInfo)
			AddText(sceneId,"任务目标：")
			AddText(sceneId,x231000_g_MissionTarget)
			AddText(sceneId,"你将得到：")
			AddMoneyBonus(sceneId,x231000_g_MoneyBonus)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x231000_g_ScriptId,x231000_g_MissionId)
    end
end

--**********************************
--列举事件
--**********************************
function x231000_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x231000_g_MissionId) > 0 then
		AddNumText(sceneId, x231000_g_ScriptId,x231000_g_MissionName);
	--满足任务接收条件
    elseif x231000_CheckAccept(sceneId,selfId) > 0 then
		if	IsHaveMission(sceneId,selfId,4011) > 0		then		
			misIndex = GetMissionIndexByID(sceneId,selfId,4011)
			if	GetMissionParam( sceneId, selfId, misIndex, 6)	== 1  then
				AddNumText(sceneId,x231000_g_ScriptId,x231000_g_MissionName);
			end
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x231000_CheckTeamLeader( sceneId, selfId )
	if	GetTeamId( sceneId, selfId)<0	then	--判断是否有队伍
		BeginEvent(sceneId)
	  		AddText(sceneId,"你需要加入一支队伍。");
	  	EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return	0
	end
	--取得玩家附近的队友数量（包括自己）
	local	nearteammembercount = GetNearTeamCount( sceneId, selfId) 
	
	if	nearteammembercount<x231000_g_LimitMembers	then
		BeginEvent(sceneId)
	  		AddText(sceneId,"你的队伍人数不足。");
	  	EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return	 0
	end
	
	if	LuaFnIsTeamLeader( sceneId, selfId)==0	then	--只有队长才能接任务
		BeginEvent(sceneId)
	  		AddText(sceneId,"你不是队长。");
	  	EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return	 0
	end
	
	return nearteammembercount
end

--**********************************
--检测接受条件
--**********************************
function x231000_CheckAccept( sceneId, selfId )
	if	GetTeamId( sceneId, selfId)<0	then	--判断是否有队伍
		BeginEvent(sceneId)
	  		AddText(sceneId,"你需要加入一支队伍。");
	  	EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return	0
	end
	
	--取得玩家附近的队友数量（包括自己）
	local	nearteammembercount = GetNearTeamCount( sceneId, selfId) 

	if	nearteammembercount<x231000_g_LimitMembers	then
		BeginEvent(sceneId)
	  		AddText(sceneId,"你的队伍人数不足。");
	  	EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return	 0
	end
	
	if	LuaFnIsTeamLeader( sceneId, selfId)==0	then	--只有队长才能接任务
		BeginEvent(sceneId)
	  		AddText(sceneId,"你不是队长。");
	  	EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return	 0
	end
	
	--检测小队中是否有人任务记录已满, 队友是否已经接过此任务
	local mems = {}
	for	i=0,nearteammembercount-1 do
		mems[i] = GetNearTeamMember(sceneId, selfId, i)
		if GetMissionCount( sceneId, mems[i]) >= 20 then	--队友身上任务数量是否达到上限20个
			BeginEvent(sceneId)
				AddText(sceneId,"队伍中有人的任务记录已满。");
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return 0
		elseif IsHaveMission(sceneId,mems[i],x231000_g_MissionId)>0 then
			--队友是否已经接过此任务或者另外一个任务
			BeginEvent(sceneId)
				AddText(sceneId,"队伍中有人已经接了此任务。");
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return 0
		end
	end
	
	return	1
end

--**********************************
--接受
--**********************************
function x231000_OnAccept( sceneId, selfId )
	
	local teamid = GetTeamId( sceneId, selfId)
	
	if( IsHaveMission(sceneId,selfId,x231000_g_MissionId) > 0)  then	--已经有任务的
		misIndex = GetMissionIndexByID(sceneId,selfId,x231000_g_MissionId)
		copysceneid = GetMissionParam( sceneId, selfId, misIndex, x231000_g_Param_sceneid)
		saveteamid = GetMissionParam( sceneId, selfId, misIndex, x231000_g_Param_teamid)
		
		if copysceneid>=0 and teamid==saveteamid then --进过副本
			--将自己传送到副本场景
			--NewWorld( sceneId, selfId, copysceneid, x231000_g_Fuben_X, x231000_g_Fuben_Z) ;
		else
			BeginEvent(sceneId)
				AddText(sceneId,"条件不符！");
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	else
		--加入任务到玩家列表
		if x231000_CheckAccept(sceneId,selfId) <= 0 then	--判断接收条件
			return 0
		end

		--取得玩家附近的队友数量（包括自己）
		local	nearteammembercount = GetNearTeamCount( sceneId, selfId) 
		local mems = {}

		for	i=0,nearteammembercount-1 do
			mems[i] = GetNearTeamMember(sceneId, selfId, i)
			--给每个队伍成员加入任务
			AddMission( sceneId, mems[i], x231000_g_MissionId, x231000_g_ScriptId, 1, 0, 0 )
			
			misIndex = GetMissionIndexByID( sceneId, mems[i], x231000_g_MissionId )
			
			--local huan = GetMissionData(sceneId,selfId,g_MissionRound)
			
			--将任务的第0号数据设置为已经完成的
			--SetMissionByIndex(sceneId,mems[i],misIndex,x231000_g_Param_huan,huan)
			
			--将任务的第1号数据设置为0,表示未完成的任务
			SetMissionByIndex(sceneId,mems[i],misIndex,x231000_g_Param_ok,0)
			
			--将任务的第2号数据设置为-1, 用于保存副本的场景号
			SetMissionByIndex(sceneId,mems[i],misIndex,x231000_g_Param_sceneid,-1)

			--将任务的第3号数据队伍号
			SetMissionByIndex(sceneId,mems[i],misIndex,x231000_g_Param_teamid,teamid)
		end
		
		x231000_MakeCopyScene( sceneId, selfId, nearteammembercount ) ;
	end
end

--**********************************
--放弃
--**********************************
function x231000_OnAbandon( sceneId, selfId )

	misIndex = GetMissionIndexByID(sceneId,selfId,x231000_g_MissionId)
	local copyscene = GetMissionParam( sceneId, selfId, misIndex, x231000_g_Param_sceneid)
	
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x231000_g_MissionId )
	
	if sceneId==copyscene then --如果在副本里删除任务，则直接传送回
		BeginEvent(sceneId)
			AddText(sceneId,"任务失败！");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
		
		NewWorld( sceneId, selfId, oldsceneId, x231000_g_Back_X, x231000_g_Back_Z )
	end
end

--**********************************
--创建副本
--**********************************
function x231000_MakeCopyScene( sceneId, selfId, nearmembercount )

	local mems = {}
	mylevel = 0 
	for	i=0,nearmembercount-1 do
		mems[i] = GetNearTeamMember(sceneId, selfId, i)
		mylevel = mylevel+GetLevel(sceneId,mems[i])
	end
	mylevel = mylevel/nearmembercount
	
	leaderguid=LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "shuilao.nav"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x231000_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x231000_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, x231000_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, x231000_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, 6, GetTeamId(sceneId,selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, 7, 0) ;--杀死Boss的数量
	
	if	mylevel<=10	 then
		LuaFnSetSceneLoad_Monster(sceneId, "shuilao_monster_10.ini")
	elseif	mylevel<=15	 then
		LuaFnSetSceneLoad_Monster(sceneId, "shuilao_monster_15.ini")
	elseif	mylevel<=20	 then
		LuaFnSetSceneLoad_Monster(sceneId, "shuilao_monster_20.ini")
	elseif	mylevel<=25	 then
		LuaFnSetSceneLoad_Monster(sceneId, "shuilao_monster_25.ini")
	elseif	mylevel<=30	 then
		LuaFnSetSceneLoad_Monster(sceneId, "shuilao_monster_30.ini")
	elseif	mylevel<=35	 then
		LuaFnSetSceneLoad_Monster(sceneId, "shuilao_monster_35.ini")
	elseif	mylevel<=40	 then
		LuaFnSetSceneLoad_Monster(sceneId, "shuilao_monster_40.ini")
	elseif	mylevel<=45	 then
		LuaFnSetSceneLoad_Monster(sceneId, "shuilao_monster_45.ini")
	else
		LuaFnSetSceneLoad_Monster(sceneId, "shuilao_monster_50.ini")
	end	
	

	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
	BeginEvent(sceneId)
		if bRetSceneID>0 then
			AddText(sceneId,"副本创建成功！");
		else
			AddText(sceneId,"副本创建失败！");
		end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
end

--**********************************
--继续
--**********************************
function x231000_OnContinue( sceneId, selfId, targetId )

	misIndex = GetMissionIndexByID(sceneId,selfId,x231000_g_MissionId)
	if	GetMissionParam( sceneId, selfId, misIndex, x231000_g_Param_sceneid)>=1	then
		DispatchMissionContinueInfo(sceneId, selfId, targetId, x231000_g_ScriptId, x231000_g_MissionId)
	end

end

--**********************************
--检测是否可以提交
--**********************************
function x231000_CheckSubmit( sceneId, selfId )
--判断任务是否已经完成
	misIndex = GetMissionIndexByID(sceneId,selfId,x231000_g_MissionId)
	if	GetMissionParam( sceneId, selfId, misIndex, x231000_g_Param_ok)>=1 then 
		return	1
	else
		return	0
	end
end

--**********************************
--提交
--**********************************
function x231000_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x231000_CheckSubmit( sceneId, selfId, selectRadioId )>0 then		--已经完成任务了
		--local	iHuan=GetMissionData(sceneId,selfId,10)	--取得总共做过的环数
		--添加任务奖励
		money = 100    --*iHuan
		AddMoney(sceneId,selfId,money );
		BeginEvent(sceneId)
			strText_M = format("你得到%d金钱",money)
	  		--strText = format("任务完成，当前为第%d环",iDayHuan)
	  		--AddText(sceneId,strText);
	  		AddText(sceneId,strText_M);
	  	EndEvent(sceneId)
	  	DispatchMissionTips(sceneId,selfId)
		--设置任务已经被完成过
		DelMission( sceneId,selfId,  x231000_g_MissionId )
		misIndex = GetMissionIndexByID(sceneId,selfId,4011)			--得到任务的序列号
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)						--根据序列号把任务变量的第0位置0 (任务完成情况)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x231000_OnKillObject( sceneId, selfId, objdataId ,objId )
	
	--是否是副本
	sceneType = LuaFnGetSceneType(sceneId) ;
	if sceneType~=1 then
		return
	end 
	--是否是所需要的副本
	fubentype = LuaFnGetCopySceneData_Param(sceneId,0)
	if fubentype~=x231000_g_CopySceneType then
		return
	end
	--副本关闭标志
	leaveFlag = LuaFnGetCopySceneData_Param(sceneId, 4) ;
	if 	leaveFlag==1 then --如果副本已经被置成关闭状态，则杀怪无效
		return 
	end
	
	--取得当前场景里的人数
	num = LuaFnGetCopyScene_HumanCount(sceneId)
	
	--取得杀死怪物的GroupID,用于判断是否是所需要杀掉的Boss
	GroupID = GetMonsterGroupID( sceneId, objId )
	if GroupID ~= x231000_g_NeedMonsterGroupID then
		return --不是所需要的Boss
	end
	
	killedbossnumber = LuaFnGetCopySceneData_Param(sceneId, 7) ;--杀死Boss的数量
	killedbossnumber = killedbossnumber+1
	LuaFnSetCopySceneData_Param(sceneId, 7, killedbossnumber) ;--设置杀死Boss的数量
	
	if killedbossnumber<x231000_g_TotalNeedKillBoss then

		BeginEvent(sceneId)
			strText = format("已杀Boss %d/%d", killedbossnumber, x231000_g_TotalNeedKillBoss )
			AddText(sceneId,strText);
		EndEvent(sceneId)

		for i=0,num-1 do
			humanObjId = LuaFnGetCopyScene_HumanObjId(sceneId,i)--取得当前场景里人的objId
			DispatchMissionTips(sceneId,humanObjId)

			misIndex = GetMissionIndexByID(sceneId,humanObjId,x231000_g_MissionId) --取得任务数据索引值
			local killedcount = GetMissionParam( sceneId, humanObjId, misIndex, x231000_g_Param_killcount) --取得已经杀了的怪物数
			killedcount = killedcount +1 ;
			SetMissionByIndex(sceneId,humanObjId,misIndex,x231000_g_Param_killcount,killedcount) --设置任务数据
		end
	elseif killedbossnumber>=x231000_g_TotalNeedKillBoss then
		--设置任务完成标志
		LuaFnSetCopySceneData_Param(sceneId, 4, 1)
		
		--取得已经执行的定时次数
		TickCount = LuaFnGetCopySceneData_Param(sceneId, 2) ;
		
		for i=0,num-1 do
			humanObjId = LuaFnGetCopyScene_HumanObjId(sceneId,i)	--取得当前场景里人的objId
			misIndex = GetMissionIndexByID(sceneId,humanObjId,x231000_g_MissionId)--取得任务数据索引值

			local killedcount = GetMissionParam( sceneId, humanObjId, misIndex, x231000_g_Param_killcount) --取得已经杀了的怪物数
			killedcount = killedcount +1 ;
			SetMissionByIndex(sceneId,humanObjId,misIndex,x231000_g_Param_killcount,killedcount) --设置任务数据

			--将任务的第1号数据设置为1,表示完成的任务
			SetMissionByIndex(sceneId,humanObjId,misIndex,x231000_g_Param_ok,1)--设置任务数据
			--完成副本所用时间
			SetMissionByIndex(sceneId,humanObjId,misIndex,x231000_g_Param_time,TickCount*x231000_g_TickTime)--设置任务数据

			BeginEvent(sceneId)
				strText = format("任务完成，将在%d秒后传送到入口位置", x231000_g_CloseTick*x231000_g_TickTime )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,humanObjId)
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x231000_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x231000_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--副本事件
--**********************************
function x231000_OnCopySceneReady( sceneId, destsceneId )

	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId);--设置副本入口场景号
	leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId) ;	
	leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);

	--取得玩家附近的队友数量（包括自己）
	local	nearteammembercount = GetNearTeamCount( sceneId, leaderObjId) 
	local mems = {}
	for	i=0,nearteammembercount-1 do
		mems[i] = GetNearTeamMember(sceneId, leaderObjId, i)
		misIndex = GetMissionIndexByID(sceneId,mems[i],x231000_g_MissionId)
		
		--将任务的第2号数据设置为副本的场景号
		SetMissionByIndex(sceneId,mems[i],misIndex,x231000_g_Param_sceneid,destsceneId)
				
		NewWorld( sceneId, mems[i], destsceneId, x231000_g_Fuben_X, x231000_g_Fuben_Z) ;
	end
end

--**********************************
--有玩家进入副本事件
--**********************************
function x231000_OnPlayerEnter( sceneId, selfId )
	--设置死亡后复活点位置
	SetPlayerDefaultReliveInfo( sceneId, selfId, "%10", -1, "0", sceneId, x231000_g_Fuben_X, x231000_g_Fuben_Z );
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x231000_OnHumanDie( sceneId, selfId, killerId )
	if x231000_g_DeadTrans==1 then --死亡后需要被强制踢出场景
	
		misIndex = GetMissionIndexByID(sceneId,selfId,x231000_g_MissionId)--取得任务数据索引值
		
		--将任务的第1号数据设置为1,表示完成的任务
		SetMissionByIndex(sceneId,selfId,misIndex,x231000_g_Param_ok,1)--设置任务数据
		
		--完成副本所用时间
		SetMissionByIndex(sceneId,selfId,misIndex,x231000_g_Param_time,TickCount*x231000_g_TickTime)--设置任务数据

		oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
		NewWorld( sceneId, selfId, oldsceneId, x231000_g_Back_X, x231000_g_Back_Z )
	end
end

--**********************************
--副本场景定时器事件
--**********************************
function x231000_OnCopySceneTimer( sceneId, nowTime )
	
	--副本时钟读取及设置
	TickCount = LuaFnGetCopySceneData_Param(sceneId, 2) ;--取得已经执行的定时次数
	TickCount = TickCount+1 ;
	LuaFnSetCopySceneData_Param(sceneId, 2, TickCount);--设置新的定时器调用次数
	
	--副本关闭标志
	leaveFlag = LuaFnGetCopySceneData_Param(sceneId, 4) ;
	
	if leaveFlag == 1 then --需要离开
		
		--离开倒计时间的读取和设置
		leaveTickCount = LuaFnGetCopySceneData_Param(sceneId, 5) ;
		leaveTickCount = leaveTickCount+1 ;
		LuaFnSetCopySceneData_Param(sceneId, 5, leaveTickCount) ;
		
		if leaveTickCount == x231000_g_CloseTick then --倒计时间到，大家都出去吧
		
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
			
			--将当前副本场景里的所有人传送回原来进入时候的场景
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
			local mems = {}
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				NewWorld( sceneId, mems[i], oldsceneId, x231000_g_Back_X, x231000_g_Back_Z )
			end
			
		elseif leaveTickCount<x231000_g_CloseTick then
		
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号

			--通知当前副本场景里的所有人，场景关闭倒计时间
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
			local mems = {}
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
	  			BeginEvent(sceneId)
	  				strText = format("你将在%d秒后离开场景!", (x231000_g_CloseTick-leaveTickCount)*x231000_g_TickTime )
	  				AddText(sceneId,strText);
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,mems[i])
			end
		end
	elseif TickCount == x231000_g_LimitTimeSuccess then
		--此处设置有时间限制的任务完成处理
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			
  			BeginEvent(sceneId)
  				AddText(sceneId,"任务时间到，完成!");
  			EndEvent(sceneId)
  			DispatchMissionTips(sceneId,mems[i])
  			
			misIndex = GetMissionIndexByID(sceneId,mems[i],x231000_g_MissionId)--取得任务数据索引值
			--将任务的第1号数据设置为1,表示完成的任务
			SetMissionByIndex(sceneId,mems[i],misIndex,x231000_g_Param_ok,1)--设置任务数据
			--完成副本所用时间
			SetMissionByIndex(sceneId,mems[i],misIndex,x231000_g_Param_time,TickCount*x231000_g_TickTime)--设置任务数据
		end

		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId, 4, 1) ;
		
	elseif TickCount == x231000_g_LimitTotalHoldTime then --副本总时间限制到了
		--此处设置副本任务有时间限制的情况，当时间到后处理...
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			DelMission( sceneId, mems[i], x231000_g_MissionId );--任务失败,删除之

  			BeginEvent(sceneId)
  				AddText(sceneId,"任务失败，超时!");
  			EndEvent(sceneId)
  			DispatchMissionTips(sceneId,mems[i])
		end

		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId, 4, 1) ;
		
	else 
		--定时检查队伍成员的队伍号，如果不符合，则踢出副本
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if IsHaveMission(sceneId,mems[i],x231000_g_MissionId) > 0 then
				oldteamid = LuaFnGetCopySceneData_Param(sceneId, 6) ; --取得保存的队伍号
				if oldteamid ~= GetTeamId(sceneId,mems[i]) then
				
					DelMission( sceneId, mems[i], x231000_g_MissionId );--任务失败,删除之

  					BeginEvent(sceneId)
  						AddText(sceneId,"任务失败，你不在正确的队伍中!");
  					EndEvent(sceneId)
  					DispatchMissionTips(sceneId,mems[i])
  					
 					oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
					NewWorld( sceneId, mems[i], oldsceneId, x231000_g_Back_X, x231000_g_Back_Z )
  				end
  			end
		end
		
	end
end
