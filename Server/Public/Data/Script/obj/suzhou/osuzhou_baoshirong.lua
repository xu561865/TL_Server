--苏州NPC
--包世荣
--一般

x001037_g_shoptableindex=25

--**********************************
--事件交互入口
--**********************************
function x001037_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x001037_g_shoptableindex )
end
