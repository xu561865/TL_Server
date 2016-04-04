--断其一指  陈孤雁(陈长老)-->陈孤雁(陈长老)
--程序函数 x201021_OnKillObject 函数带的参数 objdataId 值不对，导致 GetName函数不能正常使用，杨辉正在修改

--脚本号
x201021_g_scriptId = 201021

--上一个任务的ID
x201021_g_missionIdPre = 22	

--任务号
x201021_g_missionId = 66

--目标NPC
x201021_g_name	="陈孤雁"

--刺杀目标
x201021_g_kill_name ="耶律不鲁"

--任务名
local  PlayerName=""
x201021_g_missionName="断其一指"
x201021_g_missionText_0="我正在筹划刺杀辽国左路元帅耶律不鲁，麻烦小兄弟你到敦煌伏击，把他身上的左元帅印带回来给我。"
x201021_g_missionText_1="到敦煌刺杀耶律不鲁"
x201021_g_missionText_2="请问阁下是哪门哪派，到我丐帮有何贵干？"
x201021_g_missionText_3="此任务需要杀死耶律不鲁，取得他的左元帅印"
x201021_g_MoneyBonus=166
--任务物品左元帅印的物品ID号
x201021_g_itemdataId=50101001
x201021_g_ItemBonus={{id=10105001,num=1}}


--**********************************
--任务入口函数
--**********************************
function x201021_OnDefaultEvent( sceneId, selfId, targetId )



    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x201021_g_missionId) > 0 then
    	return
    	
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x201021_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201021_g_name then
    			x201021_OnContinue( sceneId, selfId, targetId )
		end
		
    --满足任务接收条件
    elseif x201021_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x201021_g_name then
    		--发送任务接受时显示的信息
        	BeginEvent(sceneId)
			AddText(sceneId,x201021_g_missionName)
			AddText(sceneId,x201021_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x201021_g_missionText_1)
			AddMoneyBonus( sceneId, x201021_g_MoneyBonus )
			for i, item in x201021_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
		EndEvent(sceneId)
        	DispatchMissionInfo(sceneId,selfId,targetId,x201021_g_scriptId,x201021_g_missionId)
    	end
    end
end

--**********************************
--列举事件
--**********************************
function x201021_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
--    if 	IsMissionHaveDone(sceneId,selfId,x201021_g_missionIdPre) <= 0 then
--    	return
--   end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x201021_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x201021_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x201021_g_name then
			AddNumText(sceneId, x201021_g_scriptId,x201021_g_missionName);
		end
    --满足任务接收条件
    elseif x201021_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x201021_g_name then
			AddNumText(sceneId,x201021_g_scriptId,x201021_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x201021_CheckAccept( sceneId, selfId )
	
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
function x201021_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x201021_g_missionId, x201021_g_scriptId, 1, 0, 0 )
	
end

--**********************************
--放弃
--**********************************
function x201021_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    RemoveTask( sceneId, selfId, x201021_g_missionId )
end

--**********************************
--继续
--**********************************
function x201021_OnContinue( sceneId, selfId, targetId )

	--提交任务时的说明信息
    BeginEvent(sceneId)
    	AddText(sceneId,x201021_g_missionName)
    	AddText(sceneId,x201021_g_missionText_2)
	--提示任务需求道具
	AddItemDemand(sceneId, x201021_g_itemdataId, 1)
	--提示任务金钱奖励
   	AddMoneyBonus( sceneId, x201021_g_MoneyBonus )
    	for i, item in x201021_g_ItemBonus do
		--提示任务物品奖励
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x201021_g_scriptId,x201021_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x201021_CheckSubmit( sceneId, selfId )
	--判断玩家身上是否有左元帅印，有则可以提交任务，没有则不能提交任务
	if HaveItem(sceneId,selfId, x201021_g_itemdataId) ==1 then 
		return 1
	else 
		return 0
	end
end

--**********************************
--提交
--**********************************
function x201021_OnSubmit( sceneId, selfId )

	if x201021_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
    		BeginAddItem(sceneId)
		for i, item in x201021_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x201021_g_MoneyBonus );
			DelMission( sceneId,selfId,  x201021_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x201021_g_missionId )
			--删除左元帅印
			DelItem(sceneId,selfId,x201021_g_itemdataId,1)
		else
		--任务奖励没有加成功
		end
	else
		BeginEvent(sceneId)
			AddText(sceneId,x201021_g_missionText_3)
		EndEvent(sceneId)  
	end
    
end

--**********************************
--杀死指定类型怪物
--**********************************
function x201021_OnKillObject( sceneId, selfId, objdataId )

--调试用语句

	--如果杀死的是耶律不鲁,系统掉落力量左元帅印
	if GetName(sceneId,objdataId) == x201021_g_kill_name then 
		AddItem(sceneId,selfId,x201021_g_itemdataId,1)
	end
end

--**********************************
--进入区域事件
--**********************************
function x201021_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x201021_OnItemChanged( sceneId, selfId, itemdataId )

end
