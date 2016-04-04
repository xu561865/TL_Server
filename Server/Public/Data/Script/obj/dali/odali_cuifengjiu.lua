--大理NPC
--崔逢九
--普通

x002026_g_scriptId=002026

--**********************************
--事件交互入口
--**********************************
function x002026_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		if	GetLevel( sceneId, selfId)>=10	then	
			AddText(sceneId,"你想去哪里？")
			AddNumText(sceneId,x002026_g_scriptId,"洛阳",-1,0)
			AddNumText(sceneId,x002026_g_scriptId,"苏州",-1,1)
			AddNumText(sceneId,x002026_g_scriptId,"少林寺",-1,2)
			AddNumText(sceneId,x002026_g_scriptId,"明教",-1,3)
			AddNumText(sceneId,x002026_g_scriptId,"丐帮",-1,4)
			AddNumText(sceneId,x002026_g_scriptId,"武当山",-1,5)
			AddNumText(sceneId,x002026_g_scriptId,"峨嵋山",-1,6)
			AddNumText(sceneId,x002026_g_scriptId,"星宿海",-1,7)
			AddNumText(sceneId,x002026_g_scriptId,"天龙寺",-1,8)
			AddNumText(sceneId,x002026_g_scriptId,"天山",-1,9)
			AddNumText(sceneId,x002026_g_scriptId,"逍遥派",-1,10)
			AddNumText(sceneId,x002026_g_scriptId,"大理",-1,11)
			AddNumText(sceneId,x002026_g_scriptId,"大理2",-1,12)
			AddNumText(sceneId,x002026_g_scriptId,"大理3",-1,13)
		else
			AddText(sceneId,"10级以上才给传送")
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x002026_OnEventRequest( sceneId, selfId, targetId, eventId )
	if IsHaveMission(sceneId,selfId,4021) > 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"你有漕运货舱在身，我们驿站不能为你提供传送服务。");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		if	GetNumText()==0	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 0,132,183)
		elseif	GetNumText()==1	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 1,164,84)
		elseif	GetNumText()==2	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 9,95,146)
		elseif	GetNumText()==3	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 11, 98, 149)
		elseif	GetNumText()==4	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 10,92,153)
		elseif	GetNumText()==5	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 12,93,182)
		elseif	GetNumText()==6	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 15,89,144)
		elseif	GetNumText()==7	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 16,96,147)
		elseif	GetNumText()==8	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 13,96,139)
		elseif	GetNumText()==9	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 17,94,149)
		elseif	GetNumText()==10	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 14,66,143)
		elseif	GetNumText()==11	then
			if sceneId == 2 then	--如果玩家就在大理1则不传送
				BeginEvent(sceneId)
					AddText(sceneId,"你已经在大理了。");
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			else
				CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 2,241,138)
			end
		elseif	GetNumText()==12	then
			if sceneId == 71 then	--如果玩家就在大理2则不传送
				BeginEvent(sceneId)
					AddText(sceneId,"你已经在大理2了。");
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			else
				CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 71,241,138)
			end
		elseif	GetNumText()==13	then
			if sceneId == 72 then	--如果玩家就在大理3则不传送
				BeginEvent(sceneId)
					AddText(sceneId,"你已经在大理3了。");
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			else
				CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 72,241,138)
			end
		end
	end
end
