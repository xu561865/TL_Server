--找人任务
--重归于好3

--脚本号
x200603_g_scriptId = 200603

--前提任务
x200603_g_missionIdPre = 14;

--任务号
x200603_g_missionId = 15

--目标NPC
x200603_g_name	="蔡卞" 

--任务名
local  PlayerName=""
x200603_g_missionName="重归于好3"
x200603_g_missionText_0="那么说，你还是蔡卞派来的人"
--？坦率的说，我并非对蔡卞有多么大的成见，只是他哥哥的所作所为太让我不齿了。"
x200603_g_missionText_1="请你转告蔡卞大人，我吕惠卿不会因私人成见耽误国家大事的，请他放心好了。"
x200603_g_missionText_2=PlayerName.."辛苦了"
--，既然吕惠卿老相国已经消除成见，我就可以展开手脚大干一场了。"
x200603_g_MoneyBonus=100
x200603_g_ItemBonus={{id=10105001,num=1}}

--**********************************
--任务入口函数
--**********************************
function x200603_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x200603_g_missionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x200603_g_missionId) > 0)  then
		if GetName(sceneId,targetId) == x200603_g_name then
			x200603_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x200603_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200603_g_name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x200603_g_missionName)
			AddText(sceneId,x200603_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x200603_g_missionText_1)
			AddMoneyBonus( sceneId, x200603_g_MoneyBonus )
			for i, item in x200603_g_ItemBonus do
						AddItemBonus( sceneId, item.id, item.num )
					end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x200603_g_scriptId,x200603_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x200603_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x200603_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x200603_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200603_g_name then
			AddNumText(sceneId, x200603_g_scriptId,x200603_g_missionName);
		end
    --满足任务接收条件
    elseif x200603_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200603_g_name then
			AddNumText(sceneId,x200603_g_scriptId,x200603_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x200603_CheckAccept( sceneId, selfId )
	bDone = IsMissionHaveDone( sceneId, selfId, x200603_g_missionIdPre );
	if bDone > 0 then
		return 1;
	else
		return 0;
	end
end

--**********************************
--接受
--**********************************
function x200603_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x200603_g_missionId, x200603_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x200603_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x200603_g_missionId )
end

--**********************************
--继续
--**********************************
function x200603_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200603_g_missionName)
     AddText(sceneId,x200603_g_missionText_2)
   AddMoneyBonus( sceneId, x200603_g_MoneyBonus )
    for i, item in x200603_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200603_g_scriptId,x200603_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200603_CheckSubmit( sceneId, selfId )
	itemNum = GetItemCount( sceneId, selfId, g_ItemID );
    if itemNum > 0 then
    	return 1;
    end
	return 0
end

--**********************************
--提交
--**********************************
function x200603_OnSubmit( sceneId, selfId,targetId,  selectRadioId )
	if x200603_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x200603_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x200603_g_MoneyBonus );
			DelMission( sceneId,selfId,  x200603_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x200603_g_missionId )
			CallScriptFunction( 200604, "OnDefaultEvent",sceneId, selfId, targetId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200603_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200603_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200603_OnItemChanged( sceneId, selfId, itemdataId )
end







