--苏州NPC
--苏轼
--一般

--**********************************
--事件交互入口
--**********************************
function x001002_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"若说这琴声是来自琴上，把琴放在盒子里，它就不响了。若说这琴声是来自手指上，为什么不听听你的手指呢？")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
