--大理NPC
--杨千里
--普通

x002035_g_scriptId=002035

--**********************************
--事件交互入口
--**********************************
function x002035_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"洱海很危险的，20级以后才能去，你还是现在大理城里转转吧。")
		AddNumText(sceneId,x002035_g_scriptId,"大理东门",-1,0)
		AddNumText(sceneId,x002035_g_scriptId,"大理西门",-1,1)
		if	GetLevel(sceneId, selfId)>=20	then
			AddNumText(sceneId,x002035_g_scriptId,"洱海",-1,2)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x002035_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		SetPos(  sceneId, selfId, 282, 152)	
	elseif	GetNumText()==1	then
		SetPos(  sceneId, selfId, 40, 152)	
	elseif	GetNumText()==2	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 24,280,37)
	end
end
