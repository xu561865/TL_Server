--大理NPC
--华赫艮
--普通

--**********************************
--事件交互入口
--**********************************
function x002014_OnDefaultEvent( sceneId, selfId,targetId )
    local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	BeginEvent(sceneId)
		AddText(sceneId,"  "..PlayerName..PlayerSex.."，近来可好？可曾去看过洱海的风景？#r#r  碧波无边，心旷神怡。特别是月上柳梢时，别有一番滋味在心头，这就是我们大理国有名的“洱海月”。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
