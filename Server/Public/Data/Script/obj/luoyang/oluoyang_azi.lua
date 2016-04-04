--洛阳NPC
--阿紫
--主要

--**********************************
--事件交互入口
--**********************************
function x000016_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"这是什么地方……我好冷……姐夫你在哪里……")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
