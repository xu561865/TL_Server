--大理NPC
--王韶
--普通

--**********************************
--事件交互入口
--**********************************
function x002000_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"戎马一生，富贵黄金，也不过是过眼烟云，只要大宋大理两国安好无恙，我也就心安了。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
