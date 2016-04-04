--石林 郑玄

--脚本号
x026000_g_scriptId = 026000

--所拥有的事件ID列表
x026000_g_eventList={211700,211702,211703,211704,211707,211708,211709}	

--**********************************
--事件列表
--**********************************
function x026000_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	
	local IsDone600 = IsMissionHaveDone(sceneId,selfId,600)
	local IsDone602 = IsMissionHaveDone(sceneId,selfId,602)
	local IsDone603 = IsMissionHaveDone(sceneId,selfId,603)
	local IsDone604 = IsMissionHaveDone(sceneId,selfId,604)	
	local IsDone607 = IsMissionHaveDone(sceneId,selfId,607)
	local IsDone609 = IsMissionHaveDone(sceneId,selfId,609)
	
	--print("IsDone600:", IsDone600) 
	
	--if((IsHaveMission(sceneId,selfId,600) > 0 or IsHaveMission(sceneId,selfId,607) 
	--	or IsHaveMission(sceneId,selfId,603) > 0 or IsHaveMission(sceneId,selfId,604) > 0
	--	)
	--	or (IsDone600 ~= 0 or IsDone603 ~= 0 or IsDone604 ~= 0 or IsDone607 ~= 0)) then
	--	AddText(sceneId,  "你还有已经接收任务没有完成！")
	--	EndEvent(sceneId)
	--	DispatchEventList(sceneId,selfId,targetId)
	--	return
	--end
	
		
	
	if(IsDone600 == 0) then	
		AddText(sceneId,  "只要有5张棕熊的毛皮，我们村子里的这些人们就算有救了。")
	elseif(IsDone602 == 0) then
		AddText(sceneId,  "听听我的故事吧，朋友，现在你离开这里还来得及。")	
	elseif(IsDone603 == 0) then
		AddText(sceneId, "找到秦红棉")	
	elseif(IsDone604 == 0) then
		AddText(sceneId, "找到天鹅交颈石")
	elseif(IsDone607 == 0) then
		AddText(sceneId, "去杀死10名偃师吧")
	 elseif(IsDone609 == 0) then
		AddText(sceneId, "去玉溪找人")	    				
	end
	
	for i, eventId in x026000_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	if	IsHaveMission(sceneId,selfId,602) > 0	then
		AddNumText(sceneId, x026000_g_scriptId,"开始听故事",-1,0)
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x026000_OnDefaultEvent( sceneId, selfId,targetId )
	x026000_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x026000_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	IsHaveMission(sceneId,selfId,602) <= 0	then
		CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
	else
		misIndex = GetMissionIndexByID(sceneId,selfId,602)
		res = GetMissionParam( sceneId, selfId, misIndex, 1)
		if	GetNumText() == 0  then
			BeginEvent(sceneId)
				AddText(sceneId,"开始是这么这么回事")
				AddNumText(sceneId, x026000_g_scriptId,"后来呢？",-1,1)
			EndEvent( )
			DispatchEventList(sceneId,selfId,targetId)
		elseif	GetNumText() == 1  then
			BeginEvent(sceneId)
				AddText(sceneId,"后来是这么这么回事")
				AddNumText(sceneId, x026000_g_scriptId,"最后呢？",-1,2)
			EndEvent( )
			DispatchEventList(sceneId,selfId,targetId)
		elseif	GetNumText() == 2  then
			BeginEvent(sceneId)
				AddText(sceneId,"下边啊，没了")
				SetMissionByIndex( sceneId, selfId, misIndex, 0, 1)
			EndEvent( )
			DispatchEventList(sceneId,selfId,targetId)
			BeginEvent(sceneId)
				strText = "任务完成"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
	for i, findId in x026000_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x026000_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x026000_g_eventList do
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
function x026000_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x026000_g_eventList do
		if missionScriptId == findId then
			x026000_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x026000_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x026000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x026000_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x026000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x026000_OnDie( sceneId, selfId, killerId )
end
