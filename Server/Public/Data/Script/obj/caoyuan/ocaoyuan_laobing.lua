--老兵

--脚本号
x020006_g_scriptId = 020006

--**********************************
--事件列表
--**********************************
function x020006_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerName=GetName(sceneId,selfId)
		AddText(sceneId," "..PlayerName.."大人，您好。#r 闹马匪之前，咱兰陵郡每年给朝廷供八千匹战马，也偷偷卖给南边一些。#r 其实我很少和宋人说话，只是因为您是郡主的客人。我跟了咱大王二十年，一直都和宋军打打停停的，打的时候就是仇人，停了又要做生意。#r 郡主从小和那些小南蛮一起玩，不忌讳这些。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
