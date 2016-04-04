--对话事件 npc周老实

--脚本号
x713601_g_ScriptId = 713515

--对话内容
x713601_g_dialog = {"咱们大宋的美食真是名满天下，学习了烹饪，就可以亲手烹制出回复体力内力的美食。",
			"在平时战斗中得到的一些肉类和种植得到的粮食都可以用来烹饪，但是每次烹饪要消耗一定的活力",
			"只要向我学习烹饪技能就可以了，当然，你的等级越高，可以制作的食物种类越多",
			"只要学习了烹饪技能，背包中有相应材料，在技能界面选择要制作的食物，点击制作就可以了，当然，你还要有足够的活力",
			"点击背包中的食物就可以食用了，可以在一段时间内增加你的体力活着内力，战斗中也可以使用哦"}
x713601_g_button = {"烹饪需要什么材料？",
			"我怎样才能烹饪呢?",
			"然后呢?",
			"食物有什么效果呢",
			}

--**********************************
--任务入口函数
--**********************************
function x713601_OnDefaultEvent( sceneId, selfId, targetId, MessageNum )	--MessageNum是对话编号，用于调用不同对话
		BeginEvent(sceneId)
			AddText(sceneId, x713601_g_dialog[MessageNum])
			if MessageNum ~= 5 then
				AddNumText(sceneId,MessageNum, x713601_g_button[MessageNum])
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--列举事件
--**********************************
function x713601_OnEnumerate( sceneId, selfId, targetId )
		AddNumText(sceneId,x713601_g_ScriptId,"我想了解烹饪")
end

--**********************************
--检测接受条件
--**********************************
function x713601_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x713601_OnAccept( sceneId, selfId, AbilityId )
end
