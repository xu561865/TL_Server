-- 苏州
--生活技能
--问路脚本
x500023_g_scriptId = 500023

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500023_g_Signpost = {
		{ type=2, name="种植大师", x=64, y=200, tip="种植大师", desc="种植大师" },
		{ type=2, name="采矿大师", x=259, y=132, tip="采矿大师", desc="采矿大师" },
		{ type=2, name="采药大师", x=106, y=109, tip="采药大师", desc="采药大师" },
		{ type=2, name="钓鱼大师", x=238, y=77, tip="钓鱼大师", desc="钓鱼大师" },
		{ type=2, name="工艺大师", x=109, y=130, tip="工艺大师", desc="工艺大师" },
		{ type=2, name="缝纫大师", x=211, y=90, tip="缝纫大师", desc="缝纫大师" },
		{ type=2, name="铸造大师", x=251, y=151, tip="铸造大师", desc="铸造大师" },
		{ type=2, name="烹饪大师", x=189, y=173, tip="烹饪大师", desc="烹饪大师" },
}

--**********************************
--列举事件
--**********************************
function x500023_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500023_g_Signpost do
		AddNumText(sceneId, x500023_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500023_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500023_g_Signpost[GetNumText()]

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
