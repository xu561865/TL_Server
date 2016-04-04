--给你任务物品，转交给他人

--脚本号
x210253_g_ScriptId						= 210253

--任务号
x210253_g_Mission							= 2

function x210253_OnEnumerate( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "OnEnumerate", sceneId, selfId, targetId, x210253_g_ScriptId, x210253_g_Mission, Ident )
end

function x210253_OnDefaultEvent( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "OnDefaultEvent", sceneId, selfId, targetId, x210253_g_ScriptId, x210253_g_Mission, Ident )
end

function x210253_CheckAndAccept( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "CheckAndAccept", sceneId, selfId, targetId, x210253_g_ScriptId, x210253_g_Mission, Ident )
end

function x210253_OnSubmit( sceneId, selfId, targetId, selectId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "CheckAndSubmit", sceneId, selfId, targetId, x210253_g_ScriptId, x210253_g_Mission, selectId, Ident )
end

function x210253_OnItemChanged( sceneId, selfId, itemdataId )
	CallScriptFunction( MISSION_SCRIPT, "OnItemChanged", sceneId, selfId, x210253_g_ScriptId, x210253_g_Mission, itemdataId )
end

function x210253_OnAbandon( sceneId, selfId )
	CallScriptFunction( MISSION_SCRIPT, "OnAbandon", sceneId, selfId, x210253_g_Mission )
end
