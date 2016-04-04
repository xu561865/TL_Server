--大理NPC
--杨百里
--普通

x002036_g_scriptId=002036

--**********************************
--事件交互入口
--**********************************
function x002036_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你想去哪里？")
		AddNumText(sceneId,x002036_g_scriptId,"大理东门",-1,0)
		AddNumText(sceneId,x002036_g_scriptId,"大理南门",-1,1)
		AddNumText(sceneId,x002036_g_scriptId,"剑阁",-1,2)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x002036_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		SetPos(  sceneId, selfId, 282, 152)	
	elseif	GetNumText()==1	then
		SetPos(  sceneId, selfId, 160, 277)	
	elseif	GetNumText()==2	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 7,40,278)
	end
end
