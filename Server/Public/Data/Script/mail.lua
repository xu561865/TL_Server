
--脚本邮件的脚本文件

--脚本号
x888889_g_scriptId = 888889


function x888889_ExecuteMail( sceneId, selfId, param0, param1, param2, param3 )

	if param0 == MAIL_REPUDIATE then
		x888889_Mail_Repudiate( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_BETRAYMASTER then
		x888889_Mail_BetrayMaster( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_EXPELPRENTICE then
		x888889_Mail_ExpelPrentice( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_UPDATE_ATTR then
		LuaFnUpdateAttr(sceneId, selfId, param0, param1, param2, param3)
	end

end

function x888889_Mail_Repudiate( sceneId, selfId, param0, param1, param2, param3 )

	SpouseGUID = LuaFnGetSpouseGUID( sceneId, selfId )

	--删除称号；
	LuaFnAwardSpouseTitle( sceneId, selfId, "" )
	DispatchAllTitle( sceneId, selfId )

	--删除婚姻技能
	Skills = {260, 261}
	for i, skillId in Skills do
		DelSkill( sceneId, selfId, skillId )
	end

	--增加金钱N=100000做为补偿；
	LuaFnAddMoney( sceneId, selfId, 100000 )

	--增加一个物品相思糖做为补偿；（如果空间够，不够算了）
	LuaFnBeginAddItem( sceneId )
	LuaFnAddItem( sceneId, 30002002, 1 )
	ret = LuaFnEndAddItem( sceneId, selfId )

	if ret == 1 then
		LuaFnAddItemListToHuman( sceneId, selfId )
	end

	--和对方的好友度设置成N=X（10）
	LuaFnSetFriendPointByGUID( sceneId, selfId, SpouseGUID, 10 )

	--删除结婚状态；
	LuaFnDivorce( sceneId, selfId )

end

function x888889_Mail_BetrayMaster( sceneId, selfId, param0, param1, param2, param3 )
	--开除徒弟
	LuaFnExpelPrentice( sceneId, selfId, param1 )
end

function x888889_Mail_ExpelPrentice( sceneId, selfId, param0, param1, param2, param3 )
	--删除徒弟称号
	LuaFnAwardSpouseTitle( sceneId, selfId, "" )
	DispatchAllTitle( sceneId, selfId )

	--离开师门
	LuaFnBetrayMaster( sceneId, selfId )
end
