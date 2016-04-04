--大理NPC
--沈括
--普通

--**********************************
--事件交互入口
--**********************************
function x002001_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"大理国有很多植物和矿藏极为罕见，也不枉我从大宋千里迢迢而来，真是不虚此行啊。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
