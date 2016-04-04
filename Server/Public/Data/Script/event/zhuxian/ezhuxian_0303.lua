--找人任务
--大理酒徒3

--脚本号
x200303_g_scriptId = 200303

--前提任务
x200303_g_missionIdPre = 7;

--任务号
x200303_g_missionId = 8

--目标NPC
x200303_g_name	= "段正淳"

--任务名
local  PlayerName=""
x200303_g_missionName="大理酒徒3"
x200303_g_missionText_0="我师兄死于本派不传绝技天灵千碎之下"
--,这一定是姑苏慕容氏下的毒手.崔百泉自知功夫远不如他,但杀兄之仇决不能不报.请转告段王爷,他多年来的关照,崔百泉来生再报了."
x200303_g_missionText_1="找到段正淳并和他交谈"
x200303_g_missionText_2="明知不可为而为之"
--,崔百泉也是一条好汉啊,我原来真是小觑他了."
x200303_g_MoneyBonus=10000
x200303_g_ItemBonus={{id=10105003,num=1}}

--**********************************
--任务入口函数
--**********************************
function x200303_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x200303_g_missionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x200303_g_missionId) > 0)  then
		if GetName(sceneId,targetId) == x200303_g_name then
			x200303_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x200303_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId)~= x200303_g_name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x200303_g_missionName)
			AddText(sceneId,x200303_g_missionText_0)
			AddText(sceneId,"[[任务目标]]")
			AddText(sceneId,x200303_g_missionText_1)
			AddMoneyBonus( sceneId, x200303_g_MoneyBonus )
			for i, item in x200303_g_ItemBonus do
						AddItemBonus( sceneId, item.id, item.num )
					end
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x200303_g_scriptId,x200303_g_missionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x200303_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x200303_g_missionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x200303_g_missionId) > 0 then
		if GetName(sceneId,targetId) == x200303_g_name then
			AddNumText(sceneId, x200303_g_scriptId,x200303_g_missionName);
		end
    --满足任务接收条件
    elseif x200303_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x200303_g_name then
			AddNumText(sceneId,x200303_g_scriptId,x200303_g_missionName);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x200303_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel( sceneId, selfId ) >= 1 then
		return 1
	else
		return 0
	end
end

function x200303_CheckAccept( sceneId, selfId )
	bDone = IsMissionHaveDone( sceneId, selfId, x200303_g_missionIdPre );
	if bDone > 0 then
		return 1;
	else
		return 0;
	end
end
--**********************************
--接受
--**********************************
function x200303_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x200303_g_missionId, x200303_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x200303_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x200303_g_missionId )
end

--**********************************
--继续
--**********************************
function x200303_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200303_g_missionName)
     AddText(sceneId,x200303_g_missionText_2)
   AddMoneyBonus( sceneId, x200303_g_MoneyBonus )
    for i, item in x200303_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200303_g_scriptId,x200303_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200303_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x200303_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x200303_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x200303_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			AddMoney(sceneId,selfId,x200303_g_MoneyBonus );
			DelMission( sceneId,selfId,  x200303_g_missionId )
			--设置任务已经被完成过
			MissionCom( sceneId,selfId,  x200303_g_missionId )
			CallScriptFunction( 200401, "OnDefaultEvent",sceneId, selfId, targetId)
		else
		--任务奖励没有加成功
		end
	        
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200303_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200303_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200303_OnItemChanged( sceneId, selfId, itemdataId )
end
