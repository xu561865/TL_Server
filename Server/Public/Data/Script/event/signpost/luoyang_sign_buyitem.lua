-- 洛阳
--购买物品
--问路脚本
x500001_g_scriptId = 500001

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500001_g_Signpost = {
	{ type=2, name="兵器店", x=211, y=154, tip="兵器店", desc="兵器店" },
	{ type=2, name="服饰店", x=182, y=183, tip="服饰店", desc="服饰店" },
	{ type=2, name="饰品店", x=178, y=177, tip="饰品店", desc="饰品店" },
	{ type=2, name="药店", x=135, y=164, tip="药店", desc="药店" },
	{ type=2, name="酒店", x=138, y=140, tip="酒店", desc="酒店" },
	{ type=2, name="珠宝商人", x=63, y=147, tip="珠宝商人", desc="珠宝商人" },
}

--**********************************
--列举事件
--**********************************
function x500001_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500001_g_Signpost do
		AddNumText(sceneId, x500001_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500001_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500001_g_Signpost[GetNumText()]

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
