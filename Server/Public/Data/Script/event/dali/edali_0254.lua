--…±À¿...

--Ω≈±æ∫≈
x210254_g_ScriptId						= 210254

--»ŒŒÒ∫≈
x210254_g_Mission							= 3

function x210254_OnEnumerate( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "OnEnumerate", sceneId, selfId, targetId, x210254_g_ScriptId, x210254_g_Mission, Ident )
end

function x210254_OnDefaultEvent( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "OnDefaultEvent", sceneId, selfId, targetId, x210254_g_ScriptId, x210254_g_Mission, Ident )
end

function x210254_CheckAndAccept( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "CheckAndAccept", sceneId, selfId, targetId, x210254_g_ScriptId, x210254_g_Mission, Ident )
end

function x210254_OnSubmit( sceneId, selfId, targetId, selectId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "CheckAndSubmit", sceneId, selfId, targetId, x210254_g_ScriptId, x210254_g_Mission, selectId, Ident )
end

function x210254_OnItemChanged( sceneId, selfId, itemdataId )
	CallScriptFunction( MISSION_SCRIPT, "OnItemChanged", sceneId, selfId, x210254_g_ScriptId, x210254_g_Mission, itemdataId )
end

function x210254_OnAbandon( sceneId, selfId )
	CallScriptFunction( MISSION_SCRIPT, "OnAbandon", sceneId, selfId, x210254_g_Mission )
end

function x210254_OnKillObject( sceneId, selfId, objdataId, objId )
	CallScriptFunction( MISSION_SCRIPT, "OnKillObject", sceneId, selfId, x210254_g_ScriptId, x210254_g_Mission, objdataId, objId )
end
