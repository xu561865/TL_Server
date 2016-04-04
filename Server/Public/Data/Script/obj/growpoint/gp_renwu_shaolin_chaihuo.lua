--生长点
--柴火
--脚本号715007
--柴火100%
--等级1

--每次打开必定获得的产品
x715007_g_MainItemId = 40002125
--任务号
x715007_g_MissionId = 1060

--生成函数开始************************************************************************
--每个ItemBox中最多10个物品
function	x715007_OnCreate(sceneId,growPointType,x,y)
	--放入ItemBox同时放入一个物品
	ItemBoxEnterScene(x,y,growPointType,sceneId,1,x715007_g_MainItemId)	--每个生长点最少能得到一个物品,这里直接放入itembox中一个
end
--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	x715007_OnOpen(sceneId,selfId,targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x715007_g_MissionId)			--得到任务的序列号
	if	IsHaveMission(sceneId,selfId,x715007_g_MissionId) > 0	 then
		if	GetMissionParam( sceneId, selfId, misIndex,5) == 1  then
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
function	x715007_OnRecycle(sceneId,selfId,targetId)
	--返回1，生长点回收
	return 1
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x715007_OnProcOver(sceneId,selfId,targetId)
	return 0
end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
