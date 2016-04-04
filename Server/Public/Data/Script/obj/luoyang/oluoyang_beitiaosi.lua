--洛阳NPC

--北条司

--普通

x000047_g_ScriptId=000047

--**********************************
--事件交互入口
--**********************************
function x000047_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"在下是藤原家侍大将北条司。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
