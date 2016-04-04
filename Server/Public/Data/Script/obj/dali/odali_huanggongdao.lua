--大理NPC
--黄公道
--服装店

x002024_g_shoptableindex=2

--**********************************
--事件交互入口
--**********************************
function x002024_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x002024_g_shoptableindex )
end
