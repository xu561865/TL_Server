--洛阳NPC
--货商
--漕运循环任务

--脚本号
x311009_g_scriptId = 311009

Step = 600

--所拥有的事件ID列表
x311009_g_eventList={311010}

--**********************************
--事件交互入口
--**********************************
function x311009_OnDefaultEvent( sceneId, selfId,targetId )
	if	PRE_TIME == nil then
		PRE_TIME = LuaFnGetCurrentTime()
	else
		DUA_TIME = LuaFnGetCurrentTime() - PRE_TIME
		if	DUA_TIME >= Step then
			EVENT_NOW = random(1,4)
			PRE_TIME = PRE_TIME + floor(DUA_TIME / Step) *Step;
		end
	end
	if	EVENT_NOW == nil then
		EVENT_NOW = random(1,4)
	end
	BeginEvent(sceneId)
	AddText(sceneId,"你好，我是这里的漕货经销商。")
	if	EVENT_NOW == 1 then
		AddNumText(sceneId,x311009_g_scriptId,"进入黑市",-1,EVENT_NOW)
	elseif	EVENT_NOW == 2 then
		AddNumText(sceneId,x311009_g_scriptId,"帮忙哄抬物价",-1,EVENT_NOW)
	elseif	EVENT_NOW == 3 then
		AddNumText(sceneId,x311009_g_scriptId,"帮忙打压市场",-1,EVENT_NOW)
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x311009_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==1	then
		CallScriptFunction(311010, "OnEnumerate",sceneId, selfId, targetId)
	elseif	GetNumText()==2	then
		CallScriptFunction(311010, "OnFinishHaggleUp",sceneId, selfId)
	elseif	GetNumText()==3	then
		CallScriptFunction(311010, "OnFinishHaggleDown",sceneId, selfId)	
	end
end

