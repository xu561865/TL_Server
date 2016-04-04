-- 大理
--钱庄
--问路脚本
x500044_g_scriptId = 500044

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500044_g_Signpost = {
	{ type=2, name="钱庄", x=187, y=122, tip="钱庄", desc="钱庄" },
	{ type=2, name="元宝商人", x=189, y=124, tip="元宝商人", desc="元宝商人" },
	{ type=2, name="当铺", x=188, y=133, tip="当铺", desc="当铺" },
}

--**********************************
--列举事件
--**********************************
function x500044_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500044_g_Signpost do
		AddNumText(sceneId, x500044_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500044_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500044_g_Signpost[GetNumText()]

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
