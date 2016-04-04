--洛阳NPC
--彭怀玉
--普通

--**********************************
--事件交互入口
--**********************************
function x000110_OnDefaultEvent( sceneId, selfId,targetId )

	
	BeginEvent(sceneId)

		AddText(sceneId,"你可以把两颗相同的宝石合成为一颗高一级的宝石，每次合成消耗(宝石等级*10)点精力。")
		AddNumText(sceneId,g_scriptId,"宝石合成",-1,0)

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	
end


--**********************************
--事件列表选中一项
--**********************************

function x000110_OnEventRequest( sceneId, selfId, targetId, eventId )

		if	GetNumText()==0	then
		
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,targetId)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 23)
			
			return
		end
		
end
