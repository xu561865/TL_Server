--找物品，送给自己

--脚本号
x210251_g_ScriptId						= 210251

--任务号
x210251_g_Mission							= 1

function x210251_OnEnumerate( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "OnEnumerate", sceneId, selfId, targetId, x210251_g_ScriptId, x210251_g_Mission, Ident )
end

function x210251_OnDefaultEvent( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "OnDefaultEvent", sceneId, selfId, targetId, x210251_g_ScriptId, x210251_g_Mission, Ident )
end

function x210251_CheckAndAccept( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "CheckAndAccept", sceneId, selfId, targetId, x210251_g_ScriptId, x210251_g_Mission, Ident )
end

function x210251_OnSubmit( sceneId, selfId, targetId, selectId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "CheckAndSubmit", sceneId, selfId, targetId, x210251_g_ScriptId, x210251_g_Mission, selectId, Ident )
end

function x210251_OnItemChanged( sceneId, selfId, itemdataId )
	CallScriptFunction( MISSION_SCRIPT, "OnItemChanged", sceneId, selfId, x210251_g_ScriptId, x210251_g_Mission, itemdataId )
end

function x210251_OnAbandon( sceneId, selfId )
	CallScriptFunction( MISSION_SCRIPT, "OnAbandon", sceneId, selfId, x210251_g_Mission )
end
