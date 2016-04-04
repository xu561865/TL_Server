--苏州NPC
--朱丹臣
--一般

--**********************************
--事件交互入口
--**********************************
function x001020_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"掳走世子的番僧，似乎与这姑苏慕容家有莫大联系。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
