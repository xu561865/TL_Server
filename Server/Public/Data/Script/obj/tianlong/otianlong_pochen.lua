--天龙NPC
--破嗔
--普通

--**********************************
--事件交互入口
--**********************************
function x013005_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"破嗔，拈花寺来挂单的")
		if	GetLevel( sceneId, selfId)>=10  then	
			AddNumText(sceneId,g_scriptId,"洛阳",-1,0)
			AddNumText(sceneId,g_scriptId,"苏州",-1,1)
		end
		AddNumText(sceneId,g_scriptId,"大理",-1,2)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x013005_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 0,132,183)
	elseif	GetNumText()==1	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 1,164,84)
	elseif	GetNumText()==2	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 2,241,141)
	end
end
