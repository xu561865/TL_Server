--获得称号
--雁北

--脚本号
x804022_g_scriptId = 804022
--任务号
x804022_g_missionId = 4022


local  PlayerName=""
--任务名
x804022_g_missionName="称号"
x804022_g_missionText_0="称号,人在江湖,扬名立万"
x804022_g_missionText_1="昭武校尉"

x804022_g_missionText_2="你是谁？到我谷里干什么？"

x804022_g_MoneyBonus=80000
x804022_g_ItemBonus={{id=10101001,num=1}}

--**********************************
--任务入口函数
--**********************************
function x804022_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
	if( IsHaveMission(sceneId,selfId,x804022_g_missionId) > 0)  then
		if x804022_CheckSubmit(sceneId,selfId) == 1 then
			BeginEvent(sceneId)
			AddText(sceneId,x804022_g_missionName)
			AddMoneyBonus( sceneId, x804022_g_MoneyBonus )
			EndEvent()
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x804022_g_scriptId,x804022_g_missionId,1)
		else
			BeginEvent(sceneId)
			AddText(sceneId,x804022_g_missionName)
			AddText(sceneId,"无名之辈")
			EndEvent( )
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x804022_g_scriptId,x804022_g_missionId,0)
		end
			
    --满足任务接收条件
  elseif x804022_CheckAccept(sceneId,selfId) > 0 then
		name = GetName(sceneId,selfId)
		playname = format("玩家的名字是:%s\n",name)
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,x804022_g_missionName)
		AddText(sceneId,x804022_g_missionText_0)
		AddText(sceneId,playname)
		AddText(sceneId,x804022_g_missionText_1)
		AddMoneyBonus( sceneId, x804022_g_MoneyBonus )
		for i, item in x804022_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x804022_g_scriptId,x804022_g_missionId)
  end
end

--**********************************
--列举事件
--**********************************
function x804022_OnEnumerate( sceneId, selfId, targetId )
   if IsHaveMission(sceneId,selfId,x804022_g_missionId) > 0 then
		--if GetName(sceneId,targetId) == g_name then
			AddNumText(sceneId, x804022_g_scriptId,x804022_g_missionName);
		--end
    --满足任务接收条件
   elseif x804022_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x804022_g_scriptId,x804022_g_missionName)
   end
end

--**********************************
--检测接受条件
--**********************************
function x804022_CheckAccept( sceneId, selfId )
	return 1	
end

--**********************************
--接受
--**********************************
function x804022_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x804022_g_missionId, x804022_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x804022_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x804022_g_missionId )
end

--**********************************
--继续
--**********************************
function x804022_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x804022_g_missionName)
     AddText(sceneId,x804022_g_missionText_2)
   AddMoneyBonus( sceneId, x804022_g_MoneyBonus )
    for i, item in x804022_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x804022_g_scriptId,x804022_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x804022_CheckSubmit( sceneId, 	selfId )
	if GetTitle(sceneId,selfId,3) == 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x804022_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x804022_CheckSubmit( sceneId, selfId ) then
    BeginAddItem(sceneId)
		for i, item in x804022_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x804022_g_MoneyBonus );
			DelItem(sceneId,selfId,20001003,1)
			DelMission( sceneId,selfId,  x804022_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x804022_g_missionId )
			--CallScriptFunction( 201001, "OnDefaultEvent",sceneId, selfId, targetId)
			NewWorld(sceneId,selfId,19,10,10)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x804022_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x804022_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x804022_OnItemChanged( sceneId, selfId, itemdataId )
end








