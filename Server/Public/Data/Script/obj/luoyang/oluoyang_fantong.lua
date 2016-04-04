--洛阳NPC
--范统
--饭店老板

x000059_g_shoptableindex=15

x000059_g_scriptId=000059

--**********************************
--事件交互入口
--**********************************
function x000059_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"来尝尝茗珍楼的洛阳水席吧，包你吃了之后再也不想离开洛阳。")
		AddNumText(sceneId,x000059_g_scriptId,"购买食物",-1,0)
		AddNumText(sceneId,x000059_g_scriptId,"打工",-1,1)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x000059_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		DispatchShopItem( sceneId, selfId,targetId, x000059_g_shoptableindex )
	elseif	GetNumText()==1	then
		local ene=GetHumanEnergy( sceneId, selfId)
		if	ene>=40	then
			SetHumanEnergy( sceneId, selfId, ene-40)
			AddMoney( sceneId,selfId, 3000)
			BeginEvent(sceneId)
				strText = "你打工消耗40精力,获得30个银币"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		else
			BeginEvent(sceneId)
				strText = "你的精力不足40点,老板不需要你打工"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
end
