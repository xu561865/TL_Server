--洛阳NPC
--武田信玄
--普通

--**********************************
--事件交互入口
--**********************************
function x000048_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"大宋有很多的东西值得我们学习，尤其是《孙子兵法》。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
