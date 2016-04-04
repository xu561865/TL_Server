--大理NPC
--小钗
--服装店

x002055_g_shoptableindex=3

--**********************************
--事件交互入口
--**********************************
function x002055_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x002055_g_shoptableindex )
end
