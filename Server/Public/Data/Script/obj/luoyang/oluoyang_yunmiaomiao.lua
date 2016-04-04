--洛阳NPC
--云渺渺
--普通

x000101_g_scriptId = 000101

x000101_g_shoptableindex=17

--所拥有的事件ID列表
x000101_g_eventList={311111}

--**********************************
--事件交互入口
--**********************************
function x000101_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你想我对宠物做什么动作呢？")
		AddNumText(sceneId,x000101_g_scriptId,"购买宠物用品",-1,0)
		AddNumText(sceneId,x000101_g_scriptId,"普通技能学习",-1,1)
		AddNumText(sceneId,x000101_g_scriptId,"还童",-1,2)
		AddNumText(sceneId,x000101_g_scriptId,"延长寿命",-1,3)
		AddNumText(sceneId,x000101_g_scriptId,"驯养",-1,4)
		AddNumText(sceneId,x000101_g_scriptId,"发布征友信息",-1,5)
		AddNumText(sceneId,x000101_g_scriptId,"征友",-1,6)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件列表选中一项
--**********************************
function x000101_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText() == 0	then
		DispatchShopItem( sceneId, selfId,targetId, x000101_g_shoptableindex )
	else
		local sel = GetNumText();
		for i, eventId in x000101_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId, sel)
		end
	end
end
