--明教NPC
--方百花
--普通

--**********************************
--事件交互入口
--**********************************
function x011002_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"最近在光明顶都能熬出病来了，真想去苏州街头逛逛啊。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
