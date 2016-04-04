--苏州NPC
--李乘风
--普通

x001028_g_scriptId=001028

--**********************************
--事件交互入口
--**********************************
function x001028_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你想去哪里？")
		AddNumText(sceneId,x001028_g_scriptId,"洛阳",-1,0)
		AddNumText(sceneId,x001028_g_scriptId,"大理",-1,1)
		AddNumText(sceneId,x001028_g_scriptId,"少林寺",-1,2)
		AddNumText(sceneId,x001028_g_scriptId,"明教",-1,3)
		AddNumText(sceneId,x001028_g_scriptId,"丐帮",-1,4)
		AddNumText(sceneId,x001028_g_scriptId,"武当山",-1,5)
		AddNumText(sceneId,x001028_g_scriptId,"峨嵋山",-1,6)
		AddNumText(sceneId,x001028_g_scriptId,"星宿海",-1,7)
		AddNumText(sceneId,x001028_g_scriptId,"天龙寺",-1,8)
		AddNumText(sceneId,x001028_g_scriptId,"天山",-1,9)
		AddNumText(sceneId,x001028_g_scriptId,"逍遥派",-1,10)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x001028_OnEventRequest( sceneId, selfId, targetId, eventId )
	if IsHaveMission(sceneId,selfId,4021) > 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"你有漕运货舱在身，我们驿站不能为你提供传送服务。");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		if	GetNumText()==0	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 0,132,183)
		elseif	GetNumText()==1	then
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 2,241,141)
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
		end
	end
end
