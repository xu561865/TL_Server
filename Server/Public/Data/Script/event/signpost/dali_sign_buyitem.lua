-- 大理
--购买物品
--问路脚本
x500042_g_scriptId = 500042

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500042_g_Signpost = {
	{ type=2, name="兵器店", x=216, y=133, tip="兵器店", desc="兵器店" },
	{ type=2, name="服饰店", x=238, y=171, tip="服饰店", desc="服饰店" },
	{ type=2, name="饰品店", x=248, y=171, tip="饰品店", desc="饰品店" },
	{ type=2, name="宠物店", x=265, y=128, tip="宠物店", desc="宠物店" },
	{ type=2, name="药店", x=102, y=131, tip="药店", desc="药店" },
	{ type=2, name="酒店", x=109, y=170, tip="酒店", desc="酒店" },
	{ type=2, name="杂货店", x=57, y=131, tip="杂货店", desc="杂货店" },
}

--**********************************
--列举事件
--**********************************
function x500042_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500042_g_Signpost do
		AddNumText(sceneId, x500042_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500042_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500042_g_Signpost[GetNumText()]

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
