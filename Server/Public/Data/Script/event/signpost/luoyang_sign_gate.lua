-- 洛阳
--城门
--问路脚本
x500004_g_scriptId = 500004

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500004_g_Signpost = {
	{ type=2, name="南门", x=159, y=251, tip="南门", desc="南门" },
	{ type=2, name="东门", x=260, y=134, tip="东门", desc="东门" },
	{ type=2, name="西门", x=58, y=135, tip="西门", desc="西门" },
}

--**********************************
--列举事件
--**********************************
function x500004_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500004_g_Signpost do
		AddNumText(sceneId, x500004_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500004_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500004_g_Signpost[GetNumText()]

	if signpost.type == 1 then
		BeginEvent(sceneId)
			AddText(sceneId, signpost.name .. "：")
			CallScriptFunction( signpost.eventId, "OnEnumerate", sceneId, selfId, targetId )
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	elseif signpost.type == 2 then
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_LUOYANG, signpost.x, signpost.y, signpost.tip )

		BeginEvent(sceneId)
			AddText(sceneId, signpost.desc)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, -1)
	end

end
