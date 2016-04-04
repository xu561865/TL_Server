--七级浮屠	陈孤雁-〉白世镜
--目前DelItem函数有错误，返回成功，但是道具未删除。待程序修正
--丐帮

--脚本号
x201121_g_scriptId = 201121

x201121_g_missionIdPre = 66	--上一个任务的ID

--任务号
x201121_g_missionId = 67

--目标NPC
x201121_g_name	="白世镜"

--蝎毒解药ID, 暂时用芍药代替
x201121_g_XieDuJieYao = 20001001

--任务名
local  PlayerName=""
x201121_g_missionName="七级浮屠"
x201121_g_missionText_0="我给你两份解药，请帮我送一份给帮主白世镜。"
x201121_g_missionText_1="拿一份解药给白世镜"
x201121_g_missionText_2="请问阁下是哪门哪派，到我丐帮有何贵干？"
x201121_g_MoneyBonus=166
x201121_g_ItemBonus={{id=10100000,num=1}}

--**********************************
--任务入口函数
--**********************************
function x201121_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x201121_g_missionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x201121_g_missionId) > 0)  then
		if GetName(sceneId,targetId) == x201121_g_name then
			x201121_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x201121_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201121_g_name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x201121_g_missionName)
			AddText(sceneId,x201121_g_missionText_0)
			AddText(sceneId,"任务目标")
			AddText(sceneId,x201121_g_missionText_1)
			AddMoneyBonus( sceneId, x201121_g_MoneyBonus )
			--for i, item in x201121_g_ItemBonus do
			--	AddItemBonus( sceneId, item.id, item.num )
			--end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x201121_g_scriptId,x201121_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x201121_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
--    if 	IsMissionHaveDone(sceneId,selfId,x201121_g_missionIdPre) <= 0 then
--    	return
--   end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x201121_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x201121_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201121_g_name then
			AddNumText(sceneId, x201121_g_scriptId,x201121_g_missionName);
		end
    --满足任务接收条件
    elseif x201121_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x201121_g_name then
			AddNumText(sceneId,x201121_g_scriptId,x201121_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x201121_CheckAccept( sceneId, selfId )
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
function x201121_OnAccept( sceneId, selfId )
	--添加两份解药给玩家
	BeginAddItem(sceneId)
		AddItem( sceneId,x201121_g_XieDuJieYao, 2 )
	if EndAddItem(sceneId,selfId) > 0 then
		AddItemListToHuman(sceneId,selfId)
	else
		Msg2Player(sceneId, selfId, "请检查背包是否已满",MSG2PLAYER_PARA)
		return
	end
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x201121_g_missionId, x201121_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x201121_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x201121_g_missionId )
end

--**********************************
--继续
--**********************************
function x201121_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x201121_g_missionName)
     AddText(sceneId,x201121_g_missionText_2)
   AddMoneyBonus( sceneId, x201121_g_MoneyBonus )
    --for i, item in x201121_g_ItemBonus do
	--	AddItemBonus( sceneId, item.id, item.num )
	--end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x201121_g_scriptId,x201121_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x201121_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x201121_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x201121_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x201121_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
	ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x201121_g_MoneyBonus );
			DelMission( sceneId,selfId,  x201121_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x201121_g_missionId )
			--删除一个蝎毒解药
			DelItem(sceneId, selfId, x201121_g_XieDuJieYao, 1)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x201121_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x201121_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x201121_OnItemChanged( sceneId, selfId, itemdataId )
end



