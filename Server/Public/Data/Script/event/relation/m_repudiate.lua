-- 强制离婚任务

--脚本号
x806004_g_scriptId = 806004

--强制离婚
x806004_g_Repudiate= {}
x806004_g_Repudiate["Id"] = 1002
x806004_g_Repudiate["Name"] = "强制离婚"
x806004_g_Repudiate["Skills"] = {260, 261}

--**********************************
--任务入口函数
--**********************************
function x806004_OnDefaultEvent( sceneId, selfId, targetId )
	if x806004_CheckSubmit( sceneId, selfId ) > 0 then
		x806004_OnAccept( sceneId, selfId )
	end
end

--**********************************
--列举事件
--**********************************
function x806004_OnEnumerate( sceneId, selfId, targetId )
	if x806004_CheckAccept(sceneId, selfId) > 0 then
		AddNumText(sceneId, x806004_g_scriptId, x806004_g_Repudiate["Name"]);
	end
end

--**********************************
--检测接受条件
--**********************************
function x806004_CheckAccept( sceneId, selfId )

	--检查：
	--必须是结婚状态
	if LuaFnIsMarried( sceneId, selfId ) == 0 then
		return 0
	end

	--男方身上金钱大于等于N=200000
	if LuaFnGetMoney( sceneId, selfId ) < 200000 then
		return 0
	end

	return 1

end

--**********************************
--检测是否可以离婚
--**********************************
function x806004_CheckSubmit( sceneId, selfId )

	if x806004_CheckAccept( sceneId, selfId ) == 1 then
		return 1
	end

	return 0

end

--**********************************
--接受
--**********************************
function x806004_OnAccept( sceneId, selfId )

	-- 需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			return
		end
	end

	--扣除身上金钱200000；
	LuaFnCostMoney( sceneId, selfId, 200000 )

	--删除婚姻技能
	for i, skillId in x806004_g_Repudiate["Skills"] do
		DelSkill( sceneId, selfId, skillId )
	end

	--单方面降低友好度
	SpouseGUID = LuaFnGetSpouseGUID( sceneId, selfId )
	LuaFnSetFriendPointByGUID( sceneId, selfId, SpouseGUID, 10 )

	SpouseName = LuaFnGetFriendName( sceneId, selfId, SpouseGUID )
	selfName = LuaFnGetName( sceneId, selfId )

	--发普通邮件给配偶通知离婚
	LuaFnSendNormalMail( sceneId, selfId, SpouseName, selfName .. "已选择了与你强制离婚了，唉，随缘吧。" )

	--发可执行邮件给配偶来执行离婚
	LuaFnSendScriptMail( sceneId, SpouseName, MAIL_REPUDIATE, 0, 0, 0 )

	--删除称号
	LuaFnAwardSpouseTitle( sceneId, selfId, "" )
	DispatchAllTitle( sceneId, selfId )

	--单方面离婚
	LuaFnDivorce( sceneId, selfId )
end
