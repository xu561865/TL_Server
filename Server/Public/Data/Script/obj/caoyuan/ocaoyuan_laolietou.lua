--老烈头

--脚本号
x020009_g_scriptId = 020009

--**********************************
--事件列表
--**********************************
function x020009_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerSex=GetSex(sceneId,selfId)
		if PlayerSex == 0 then
			PlayerSex = "姑娘"
		else
			PlayerSex = "年轻人"
		end
		AddText(sceneId,"  "..PlayerSex.."，你是阮实的朋友吧。#r  我叫烈喀巴，既不是契丹人，也不是汉人，我也是老大王掳来的。#r  草原上的孩子都是我看着一起玩大的。阮诚、小郡主他们都已经是大人了，承受着各自的责任,都当了家，生分了，都生分了。#r  阮实还是个孩子，就是太不安分，他不服契丹人啊。#r")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
