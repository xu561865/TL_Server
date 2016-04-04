--找人任务	甘宝宝-〉钟万仇
--万劫谷2

--脚本号
x200902_g_scriptId = 200902

--上一个任务的ID
x200902_g_missionIdPre = 23	

--任务号
x200902_g_missionId = 24

--目标NPC
x200902_g_name	="钟万仇"

--任务名
local  PlayerName=""
x200902_g_missionName="万劫谷2"
x200902_g_missionText_0="原来你是少林派的"
--，唉，这个小冤家，总是给我惹祸，要不是看阁下的面子我才不愿多管她。但是我不能出谷，你把她的情况告诉我丈夫钟万仇吧，他就在XXX，不过你要小心，千万不要说任何姓段的人的事情，最好也不要说和我聊过。"
x200902_g_missionText_1="找到钟灵的父亲钟万仇"
x200902_g_missionText_2="你是谁？到我谷里干什么？"
--告诉你，别打我家宝宝的主意，小心我一刀剁死你！你姓什么？你要是姓段我马上一刀剁死你！"
x200902_g_MoneyBonus=166
x200902_g_ItemBonus={{id=10105001,num=1}}

--**********************************
--任务入口函数
--**********************************
function x200902_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x200902_g_missionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x200902_g_missionId) > 0)  then
		if GetName(sceneId,targetId) == x200902_g_name then
			x200902_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x200902_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200902_g_name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x200902_g_missionName)
			AddText(sceneId,x200902_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x200902_g_missionText_1)
			AddMoneyBonus( sceneId, x200902_g_MoneyBonus )
			for i, item in x200902_g_ItemBonus do
						AddItemBonus( sceneId, item.id, item.num )
					end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x200902_g_scriptId,x200902_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x200902_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x200902_g_missionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x200902_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x200902_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200902_g_name then
			AddNumText(sceneId, x200902_g_scriptId,x200902_g_missionName);
		end
    --满足任务接收条件
    elseif x200902_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200902_g_name then
			AddNumText(sceneId,x200902_g_scriptId,x200902_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x200902_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel( sceneId, selfId ) >= 1 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x200902_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x200902_g_missionId, x200902_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x200902_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x200902_g_missionId )
end

--**********************************
--继续
--**********************************
function x200902_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200902_g_missionName)
     AddText(sceneId,x200902_g_missionText_2)
   AddMoneyBonus( sceneId, x200902_g_MoneyBonus )
    for i, item in x200902_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200902_g_scriptId,x200902_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200902_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x200902_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x200902_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x200902_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x200902_g_MoneyBonus );
			DelMission( sceneId,selfId,  x200902_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x200902_g_missionId )
			CallScriptFunction( 201001, "OnDefaultEvent",sceneId, selfId, targetId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200902_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200902_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200902_OnItemChanged( sceneId, selfId, itemdataId )
end








