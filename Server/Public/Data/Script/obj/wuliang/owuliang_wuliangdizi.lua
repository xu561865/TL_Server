--无量弟子

--脚本号
x006007_g_scriptId = 006007


--**********************************
--事件交互入口
--**********************************
function x006007_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你有什么事情吗?")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


