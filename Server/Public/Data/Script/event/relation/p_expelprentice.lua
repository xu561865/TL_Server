-- 逐出师们任务

--脚本号
x806009_g_scriptId = 806009

--叛师
x806009_g_ExpelPrentice = {}
x806009_g_ExpelPrentice["Id"] = 1006
x806009_g_ExpelPrentice["Name"] = "逐出师门"

--**********************************
--任务入口函数
--**********************************
function x806009_OnDefaultEvent( sceneId, selfId, targetId )
	if x806009_CheckSubmit( sceneId, selfId ) > 0 then
		x806009_OnAccept( sceneId, selfId, GetNumText() )
	end
end

--**********************************
--列举事件
--**********************************
function x806009_OnEnumerate( sceneId, selfId, targetId )
	for i=0,1 do
		guid = LuaFnGetPrenticeGUID( sceneId, selfId, i )

		if guid ~= -1 then
			if x806009_CheckAccept(sceneId, selfId) > 0 then
				PrenticeName = LuaFnGetFriendName( sceneId, selfId, guid )
				AddNumText(sceneId, x806009_g_scriptId, "将" .. PrenticeName .. x806009_g_ExpelPrentice["Name"], -1, i);
			end
		end
	end
end

--**********************************
--检测接受条件
--**********************************
function x806009_CheckAccept( sceneId, selfId, guid )

	--检查：
	--师傅身上金钱大于等于N=50000
	if LuaFnGetMoney( sceneId, selfId ) < 50000 then
		return 0
	end

	return 1

end

--**********************************
--检测是否可以逐出徒弟
--**********************************
function x806009_CheckSubmit( sceneId, selfId )

	if x806009_CheckAccept( sceneId, selfId ) == 1 then
		return 1
	end

	return 0

end

--**********************************
--接受
--**********************************
function x806009_OnAccept( sceneId, selfId, nIndex )
	--扣除身上金钱50000；
	LuaFnCostMoney( sceneId, selfId, 50000 )

	PrenticeGUID = LuaFnGetPrenticeGUID( sceneId, selfId, nIndex )

	PrenticeName = LuaFnGetFriendName( sceneId, selfId, PrenticeGUID )
	selfName = LuaFnGetName( sceneId, selfId )

	--发普通邮件给徒弟
	LuaFnSendNormalMail( sceneId, selfId, PrenticeName, "你的师父" .. selfName .. "无意于继续教导你，已与你脱离了师徒关系。" )

	--发可执行邮件给徒弟
	LuaFnSendScriptMail( sceneId, PrenticeName, MAIL_EXPELPRENTICE, 0, 0, 0 )

	--最终清理门户
	LuaFnExpelPrentice( sceneId, selfId, PrenticeGUID )
end
