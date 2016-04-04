-- 大理问路脚本
x500040_g_scriptId = 500040

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500040_g_Signpost = {
		{ type=1, name="九大门派传送人", eventId=500041 },
		{ type=1, name="购买各种物品", eventId=500042 },
		{ type=1, name="驿站", eventId=500043 },
		{ type=1, name="钱庄、当铺、元宝商人", eventId=500044 },
		{ type=1, name="我想出城门去练习本领", eventId=500045 },
		{ type=1, name="学习一些生活技能", eventId=500046 },
		{ type=1, name="我想做些任务", eventId=500047 },
		{ type=1, name="擂台", eventId=500048 },
}

--{ type=2, name="东升客栈", x=100.7, y=124.2, tip="大理东升客栈", desc="大理最大的客栈之一，三教九流聚集之地。" },
--{ type=2, name="毕昇", x=180.0, y=120.0, tip="毕昇。娶妻拜师休妻叛师的好去处！", desc="毕昇～，实现你毕生的梦想～～～" },


--**********************************
--列举事件
--**********************************
function x500040_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500040_g_Signpost do
		AddNumText(sceneId, x500040_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500040_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500040_g_Signpost[GetNumText()]

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
