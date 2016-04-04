--洛阳NPC
--诸葛孔亮
--算命，以后可能成为循环任务

--**********************************
--事件交互入口
--**********************************
function x000077_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local	i=random(0,1)
		if	i<=0	 then
			AddText(sceneId,"你这相凶险无比，需要十两卦金让太上老君开眼，才有得解救。")
		else
			AddText(sceneId,"多么大富大贵的宝相啊！你这么有福的人不介意付十两卦金吧？")
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
