--天龙NPC
--杨青牛
--普通

--**********************************
--事件交互入口
--**********************************
function x013014_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"如果你是天龙寺弟子，我可以教你骑马的技能。不过这个技能现在还没做。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
