--洛阳NPC
--蔡丙臣
--普通

--**********************************
--事件交互入口
--**********************************
function x000092_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是蔡丙臣")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
