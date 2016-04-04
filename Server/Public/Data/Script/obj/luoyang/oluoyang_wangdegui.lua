--洛阳NPC
--王德贵
--普通

--武器店
x000050_g_shoptableindex=11

--**********************************
--事件交互入口
--**********************************
function x000050_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x000050_g_shoptableindex )
end
