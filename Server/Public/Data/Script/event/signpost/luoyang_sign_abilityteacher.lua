-- 洛阳
--生活技能导师
--问路脚本
x500005_g_scriptId = 500005

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500005_g_Signpost = {
	{ type=2, name="种植大师", x=90, y=210, tip="种植大师", desc="种植大师" },
	{ type=2, name="采矿大师", x=212, y=151, tip="采矿大师", desc="采矿大师" },
	{ type=2, name="采药大师", x=120, y=169, tip="采药大师", desc="采药大师" },
	{ type=2, name="渔夫", x=207, y=184, tip="渔夫", desc="渔夫" },
	{ type=2, name="工艺大师", x=60, y=146, tip="工艺大师", desc="工艺大师" },
	{ type=2, name="缝纫大师", x=193, y=172, tip="缝纫大师", desc="缝纫大师" },
	{ type=2, name="铸造大师", x=213, y=160, tip="铸造大师", desc="铸造大师" },
	{ type=2, name="烹饪大师", x=134, y=152, tip="烹饪大师", desc="烹饪大师" },
	{ type=2, name="制药大师", x=138, y=164, tip="制药大师", desc="制药大师" },
	{ type=2, name="镶嵌大师", x=174, y=33, tip="镶嵌大师", desc="镶嵌大师" },
	{ type=2, name="养生法大师", x=132, y=156, tip="养生法大师", desc="养生法大师" },
	{ type=2, name="药理学大师", x=136, y=168, tip="药理学大师", desc="药理学大师" },
}

--**********************************
--列举事件
--**********************************
function x500005_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500005_g_Signpost do
		AddNumText(sceneId, x500005_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500005_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500005_g_Signpost[GetNumText()]

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
