--对话事件 npc周老实

--脚本号
x713605_g_ScriptId = 713516

--对话内容
x713605_g_dialog = {"中华医术",
			"...",
			"治病救人",
			"把药材做成丹药，服用",
			"谁说我不爱说话了?知道神农尝百草么?我刚才刚尝了一种新的药材,麻得我舌头都酥了,说不出话,你真是不理解钻研医术人的心情啊!"}
x713605_g_button = {"... ... 多说一个字会死啊?",
			"好了，告诉我中医有什么作用",
			"怎么救?",
			"既然你那么不爱说话，我不学还不行么，哼!",
			}

--**********************************
--任务入口函数
--**********************************
function x713605_OnDefaultEvent( sceneId, selfId, targetId, MessageNum )	--MessageNum是对话编号，用于调用不同对话
		BeginEvent(sceneId)
			AddText(sceneId, x713605_g_dialog[MessageNum])
			if MessageNum ~= 5 then
				AddNumText(sceneId,MessageNum, x713605_g_button[MessageNum])
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--列举事件
--**********************************
function x713605_OnEnumerate( sceneId, selfId, targetId )
		AddNumText(sceneId,x713605_g_ScriptId,"我想了解中医")
end

--**********************************
--检测接受条件
--**********************************
function x713605_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x713605_OnAccept( sceneId, selfId, AbilityId )
end
