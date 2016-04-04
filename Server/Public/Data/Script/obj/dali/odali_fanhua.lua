--大理NPC
--范骅
--普通

--**********************************
--事件交互入口
--**********************************
function x002015_OnDefaultEvent( sceneId, selfId,targetId )
    local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	BeginEvent(sceneId)
		AddText(sceneId,"  "..PlayerName..PlayerSex.."，我有要事启禀圣上，没想圣上竟然不在宫中，这可是关乎于大宋西夏和我国的关系的大事啊！")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
