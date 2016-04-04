--玩家进入一个 area 时触发
function x400913_OnEnterArea( sceneId, selfId )
	if	IsHaveMission( sceneId, selfId, 702)>0	then
		CallScriptFunction((210222), "OnAbandon",sceneId, selfId)
	elseif	IsHaveMission( sceneId, selfId, 711)>0	then
		CallScriptFunction((210231), "OnAbandon",sceneId, selfId)
	elseif	IsHaveMission( sceneId, selfId, 1061)>0	then
		CallScriptFunction((220901), "OnAbandon",sceneId, selfId)
	end
	--CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 2,275,50)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x400913_OnTimer( sceneId, selfId )
	-- 毫秒，看在这个 area 停留多久了
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5秒后仍未传送
	if StandingTime >= 5000 then
		x400913_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--玩家离开一个 area 时触发
function x400913_OnLeaveArea( sceneId, selfId )
end
