--调整发色
--脚本号
x801011_g_ScriptId = 801011

--调整发色UI 22

--**********************************
--列举事件
--**********************************
function x801011_OnEnumerate( sceneId, selfId, targetId )

	-- 为什么要 NPC 名字？
	local TransportNPCName=GetName(sceneId,targetId);

	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId)
		UICommand_AddString(sceneId,TransportNPCName)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 22)
	return

end


--**********************************
--调整完发型
--**********************************
function x801011_FinishAdjust( sceneId, selfId, ColorValue)

	item = 20307001

	itemCount = GetItemCount( sceneId, selfId, item )
	if itemCount < 1 then
		Msg2Player(sceneId,selfId,"没有足够的染发剂。",MSG2PLAYER_PARA)

		return
	end

	DelItem( sceneId, selfId, item, 1 )

	SetHumanHairColor( sceneId, selfId, ColorValue )
	Msg2Player(sceneId,selfId,"染发成功。",MSG2PLAYER_PARA)
end
