--场景的脚本文件

--脚本号
x888888_g_scriptId_scene = 888888

x888888_g_defaultRelive_SceneID_1=0;
x888888_g_defaultRelive_SceneID_2=2;


function x888888_OnSceneInit( sceneId )
--场景在初始化完成后调用
end

function x888888_OnSceneTimer( sceneId, nowTime )
--场景计时器
--sceneId表示场景号，nowTime表示当前时间（程序启动后的时间，单位毫秒）

	sceneType = LuaFnGetSceneType(sceneId) ;
--	if sceneType == 1 then --场景类型是副本
--		copyscenetype = LuaFnGetCopySceneData_Param(sceneId,0) ;--取得副本号
--		copyscenescript = LuaFnGetCopySceneData_Param(sceneId,1) ; --取得脚本号
--		if copyscenetype==FUBEN_EXAMPLE then --例子
--			--例子不提供定时时间
--			print("不能使用例子副本类型，例子副本类型不提供定时事件")
--		elseif copyscenetype==FUBEN_EXAMPLE then --
--			CallScriptFunction( copyscenescript, "OnCopySceneTimer", sceneId, nowTime ) ;
--		end
--	end
end

function x888888_OnSceneQuit( sceneId )
--场景在关闭前调用

end

function x888888_OnScenePlayerEnter( sceneId, playerId )
	--设置缺省的复活信息

	sceneType = LuaFnGetSceneType(sceneId) ;
	if sceneType == 1 then --场景类型是副本
		copyscenescript = LuaFnGetCopySceneData_Param(sceneId,1) ; --取得脚本号
		CallScriptFunction( copyscenescript, "OnPlayerEnter", sceneId, playerId ) ;
	else
		if GetCurCamp( sceneId, playerId ) == PLAYER_CAMP1 then
			SetPlayerDefaultReliveInfo( sceneId, playerId, "%100", -1, "0", x888888_g_defaultRelive_SceneID_1, 80, 75 );
		else
			SetPlayerDefaultReliveInfo( sceneId, playerId, "%100", -1, "0", x888888_g_defaultRelive_SceneID_2, 164, 156 );
		end
	end
end

function x888888_OnSceneHumanDie( sceneId, selfId, killerId )
	--玩家死亡后脚本事件
	sceneType = LuaFnGetSceneType(sceneId) ;
	if sceneType == 1 then --场景类型是副本
		copyscenescript = LuaFnGetCopySceneData_Param(sceneId,1) ; --取得脚本号
		CallScriptFunction( copyscenescript, "OnHumanDie", sceneId, selfId, killerId )
	end
end

function x888888_OnSceneHumanLevelUp( sceneId, objId, level )
--	if level==2 then
--		LuaFnSendNormalMail( sceneId, objId, GetName(sceneId,objId), "恭喜你升到2级了！赵天师正在找你呢！" )
--	end
end

function x888888_OnSceneNotify( sceneId, destsceneId )
--sceneId 为副本入口所在场景ID, destsceneId为副本场景ID
--此函数响应调用表示副本场景已经初始化完成，可以传送玩家了

--	destsceneType = LuaFnGetSceneType(destsceneId) ;
--	if destsceneType == 1 then --场景类型是副本
--		copyscenetype = LuaFnGetCopySceneData_Param(destsceneId,0) ;--取得副本号
--		copyscenescript = LuaFnGetCopySceneData_Param(destsceneId,1) ; --取得脚本号
--		if copyscenetype==FUBEN_EXAMPLE then --例子
--			--例子不提供场景启动事件
--			print("不能使用例子副本类型，例子副本类型不提供场景启动事件")
--		elseif copyscenetype==FUBEN_EXAMPLE then --
--			CallScriptFunction( copyscenescript, "OnCopySceneReady", sceneId, destsceneId ) ;
--		end
--	end
end

-- 问路
function x888888_AskTheWay( sceneId, selfId, sceneNum, x, y, tip )
	Msg2Player( sceneId, selfId, "@*;flagNPC;" .. sceneNum .. ";" .. x .. ";" .. y .. ";" .. tip, MSG2PLAYER_PARA )
	Msg2Player( sceneId, selfId, "@*;flashNPC;" .. sceneNum .. ";" .. x .. ";" .. y .. ";" .. tip, MSG2PLAYER_PARA )
end

-- 问路
function x888888_AskTheWayPos( sceneId, selfId, sceneNum, x, y, tip )
	Msg2Player( sceneId, selfId, "@*;flagPOS;" .. sceneNum .. ";" .. x .. ";" .. y .. ";" .. tip, MSG2PLAYER_PARA )
	Msg2Player( sceneId, selfId, "@*;flashPOS;" .. sceneNum .. ";" .. x .. ";" .. y .. ";" .. tip, MSG2PLAYER_PARA )
end

-- 播放音效，UICommandID = 123
function x888888_PlaySoundEffect( sceneId, selfId, soundId )
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, soundId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 123)
end

--玩家角色时钟事件
function x888888_OnScenePlayerTimer( sceneId, selfId, nowtime )
	--SetCharacterTimer( sceneId, selfId, 0 )
end

--玩家角色登陆游戏事件, 此事件会在玩家调用x888888_OnScenePlayerEnter事件之后调用
function x888888_OnScenePlayerLogin( sceneId, selfId, nowtime )
	--CallScriptFunction( 888890, "OnDefaultEvent", sceneId, selfId )
end

--玩家创建角色后第一次登陆游戏事件, 此事件会在玩家调用x888888_OnScenePlayerEnter事
--件之后、x888888_OnScenePlayerLogin事件之前调用
function x888888_OnScenePlayerFirstLogin( sceneId, selfId, nowtime )
	LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "欢迎来到武侠世界！" )
	
	local equips = {10101000}
	local equip  = 1--random(1,5)
	local caps   = {10110000}
	local cap    = 1
	local boots  = {10111000}
	local boot   = 1
	local wrists = {10112000}
	local wrist  = 1
	local wears  = {10113000}
	local wear   = 1

	--local mp = GetMenPai(sceneId,selfId)
	--if mp == OR_ZHANSHI then
	--elseif mp == OR_ZHANSHI then
	--elseif mp == OR_DAOSHI then
	--end
	BeginAddItem( sceneId )
	AddItem( sceneId, equips[equip], 1 )
	AddItem( sceneId, caps[cap], 1 )
	AddItem( sceneId, boots[boot], 1 )
	AddItem( sceneId, wrists[wrist], 1 )
	AddItem( sceneId, wears[wear], 1 )
	EndAddItem( sceneId, selfId )
	AddItemListToHuman( sceneId, selfId )
	
	--for test
	--AddGemsToHuman(sceneId, selfId)
	--for test
	
	--AddMission( sceneId,selfId, 718, 210238, 0, 0, 0 )
	
end
