--找物任务
--大理酒徒2

--脚本号
x200302_g_scriptId = 200302

--前提任务
x200302_g_missionIdPre = 6;

--任务号
x200302_g_missionId = 7

--目标NPC
x200302_g_name	="崔百泉"

--需求物品
x200302_g_DemandItem={{id=10105001,num=1}}

--任务名


--任务文本描述
x200302_g_missionName="大理酒徒"
x200302_g_missionInfo="崔百泉好酒贪杯"
--,而且三杯必倒,人称大理酒徒.你给他一瓶杜康酒喝,他喝醉了一定会说实话的."
x200302_g_missionInfo1="杜康酒本来应该是去酒店买的"
--,不过现在商店系统还没有做完,我先给你一瓶吧."
x200302_g_missionRenWuMuBiao="任务目标：\n把杜康酒交给崔百泉"
x200302_g_missionRenContinueInfo="你也知道我心烦啊,多谢你的酒了."
x200302_g_missionRenSubmitInfo="(……喝酒声)"
--\n慕容博你这老贼!我崔百泉这条命不要了,也一定要剥了你的皮来祭奠我柯师兄!"

--任务奖励
x200302_g_MoneyBonus=2000
x200302_g_ItemBonus={{id=10105001,num=1}}


--**********************************
--任务入口函数
--**********************************
function x200302_OnDefaultEvent( sceneId, selfId, targetId )
	
    --如果已接此任务
    if IsMissionHaveDone( sceneId, selfId, x200302_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x200302_g_missionId) > 0 then
		--发送交任务前的需求信息
    	done = 1;
    	BeginEvent(sceneId)
    	AddText(sceneId,x200302_g_missionRenContinueInfo);
    	for i, item in x200302_g_DemandItem do
    		AddItemDemand( sceneId, item.id, item.num );
    		if done > 0 then
    			itemNum = GetItemCount( sceneId, selfId, item.id );
    			if itemNum < item.num then
    				done = 0
    			end
    		end
    	end
    	EndEvent(sceneId)

  		DispatchMissionDemandInfo(sceneId,selfId,targetId,x200302_g_scriptId,x200302_g_missionId,done)
    --满足任务接收条件
    elseif x200302_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
	    BeginEvent(sceneId)
    	AddText(sceneId,x200302_g_missionName);
    	AddText(sceneId,x200302_g_missionInfo);
    	AddText(sceneId,x200302_g_missionInfo1);
    	AddText(sceneId,x200302_g_missionRenWuMuBiao);
    	for i, item in x200302_g_ItemBonus do
    		AddItemBonus( sceneId, item.id, item.num );
    	end
	    EndEvent(sceneId)
	    DispatchMissionInfo(sceneId,selfId,targetId,x200302_g_scriptId,x200302_g_missionId)
    end
end

--**********************************
--列举事件
--**********************************
function x200302_OnEnumerate( sceneId, selfId, targetId )
    if IsMissionHaveDone( sceneId, selfId, x200302_g_missionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x200302_g_missionId) > 0 then
		AddNumText(sceneId, x200302_g_scriptId,x200302_g_missionName)
    --满足任务接收条件
    elseif x200302_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId, x200302_g_scriptId, x200302_g_missionName);
    end
end

--**********************************
--检测触发条件
--**********************************
function x200302_CheckAccept( sceneId, selfId )
	bDone = IsMissionHaveDone( sceneId, selfId, x200302_g_missionIdPre );
	if bDone > 0 then
		return 1;
	else
		return 0;
	end
end

--**********************************
--接受
--**********************************
function x200302_OnAccept( sceneId, selfId )

	--加入任务到玩家列表
	--加入任务物品
	AddMission( sceneId,selfId, x200302_g_missionId, x200302_g_scriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x200302_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x200302_g_missionId )
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x200302_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x200302_g_missionRenSubmitInfo);
    for i, item in x200302_g_ItemBonus do
    	AddItemBonus( sceneId, item.id, item.num );
    end
	EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x200302_g_scriptId,x200302_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x200302_CheckSubmit( sceneId, selfId )
    for i, item in x200302_g_DemandItem do
    	itemNum = GetItemCount( sceneId, selfId, item.id );
    	if itemNum < item.num then
    		return 0;
    	end
    end
    return 1;
end

--**********************************
--提交（完成）
--**********************************
function x200302_OnSubmit( sceneId, selfId,targetId,selectRadioID )
    ret = x200302_CheckSubmit( sceneId, selfId );
	if ret > 0 then
    	BeginAddItem(sceneId)
		for i, item in x200302_g_ItemBonus do
			AddItem( sceneId, item.id, item.num )
		end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			for i, item in x200302_g_DemandItem do
				DelItem( sceneId, selfId, item.id, item.num )
			end
			--删除玩家任务列表中对应的任务
			ret = DelMission( sceneId, selfId, x200302_g_missionId );
			if ret > 0 then
				MissionCom( sceneId, selfId, x200302_g_missionId )
				CallScriptFunction( 200303, "OnDefaultEvent",sceneId, selfId, targetId)
			end
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x200302_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x200302_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x200302_OnItemChanged( sceneId, selfId, itemdataId )
end
