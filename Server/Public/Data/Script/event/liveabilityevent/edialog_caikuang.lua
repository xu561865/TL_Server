--对话事件 采矿npc韦铜锤

--脚本号
x713607_g_ScriptId = 713607

--对话内容
x713607_g_dialog = {"不要以为采矿是很简单的技能，一名合格的矿工可以快速准确发现最有价值的矿脉，如果你是新手，就算发现了宝藏也很可能无法把它们开采出来。",
			"钱啊！孩子。虽然我们手持的是笨重粗糙的矿锄，但是如果运气好，挖出来却是绚丽的宝石和闪闪发光的金子。",
			"只要向我学习采矿技能就可以了，当然，你的等级越高，就可以采集更稀有的矿石",
			"。。。你要求还不低。好吧，我就奉陪到底。向我学习技能之后，你必须找到一把矿锄，就像我拿的这把一样。等等，别妄想我会送给你哦。矿锄嘛，很容易找到，在城里走走就能买到了。",
			"。。。#r。。。 。。。#r想得美，要是那么简单我早发了，还用得着在这里靠教技能糊口吗？#r真么简单的事情真懒得重复了，拿起矿锄，到野外看到矿脉一通乱凿就可以了，要不是看在你要学技能的份上，我真想揍你我"}
x713607_g_button = {"采矿那么辛苦，学来有什么好处?",
			"那我怎么才能采矿呢?",
			"具体一点",
			"然后金子就会飞到我手里了？",
			}

--**********************************
--任务入口函数
--**********************************
function x713607_OnDefaultEvent( sceneId, selfId, targetId, MessageNum )	--MessageNum是对话编号，用于调用不同对话
		BeginEvent(sceneId)
			AddText(sceneId, x713607_g_dialog[MessageNum])
			if MessageNum ~= 5 then
				AddNumText(sceneId,MessageNum, x713607_g_button[MessageNum])
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--列举事件
--**********************************
function x713607_OnEnumerate( sceneId, selfId, targetId )
		AddNumText(sceneId,x713607_g_ScriptId,"我想了解采矿")
end

--**********************************
--检测接受条件
--**********************************
function x713607_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x713607_OnAccept( sceneId, selfId, AbilityId )
end
