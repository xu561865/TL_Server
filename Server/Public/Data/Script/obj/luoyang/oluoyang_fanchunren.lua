--洛阳NPC
--范纯仁
--建立帮会
--脚本号
x000030_g_scriptId = 000030

--所拥有的事件ID列表
x000030_g_eventList={600000}

--**********************************
--事件交互入口
--**********************************
function x000030_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你想做什么帮会相关的动作呢？")
		
		AddNumText(sceneId,x000030_g_scriptId,"创建帮会",-1,1)
		AddNumText(sceneId,x000030_g_scriptId,"查看帮会列表",-1,2)
		AddNumText(sceneId,x000030_g_scriptId,"管理帮会会员信息",-1,3)
		AddNumText(sceneId,x000030_g_scriptId,"查看帮会详细信息",-1,4)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x000030_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sel = GetNumText();
	for i, eventId in x000030_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId, sel)
	end
end
