--明教NPC
--方七佛
--普通

x011003_g_scriptId=011003

--**********************************
--事件交互入口
--**********************************
function x011003_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"光明顶左手第一间是方腊左使，右手第一间是吕师襄右使。")
		if	GetLevel( sceneId, selfId)>=10  then	
			AddNumText(sceneId,x011003_g_scriptId,"洛阳",-1,0)
			AddNumText(sceneId,x011003_g_scriptId,"苏州",-1,1)
		end
		AddNumText(sceneId,x011003_g_scriptId,"大理",-1,2)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


--**********************************
--事件列表选中一项
--**********************************
function x011003_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 0,110,155)
	elseif	GetNumText()==1	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 1,141,50)
	elseif	GetNumText()==2	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 2,241,141)
	end
end
