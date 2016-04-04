--丐帮NPC
--张全祥
--普通

x010008_g_scriptId = 010008

--**********************************
--事件交互入口
--**********************************
function x010008_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"拜师请找陈长老，学艺请找奚长老。")
		if	GetLevel( sceneId, selfId)>=10  then	
			AddNumText(sceneId,x010008_g_scriptId,"洛阳",-1,0)
			AddNumText(sceneId,x010008_g_scriptId,"苏州",-1,1)
		end
		AddNumText(sceneId,x010008_g_scriptId,"大理",-1,2)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x010008_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 0,132,183)
	elseif	GetNumText()==1	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 1,164,84)
	elseif	GetNumText()==2	then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 2,241,141)
	end
end
