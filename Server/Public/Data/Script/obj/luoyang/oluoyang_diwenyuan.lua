--洛阳NPC
--狄文远
--普通

--脚本号
x000083_g_scriptId = 000083

x000083_g_missionName = "更改阵营"

--**********************************
--事件列表
--**********************************
function x000083_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerName=GetName(sceneId,selfId)
		AddText(sceneId,"你想要在江湖上快意恩仇吗，"..PlayerName.."？同时你要冒着被别人快意恩仇的风险啊。");
		--如果玩家完成过这个任务
		if GetCurCamp (sceneId, selfId) == 1 then
			AddNumText(sceneId, x000083_g_scriptId,"回复初始阵营",-1,0);
		--满足任务接收条件
		else
			AddNumText(sceneId,x000083_g_scriptId,"设置PK阵营",-1,1);
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


--**********************************
--事件交互入口
--**********************************
function x000083_OnDefaultEvent( sceneId, selfId,targetId )
	x000083_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000083_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
			SetCurCamp (sceneId, selfId, 0)
		BeginEvent(sceneId)
  			AddText(sceneId,"你已经回复到初始阵营。");
  		EndEvent(sceneId)
  		DispatchMissionTips(sceneId,selfId)
	elseif	GetNumText()==1	then
		SetCurCamp (sceneId, selfId, 1 )
		BeginEvent(sceneId)
	  		AddText(sceneId,"你已经设置为PK阵营。");
		EndEvent(sceneId)
	  	DispatchMissionTips(sceneId,selfId)
	end
end
