--苏州NPC
--云霏霏
--一般

x001050_g_shoptableindex=27

--**********************************
--事件交互入口
--**********************************
function x001050_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"云霏霏，虫鸟坊坊主")
		AddNumText(sceneId,g_scriptId,"购买宠物用品",-1,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x001050_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText() == 0	then
		DispatchShopItem( sceneId, selfId,targetId, x001050_g_shoptableindex )
	end
end
