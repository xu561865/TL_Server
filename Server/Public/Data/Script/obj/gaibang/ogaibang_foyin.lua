--丐帮NPC
--佛印
--普通

--**********************************
--事件交互入口
--**********************************
function x010002_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"前些日子做了几天和尚，不好玩。所以来做乞丐玩玩。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
