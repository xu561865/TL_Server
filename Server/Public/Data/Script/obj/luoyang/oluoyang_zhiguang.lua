--洛阳NPC
--智光
--普通

--**********************************
--事件交互入口
--**********************************
function x000020_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"老衲平生所犯罪孽太多，只有多做善事，才能解脱。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
