--洛阳NPC
--徐长老
--普通

--**********************************
--事件交互入口
--**********************************
function x000021_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"丐帮杏子林大会不久即将召开，到时候我要向大家宣布一件重大的事情。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
