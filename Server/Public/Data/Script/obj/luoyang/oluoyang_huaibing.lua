--洛阳NPC

--怀丙

--普通



--**********************************

--事件交互入口

--**********************************

function x000015_OnDefaultEvent( sceneId, selfId,targetId )

	BeginEvent(sceneId)

		AddText(sceneId,"  漕运古来有之，其实就是江南与中原之间的盐米贸易渠道，这几年西南的铜铁也开始走漕运。#r #r  可是运河太过繁忙，加上水土流失，现在漕路已经淤塞。不得已只能变成官有民营，实际上是委托私人改走旱路贩运，成本很高。#r #r  不过我想还是疏通漕路方为根本之法。")

	EndEvent(sceneId)

	DispatchEventList(sceneId,selfId,targetId)

end

