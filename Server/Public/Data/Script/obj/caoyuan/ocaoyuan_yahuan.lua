--丫鬟

--脚本号
x020004_g_scriptId = 020004

--**********************************
--事件列表
--**********************************
function x020004_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerSex=GetSex(sceneId,selfId)
		if PlayerSex == 0 then
			PlayerSex = "姑娘"
		else
			PlayerSex = "少侠"
		end
		AddText(sceneId,"  "..PlayerSex.."，您是不是觉得我们郡主不好说话？其实她很善良的，只是最近心情不好。#r  老爷给郡主选了夫婿，却是二太子耶律延禧，是个有名的花花太子。#r  大王出使南边，少爷又长年在雁门战场，偌大的兰陵郡就是郡主一个人打理。#r  她的心事只有我知道，我却不能帮她做什么。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
