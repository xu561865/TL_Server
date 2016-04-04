-- 大理
--擂台
--问路脚本
x500048_g_scriptId = 500048

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500048_g_Signpost = {
	{ type=2, name="武馆馆主", x=96, y=221, tip="武馆馆主", desc="武馆馆主" },
}

--**********************************
--列举事件
--**********************************
function x500048_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500048_g_Signpost do
		AddNumText(sceneId, x500048_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500048_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500048_g_Signpost[GetNumText()]

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
