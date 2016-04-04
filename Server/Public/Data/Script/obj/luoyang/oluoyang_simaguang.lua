--洛阳NPC
--司马光
--普通

--**********************************
--事件交互入口
--**********************************
function x000007_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"王安石果敢坚定，心思缜密，都是我很佩服的。但是他治国的方法不对啊。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
