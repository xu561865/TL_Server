-- 洛阳
--商会
--问路脚本
x500009_g_scriptId = 500009

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500009_g_Signpost = {
	{ type=2, name="商会", x=225, y=152, tip="商会", desc="商会" },
}

--**********************************
--列举事件
--**********************************
function x500009_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500009_g_Signpost do
		AddNumText(sceneId, x500009_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500009_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500009_g_Signpost[GetNumText()]

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
