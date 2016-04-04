--苏州NPC
--贺铸
--一般

--**********************************
--事件交互入口
--**********************************
function x001010_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"清明前夕，这苏州城中的烟草风絮，令我诗兴大发啊。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
