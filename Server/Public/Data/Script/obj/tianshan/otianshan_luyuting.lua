--天山NPC
--芦雨亭
--普通

--**********************************
--事件交互入口
--**********************************
function x017009_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"如果你是天山弟子，我可以教你骑雕的技能。不过这个技能现在还没做。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
