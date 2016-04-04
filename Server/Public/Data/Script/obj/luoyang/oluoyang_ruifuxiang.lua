--洛阳NPC
--瑞福祥
--普通

--药店
x000099_g_shoptableindex=16

--**********************************
--事件交互入口
--**********************************
function x000099_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x000099_g_shoptableindex )
end
