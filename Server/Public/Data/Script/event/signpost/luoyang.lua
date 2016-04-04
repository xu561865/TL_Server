-- 洛阳问路脚本
x500000_g_scriptId = 500000

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500000_g_Signpost = {
		{ type=1, name="购买各种物品", eventId=500001 },
		{ type=1, name="驿站", eventId=500002 },
		{ type=1, name="钱庄、当铺、元宝商人", eventId=500003 },
		{ type=1, name="我想出城门去练习本领", eventId=500004 },
		{ type=1, name="学习一些生活技能", eventId=500005 },
		{ type=1, name="我想做些任务", eventId=500006 },
		{ type=1, name="我要结婚", eventId=500007 },
		{ type=1, name="帮派", eventId=500008 },
		{ type=1, name="商会", eventId=500009 },
		{ type=1, name="骑乘", eventId=500010 },
		{ type=1, name="战斗管理", eventId=500011 },
		{ type=1, name="宝石合成", eventId=500012 },
		{ type=1, name="拜师与结拜", eventId=500013 },
}
--{ type=2, name="东升客栈", x=100.7, y=124.2, tip="洛阳东升客栈", desc="洛阳最大的客栈之一，三教九流聚集之地。" },

--**********************************
--列举事件
--**********************************
function x500000_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500000_g_Signpost do
		AddNumText(sceneId, x500000_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500000_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500000_g_Signpost[GetNumText()]

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
