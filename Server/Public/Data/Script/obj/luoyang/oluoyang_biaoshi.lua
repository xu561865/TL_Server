--洛阳NPC
--镖师
--普通

--**********************************
--事件交互入口
--**********************************
function x000073_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"有什么东西要本镖局帮忙运送的吗？保你一百个放心。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
