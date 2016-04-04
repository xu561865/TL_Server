-- 苏州问路脚本
x500020_g_scriptId = 500020

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500020_g_Signpost = {
		{ type=1, name="购买各种物品", eventId=500021 },
		{ type=1, name="我想出城门去练习本领", eventId=500022 },
		{ type=1, name="我想学习生活技能", eventId=500023 },
		{ type=1, name="我想做些任务", eventId=500024 },
}
--{ type=2, name="东升客栈", x=100.7, y=124.2, tip="苏州东升客栈", desc="苏州最大的客栈之一，三教九流聚集之地。" },

--**********************************
--列举事件
--**********************************
function x500020_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500020_g_Signpost do
		AddNumText(sceneId, x500020_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500020_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500020_g_Signpost[GetNumText()]

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
