-- 苏州
--购买物品
--问路脚本
x500021_g_scriptId = 500021

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500021_g_Signpost = {
	{ type=2, name="服饰店", x=217, y=88, tip="服饰店", desc="服饰店" },
	{ type=2, name="饰品店", x=217, y=81, tip="饰品店", desc="饰品店" },
	{ type=2, name="宠物店", x=87, y=142, tip="宠物店", desc="宠物店" },
	{ type=2, name="药店", x=106, y=118, tip="药店", desc="药店" },
	{ type=2, name="酒店", x=190, y=168, tip="酒店", desc="酒店" },
	{ type=2, name="杂货店", x=128, y=173, tip="杂货店", desc="杂货店" },
}

--**********************************
--列举事件
--**********************************
function x500021_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500021_g_Signpost do
		AddNumText(sceneId, x500021_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500021_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500021_g_Signpost[GetNumText()]

	if signpost.type == 1 then
		BeginEvent(sceneId)
			AddText(sceneId, signpost.name .. "：")
			CallScriptFunction( signpost.eventId, "OnEnumerate", sceneId, selfId, targetId )
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	elseif signpost.type == 2 then
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_SUZHOU, signpost.x, signpost.y, signpost.tip )

		BeginEvent(sceneId)
			AddText(sceneId, signpost.desc)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, -1)
	end

end
