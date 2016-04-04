--大理NPC
--韩永安
--普通

x002029_g_shoptableindex_1=8
x002029_g_shoptableindex_2=75

--**********************************
--事件交互入口
--**********************************
function x002029_OnDefaultEvent( sceneId, selfId,targetId )
	function x002029_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"我这里是大理城最大的当铺。你可以从我这里买到一些普通的材料和珍贵的物品。")
	AddNumText(sceneId,g_scriptId,"购买普通材料",-1,0)
--	AddNumText(sceneId,g_scriptId,"购买珍贵物品",-1,1)
	for i, eventId in g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x002029_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText() == 0	then
		DispatchShopItem( sceneId, selfId,targetId, x002029_g_shoptableindex_1 )
--	else
--		DispatchShopItem( sceneId, selfId,targetId, x002029_g_shoptableindex_2 )
	end
end
