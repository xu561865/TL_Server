--∞Ôª·œ‡πÿUI 30£¨31

x600000_g_ScriptId = 600000;

function x600000_OnEnumerate( sceneId, selfId, targetId, sel )
	if( sel == 1 ) then
		GuildCreate(sceneId, selfId, targetId);
	elseif( sel == 2 ) then
		GuildList(sceneId, selfId, targetId);
	elseif( sel == 3 ) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 30)
	elseif( sel == 4 ) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 31)
	end
end
