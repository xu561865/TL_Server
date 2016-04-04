-- 叛师任务

--脚本号
x806006_g_scriptId = 806006

--叛师
x806006_g_BetrayMaster = {}
x806006_g_BetrayMaster["Id"] = 1005
x806006_g_BetrayMaster["Name"] = "叛师"


--**********************************
--任务入口函数
--**********************************
function x806006_OnDefaultEvent( sceneId, selfId, targetId )
	if x806006_CheckSubmit( sceneId, selfId ) > 0 then
		x806006_OnAccept( sceneId, selfId )
	end
end

--**********************************
--列举事件
--**********************************
function x806006_OnEnumerate( sceneId, selfId, targetId )
	if x806006_CheckAccept(sceneId, selfId) > 0 then
		AddNumText(sceneId, x806006_g_scriptId, x806006_g_BetrayMaster["Name"]);
	end
end

--**********************************
--检测接受条件
--**********************************
function x806006_CheckAccept( sceneId, selfId )

	--检查：
	--必须有师傅
	if LuaFnHaveMaster( sceneId, selfId ) == 0 then
		return 0
	end

	--徒弟身上金钱大于等于N=20000
	if LuaFnGetMoney( sceneId, selfId ) < 20000 then
		return 0
	end

	return 1

end

--**********************************
--检测是否可以叛师
--**********************************
function x806006_CheckSubmit( sceneId, selfId )

	if x806006_CheckAccept( sceneId, selfId ) == 1 then
		return 1
	end

	return 0

end

--**********************************
--接受
--**********************************
function x806006_OnAccept( sceneId, selfId )
	--扣除身上金钱20000；
	LuaFnCostMoney( sceneId, selfId, 20000 )

	MasterGUID = LuaFnGetMasterGUID( sceneId, selfId )

	MasterName = LuaFnGetFriendName( sceneId, selfId, MasterGUID )
	selfName = LuaFnGetName( sceneId, selfId )

	--发普通邮件给师傅
	LuaFnSendNormalMail( sceneId, selfId, MasterName, "你的徒弟" .. selfName .. "无意于继续在你门下，已与你脱离了师徒关系。" )

	MyGUID = LuaFnGetGUID( sceneId, selfId )

	--发可执行邮件给师傅
	LuaFnSendScriptMail( sceneId, MasterName, MAIL_BETRAYMASTER, MyGUID, 0, 0 )

	--删除徒弟称号
	LuaFnAwardSpouseTitle( sceneId, selfId, "" )
	DispatchAllTitle( sceneId, selfId )

	--最终执行叛师
	LuaFnBetrayMaster( sceneId, selfId )
end
