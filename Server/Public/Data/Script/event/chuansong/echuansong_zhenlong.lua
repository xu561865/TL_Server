--玩家进入一个 area 时触发
function x400915_OnEnterArea( sceneId, selfId )
	if	IsHaveMission( sceneId, selfId, 4013)>0	then
		CallScriptFunction((231001), "OnAbandon",sceneId, selfId)
	end
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x400915_OnTimer( sceneId, selfId )
	-- 毫秒，看在这个 area 停留多久了
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5秒后仍未传送
	if StandingTime >= 5000 then
		x400915_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--玩家离开一个 area 时触发
function x400915_OnLeaveArea( sceneId, selfId )
end
