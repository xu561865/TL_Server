--大理NPC
--白崇义
--普通

--**********************************
--事件交互入口
--**********************************
function x002058_OnDefaultEvent( sceneId, selfId,targetId )

	local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	BeginEvent(sceneId)
		AddText(sceneId,"  "..PlayerName..PlayerSex.."，武林大会是镇南王交待下来最重要的事情了，会务繁重，而且有人趁机混水摸鱼，下官可能有些事情要请少侠/姑娘代劳呢。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
