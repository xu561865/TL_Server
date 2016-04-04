--洛阳NPC
--藤原佐为
--普通

--脚本号
x000029_g_scriptId = 000029

--**********************************
--事件交互入口
--**********************************
function x000029_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是藤原佐为。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
