--…±À¿...

--Ω≈±æ∫≈
x210255_g_ScriptId						= 210255

--»ŒŒÒ∫≈
x210255_g_Mission							= 4

function x210255_OnEnumerate( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "OnEnumerate", sceneId, selfId, targetId, x210255_g_ScriptId, x210255_g_Mission, Ident )
end

function x210255_OnDefaultEvent( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "OnDefaultEvent", sceneId, selfId, targetId, x210255_g_ScriptId, x210255_g_Mission, Ident )
end

function x210255_CheckAndAccept( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "CheckAndAccept", sceneId, selfId, targetId, x210255_g_ScriptId, x210255_g_Mission, Ident )
end

function x210255_OnSubmit( sceneId, selfId, targetId, selectId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "CheckAndSubmit", sceneId, selfId, targetId, x210255_g_ScriptId, x210255_g_Mission, selectId, Ident )
end

function x210255_OnItemChanged( sceneId, selfId, itemdataId )
	CallScriptFunction( MISSION_SCRIPT, "OnItemChanged", sceneId, selfId, x210255_g_ScriptId, x210255_g_Mission, itemdataId )
end

function x210255_OnAbandon( sceneId, selfId )
	CallScriptFunction( MISSION_SCRIPT, "OnAbandon", sceneId, selfId, x210255_g_Mission )
end

function x210255_OnKillObject( sceneId, selfId, objdataId, objId )
	CallScriptFunction( MISSION_SCRIPT, "OnKillObject", sceneId, selfId, x210255_g_ScriptId, x210255_g_Mission, objdataId, objId )
end
