--找人，找到人就完成任务

--脚本号
x210250_g_ScriptId						= 210250

--任务号
x210250_g_Mission							= 0

function x210250_OnEnumerate( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "OnEnumerate", sceneId, selfId, targetId, x210250_g_ScriptId, x210250_g_Mission, Ident )
end

function x210250_OnDefaultEvent( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "OnDefaultEvent", sceneId, selfId, targetId, x210250_g_ScriptId, x210250_g_Mission, Ident )
end

function x210250_CheckAndAccept( sceneId, selfId, targetId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "CheckAndAccept", sceneId, selfId, targetId, x210250_g_ScriptId, x210250_g_Mission, Ident )
end

function x210250_OnSubmit( sceneId, selfId, targetId, selectId, Ident )
	CallScriptFunction( MISSION_SCRIPT, "CheckAndSubmit", sceneId, selfId, targetId, x210250_g_ScriptId, x210250_g_Mission, selectId, Ident )
end

function x210250_OnItemChanged( sceneId, selfId, itemdataId )
	CallScriptFunction( MISSION_SCRIPT, "OnItemChanged", sceneId, selfId, x210250_g_ScriptId, x210250_g_Mission, itemdataId )
end

function x210250_OnAbandon( sceneId, selfId )
	CallScriptFunction( MISSION_SCRIPT, "OnAbandon", sceneId, selfId, x210250_g_Mission )
end
