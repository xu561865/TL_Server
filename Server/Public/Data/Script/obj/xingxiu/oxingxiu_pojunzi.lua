--星宿NPC
--破军子
--普通

--**********************************
--事件交互入口
--**********************************
function x016008_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"如果你是星宿弟子，我可以教你骑牦牛的技能。不过这个技能现在还没做。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
