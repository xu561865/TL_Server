--丐帮NPC
--宋长老
--普通

--**********************************
--事件交互入口
--**********************************
function x010005_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"丐帮想要发展壮大，还真不能只招收乞丐。我最近收了一个弟子，他以前是个和尚。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
