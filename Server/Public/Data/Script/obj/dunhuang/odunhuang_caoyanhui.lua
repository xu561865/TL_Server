--敦煌 曹延惠

--脚本号
--g_scriptId = 008004

--所拥有的事件ID列表
x008004_g_eventList={210807,210808}--212603,212606}	

--**********************************
--事件列表
--**********************************
function x008004_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
--	local IsDone511 = IsMissionHaveDone(sceneId,selfId,511)	
	
--	AddText("好久不见了，"..PlayerName.."！现在我是西夏国的汉军团了，你也是\n\n来帮助我们的吗？这位是我们的将军--朱王礼朱将军。〈赵行德指\n\n了指他身边的将军，朱王礼略一欠身，并不答话〉西夏终于和宋朝\n\n开战了啊。我们汉军团在平定了回鹘、龟兹之后，刀锋要终于指向自己的父母\n\n之邦了。这是夏王李秉常的命令。让那些西夏兵去执行这个命令吧。\n\n我们最好是一直做一些清理残破兵俑的工作。去杀死10个残破兵\n\n俑，让后回到我这里来。")

	for i, eventId in x008004_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x008004_OnDefaultEvent( sceneId, selfId,targetId )
	x008004_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x008004_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x008004_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x008004_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x008004_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x008004_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x008004_g_eventList do
		if missionScriptId == findId then
			x008004_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x008004_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x008004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x008004_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x008004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x008004_OnDie( sceneId, selfId, killerId )
end
