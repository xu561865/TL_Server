--生长点
--松果
--脚本号715009
--松果100%
--等级1

--每次打开必定获得的产品
x715009_g_MainItemId = 40002127
--任务号
x715009_g_MissionId = 1060

--生成函数开始************************************************************************
--每个ItemBox中最多10个物品
function	x715009_OnCreate(sceneId,growPointType,x,y)
	--放入ItemBox同时放入一个物品
	ItemBoxEnterScene(x,y,growPointType,sceneId,1,x715009_g_MainItemId)	--每个生长点最少能得到一个物品,这里直接放入itembox中一个
end
--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	x715009_OnOpen(sceneId,selfId,targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x715009_g_MissionId)			--得到任务的序列号
	if	IsHaveMission(sceneId,selfId,x715009_g_MissionId) > 0	 then
		if	GetMissionParam( sceneId, selfId, misIndex,5) == 3  then
			return OR_OK
		else
			return OR_U_CANNT_DO_THIS_RIGHT_NOW
		end
	else
		return OR_MISSION_NOT_FIND
	end
end
--打开前函数结束&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--回收函数开始########################################################################
function	x715009_OnRecycle(sceneId,selfId,targetId)
	--返回1，生长点回收
	return 1
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x715009_OnProcOver(sceneId,selfId,targetId)
	return 0
end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
