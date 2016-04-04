--找人任务
--叔侄相逢1

--脚本号
x200201_g_scriptId = 200201

x200201_g_missionIdPre = 2	--上一个任务的ID
--任务号
x200201_g_missionId = 3

--目标NPC
x200201_g_name	="崔百泉" 

--任务名
--local  PlayerName=""
x200201_g_missionName="叔侄相逢1"
x200201_g_missionText_0="金算盘崔百泉"
--……啊呀,好一个酒鬼,居然隐姓埋名在我这里当账房先生!骗得我好苦.\n你去账房找到崔百泉,把过彦之来访的事情告诉他."
x200201_g_missionText_1="任务目标：\n把过彦之来访的事情告诉崔百泉"
x200201_g_missionText_2="我确实是河南伏牛派中人"
--,伏牛派掌门柯百岁是我大师兄.过彦之师侄这一来,我这碗饭算是吃不下去了."
x200201_g_MoneyBonus=777
x200201_g_ItemBonus={{id=10105001,num=1}}

--**********************************
--任务入口函数
--**********************************
function x200201_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x200201_g_missionId) > 0 ) then
    	return
    elseif( IsHaveMission(sceneId,selfId,x200201_g_missionId) > 0)  then
		if GetName(sceneId,targetId) == x200201_g_name then
			x200201_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x200201_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200201_g_name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x200201_g_missionName)
			AddText(sceneId,x200201_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x200201_g_missionText_1)
			AddMoneyBonus( sceneId, x200201_g_MoneyBonus )
			for i, item in x200201_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x200201_g_scriptId,x200201_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x200201_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x200201_g_missionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x200201_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x200201_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200201_g_name then
			AddNumText(sceneId, x200201_g_scriptId,x200201_g_missionName);
		end
    --满足任务接收条件
    elseif x200201_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200201_g_name then
			AddNumText(sceneId,x200201_g_scriptId,x200201_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x200201_CheckAccept( sceneId, selfId )
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
function x200201_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x200201_g_missionId, x200201_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x200201_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x200201_g_missionId )
end

--**********************************
--继续
--**********************************
function x200201_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200201_g_missionName)
     AddText(sceneId,x200201_g_missionText_2)
   AddMoneyBonus( sceneId, x200201_g_MoneyBonus )
    for i, item in x200201_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200201_g_scriptId,x200201_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200201_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x200201_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x200201_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x200201_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x200201_g_MoneyBonus );
			DelMission( sceneId,selfId,  x200201_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x200201_g_missionId )
			CallScriptFunction( 200202, "OnDefaultEvent",sceneId, selfId, targetId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200201_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200201_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200201_OnItemChanged( sceneId, selfId, itemdataId )
end
