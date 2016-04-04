function x300017_OnDefaultEvent( sceneId, selfId, targetId )	

	misIndex = GetMissionIndexByID(sceneId,selfId,4021)
	SetMissionByIndex(sceneId,selfId,misIndex,6,-1)

	local New_Time = LuaFnGetCurrentTime()
	local HaggleUp = 600 - New_Time + GetMissionParam(sceneId,selfId,misIndex,3)
	local HaggleDown = 900 - New_Time + GetMissionParam(sceneId,selfId,misIndex,4)
	local	circle	 = GetMissionData(sceneId,selfId,2)
	
	if(HaggleUp <0 ) then
		HaggleUp = 0
	end

	if(HaggleDown <0 ) then
		HaggleDown = 0
	end
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,5)
		UICommand_AddInt(sceneId,12)
		UICommand_AddInt(sceneId,HaggleUp)
		UICommand_AddInt(sceneId,HaggleDown)
		UICommand_AddInt(sceneId,circle)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 0)
end


function x300017_IsSkillLikeScript( sceneId, selfId)
	return 0;
end
