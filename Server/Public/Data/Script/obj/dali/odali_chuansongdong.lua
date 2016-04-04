--大理NPC
--杨十里
--普通

x002034_g_scriptId=002034

--**********************************
--事件交互入口
--**********************************
function x002034_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你想去哪里？")
		AddNumText(sceneId,x002034_g_scriptId,"大理西门",-1,0)
		AddNumText(sceneId,x002034_g_scriptId,"大理南门",-1,1)
		AddNumText(sceneId,x002034_g_scriptId,"无量山",-1,2)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x002034_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		SetPos(  sceneId, selfId, 40, 152)	
	elseif	GetNumText()==1	then
		SetPos(  sceneId, selfId, 160, 277)	
	elseif	GetNumText()==2	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 6,43,172)
	end
end
