--洛阳NPC
--歌伎
--普通

--**********************************
--事件交互入口
--**********************************
function x000045_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"这里是洛阳第一美女李师师的家。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
