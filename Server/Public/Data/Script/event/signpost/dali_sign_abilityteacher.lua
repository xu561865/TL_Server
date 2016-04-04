-- 大理
--生活技能大师
--问路脚本
x500046_g_scriptId = 500046

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500046_g_Signpost = {
	{ type=2, name="种植大师", x=277, y=167, tip="种植大师", desc="种植大师" },
	{ type=2, name="采矿大师", x=214, y=117, tip="采矿大师", desc="采矿大师" },
	{ type=2, name="采药大师", x=99, y=133, tip="采药大师", desc="采药大师" },
	{ type=2, name="渔夫", x=107, y=169, tip="渔夫", desc="渔夫" },
	{ type=2, name="工艺大师", x=207, y=195, tip="工艺大师", desc="工艺大师" },
	{ type=2, name="缝纫大师", x=240, y=173, tip="缝纫大师", desc="缝纫大师" },
	{ type=2, name="铸造大师", x=216, y=109, tip="铸造大师", desc="铸造大师" },
	{ type=2, name="烹饪大师", x=112, y=169, tip="烹饪大师", desc="烹饪大师" },
	{ type=2, name="制药大师", x=99, y=128, tip="制药大师", desc="制药大师" },
}

--**********************************
--列举事件
--**********************************
function x500046_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500046_g_Signpost do
		AddNumText(sceneId, x500046_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500046_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500046_g_Signpost[GetNumText()]

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
