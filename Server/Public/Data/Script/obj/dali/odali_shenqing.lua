--大理NPC
--申情
--宠物指导

--**********************************
--事件交互入口
--**********************************
function x002069_OnDefaultEvent( sceneId, selfId,targetId )
    local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	BeginEvent(sceneId)
		AddText(sceneId,"  宠物是这样带的，"..PlayerName..PlayerSex.."，要好好对待自己的宠物哦。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
