--丫鬟

--脚本号
x020005_g_scriptId = 020005

--**********************************
--事件列表
--**********************************
function x020005_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  我都来了两个月了，郡主一直对我好凶。#r  阿菲姐姐说她人很好，我怎么一点都看不出呢，其他人也说她凶蛮呢。#r  如果您有什么事情吩咐我好了，或者让老烈头去帮您办。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
