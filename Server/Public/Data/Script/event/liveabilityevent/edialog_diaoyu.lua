--对话事件 npc周老实

--脚本号
x713609_g_ScriptId = 713513

--对话内容
x713609_g_dialog = {"没有耐心的人是无法钓到鱼的，体味等待鱼上钩的悠闲自得，感受鱼在吃诱饵时的紧张、鱼上钩拉线的力量，享受钓到大鱼的成就感，品味烹煮鱼时四溢的香气。嗯，这就是钓鱼的乐趣",
			"按理说你也可以直接吃，但我想只有雁门关的狗熊才会那样迫不及待。少侠最好把鱼烹制一下再享用。",
			"先向我学习钓鱼技能，嗯，我教不教你要看我心情而定哦。",
			"然后你要有一根鱼竿，装上鱼竿以后，看到鱼的时候装备上鱼竿，点击鱼就可以了。当然，我说的是河里、水塘里的活鱼，我这里的鱼你就别点了。",
			"没有那么麻烦，开始钓鱼后，你就等着收获就好了，鱼会自动放到背包里的。不过过了一段时间钓鱼就会自动停止，你需要再次点击鱼才可以。钓鱼等级越高，钓的时间越长。"}
x713609_g_button = {"钓到的鱼是不是可以马上吃?",
			"我怎样才能钓鱼呢？",
			"然后呢?",
			"我需要什么时候收竿呢?",
			}

--**********************************
--任务入口函数
--**********************************
function x713609_OnDefaultEvent( sceneId, selfId, targetId, MessageNum )	--MessageNum是对话编号，用于调用不同对话
		BeginEvent(sceneId)
			AddText(sceneId, x713609_g_dialog[MessageNum])
			if MessageNum ~= 5 then
				AddNumText(sceneId,MessageNum, x713609_g_button[MessageNum])
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--列举事件
--**********************************
function x713609_OnEnumerate( sceneId, selfId, targetId )
		AddNumText(sceneId,x713609_g_ScriptId,"我想了解钓鱼")
end

--**********************************
--检测接受条件
--**********************************
function x713609_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x713609_OnAccept( sceneId, selfId, AbilityId )
end
