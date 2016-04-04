-- 洛阳
--骑乘
--问路脚本
x500010_g_scriptId = 500010

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500010_g_Signpost = {
	{ type=2, name="骑乘", x=136, y=80, tip="骑乘", desc="骑乘" },
}

--**********************************
--列举事件
--**********************************
function x500010_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500010_g_Signpost do
		AddNumText(sceneId, x500010_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500010_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500010_g_Signpost[GetNumText()]

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
