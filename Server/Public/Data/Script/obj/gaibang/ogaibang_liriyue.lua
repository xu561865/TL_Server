--丐帮NPC
--李日越
--普通

x010011_g_shoptableindex=49

--**********************************
--事件交互入口
--**********************************
function x010011_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x010011_g_shoptableindex )
end
