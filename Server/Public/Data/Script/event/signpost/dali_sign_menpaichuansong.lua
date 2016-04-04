-- 大理
--门派传送人
--问路脚本
x500041_g_scriptId = 500041

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500041_g_Signpost = {
	{ type=2, name="少林", x=187, y=122, tip="少林派传送人", desc="少林派欢迎你" },
	{ type=2, name="大理", x=189, y=124, tip="大理派传送人", desc="大理派欢迎你" },
	{ type=2, name="逍遥", x=188, y=133, tip="逍遥派传送人", desc="逍遥派欢迎你" },
	{ type=2, name="峨嵋", x=192, y=129, tip="峨嵋派传送人", desc="峨嵋派欢迎你" },
	{ type=2, name="天山", x=131, y=124, tip="天山派传送人", desc="天山派欢迎你" },
	{ type=2, name="星宿", x=134, y=120, tip="星宿派传送人", desc="星宿派欢迎你" },
	{ type=2, name="明教", x=130, y=121, tip="明教传送人", desc="明教欢迎你" },
	{ type=2, name="武当", x=127, y=131, tip="武当派传送人", desc="武当欢迎你" },
	{ type=2, name="丐帮", x=126, y=135, tip="丐帮传送人", desc="丐帮欢迎你" },
}

--**********************************
--列举事件
--**********************************
function x500041_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500041_g_Signpost do
		AddNumText(sceneId, x500041_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500041_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500041_g_Signpost[GetNumText()]

	if signpost.type == 1 then
		BeginEvent(sceneId)
			AddText(sceneId, signpost.name .. "：")
			CallScriptFunction( signpost.eventId, "OnEnumerate", sceneId, selfId, targetId )
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	elseif signpost.type == 2 then
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, signpost.x, signpost.y, signpost.tip )

		BeginEvent(sceneId)
			AddText(sceneId, signpost.desc)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, -1)
	end

end
