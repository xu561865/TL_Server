--对话事件 npc周老实

--脚本号
x713610_g_ScriptId = 713510

--对话内容
x713610_g_dialog = {"俗语说:民以食为天。少侠在闯荡江湖时离不开美食的陪伴，但是美食的价格可不是很便宜，要是少侠自己学会了种植，就可以自己种出需要的材料，再也不会挨饿啦。",
			"种出来的粮食不能直接食用哦，你必须学会烹饪技能才能把粮食烹制成美味的食品。到洛阳找到饭桶那个死胖子就可以学习烹饪了",
			"只要向我学习种植技能就可以种植了，当然，你的等级越高，可以种的植物种类越多",
			"只要学习了种植技能，到没有开始耕种的田地旁边与看守田地的稻草人对话，然后选择想种植的植物就可以了",
			"开始种植后，会看到田里显示你种下的幼苗，这时候你就可以去做自己的事情了，不需要照顾田里的庄稼。但是不要忘了，40分钟以后一定要回来收庄稼，否则过了50分钟，别人就会把你的庄稼收走了。"}
x713610_g_button = {"种出的粮食是不是可以马上食用了?",
			"我怎样才能种植呢?",
			"然后呢?",
			"怎样收获呢?",
			}

--**********************************
--任务入口函数
--**********************************
function x713610_OnDefaultEvent( sceneId, selfId, targetId, MessageNum )	--MessageNum是对话编号，用于调用不同对话
		BeginEvent(sceneId)
			AddText(sceneId, x713610_g_dialog[MessageNum])
			if MessageNum ~= 5 then
				AddNumText(sceneId,MessageNum, x713610_g_button[MessageNum])
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--列举事件
--**********************************
function x713610_OnEnumerate( sceneId, selfId, targetId )
		AddNumText(sceneId,x713610_g_ScriptId,"我想了解种植")
end

--**********************************
--检测接受条件
--**********************************
function x713610_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x713610_OnAccept( sceneId, selfId, AbilityId )
end
