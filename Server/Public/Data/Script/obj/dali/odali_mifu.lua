--大理NPC
--米芾
--普通

--**********************************
--事件交互入口
--**********************************
function x002002_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"东临洱海鱼戏水，西枕苍山云弄峰。这大理国果然是个好地方，王大将军真有眼力，竟然会选此地隐居。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
