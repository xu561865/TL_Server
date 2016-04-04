--洛阳NPC
--乔复盛
--普通

--**********************************
--事件交互入口
--**********************************
function x000052_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"九州商会不久之后就会开始全面营业，那时候你可以来找我学习一点商业技巧。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
