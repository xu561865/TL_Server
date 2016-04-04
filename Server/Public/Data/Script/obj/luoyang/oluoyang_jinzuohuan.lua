--洛阳NPC
--金左焕
--普通

--**********************************
--事件交互入口
--**********************************
function x000028_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"高丽国本次进贡的国礼没有丢！谁说丢了？")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
