--洛阳NPC
--赵钱孙
--普通

--**********************************
--事件交互入口
--**********************************
function x000025_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"小娟前日给我来信了，一定是我的诚心感动了佛祖。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
