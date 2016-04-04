--副本传送

--脚本号
x805004_g_scriptId =805004

x805004_g_copysceneName="斯坦索姆"

--**********************************
--入口函数
--**********************************
function x805004_OnDefaultEvent( sceneId, selfId, targetId )
	leaderguid=LuaFnObjId2Guid(sceneId,selfId)

	LuaFnSetSceneLoad_Map(sceneId, "luoyang.nav"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好

	LuaFnSetSceneLoad_Monster(sceneId, "luoyang_monster.ini");
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, 15000);
	LuaFnSetCopySceneData_Timer(sceneId, 0);
	LuaFnSetCopySceneData_Param(sceneId, 0, 666);--设置副本数据，这里将0号索引的数据设置为666，用于表示副本号666(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, 805004);--将1号数据设置为副本场景事件脚本号

	LuaFnCreateCopyScene(); --初始化完成后调用创建副本函数
end

--**********************************
--副本事件
--**********************************
function x805004_OnCopySceneReady( sceneId, destsceneId )
	leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId) ;	
	leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
	NewWorld( sceneId, leaderObjId, destsceneId, 11, 11 ) ;
end


--**********************************
--列举事件
--**********************************
function x805004_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId, x805004_g_scriptId,x805004_g_copysceneName);
end

--**********************************
--检测接受条件
--**********************************
function x805004_CheckAccept( sceneId, selfId )
	return 1
end

--**********************************
--接受
--**********************************
function x805004_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x805004_OnAbandon( sceneId, selfId )
end

--**********************************
--继续
--**********************************
function x805004_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x805004_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x805004_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x805004_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x805004_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x805004_OnItemChanged( sceneId, selfId, itemdataId )
end







