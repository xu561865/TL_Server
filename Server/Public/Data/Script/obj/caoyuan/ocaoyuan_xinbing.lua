--新兵

--脚本号
x020007_g_scriptId = 020007

--**********************************
--事件列表
--**********************************
function x020007_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerName=GetName(sceneId,selfId)
		AddText(sceneId,"  "..PlayerName.."大人好，其实我也是汉人，刚来这里。#r  这大辽国哪个族都有，汉人命贱，替哪个朝廷卖命还不一样。听说新上任的南院大王也是汉人，竟然也姓萧。#r  您是怎么成了郡主的客人？要说这契丹姑娘，个个刁蛮脾性，这兰陵郡主模样虽俏，当了家也和老大王、小将军没什么两样。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
