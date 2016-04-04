--杀怪任务
--开路先锋

--脚本号
x201701_g_scriptId = 201701

--上一个任务的ID
--g_missionIdPre = 39

--任务号
x201701_g_missionId = 40

--目标NPC
x201701_g_name	="段正明"

--任务文本描述
x201701_g_missionName="开路先锋1"
x201701_g_missionText0="我想让你去帮黄眉大师的忙，可是在这之前先要确认你有这份能力。去杀死10个剑阁白茅草人，然后来我这里。"
x201701_g_missionText1="杀死10个剑阁白茅草人"
x201701_g_missionText2="你已经杀了10个草人吗？"
x201701_g_missionText3="你真快"

x201701_g_MoneyBonus=1032
x201701_g_ItemBonus={{id=30002001,num=5},{id=10412001,num=5}}
x201701_g_RadioItemBonus={{id=10100001,num=1},{id=10210001,num=1},{id=10220001,num=1}}
x201701_g_DemandItem={{id=20004008,num=1}}

--**********************************
--任务入口函数
--**********************************
function x201701_OnDefaultEvent( sceneId, selfId, targetId )

    --如果玩家完成过这个任务
    --if IsMissionHaveDone(sceneId,selfId,x201701_g_missionId) > 0 then
    --	return
    	
    --如果已接此任务
    --else
    if IsHaveMission(sceneId,selfId,x201701_g_missionId) > 0 then
    	--发送任务需求的信息
        BeginEvent(sceneId)
        AddText(sceneId,x201701_g_missionName)
        AddText(sceneId,x201701_g_missionText2)
        EndEvent( )
        bDone = x201701_CheckSubmit( sceneId, selfId )
        DispatchMissionDemandInfo(sceneId,selfId,targetId,x201701_g_scriptId,x201701_g_missionId,bDone)
    		
    --满足任务接收条件
    elseif x201701_CheckAccept(sceneId,selfId) > 0 then
    	--发送任务接受时显示的信息
        BeginEvent(sceneId)
        AddText(sceneId,x201701_g_missionName)
        AddText(sceneId,x201701_g_missionText0)
        AddText(sceneId,"{ID=M_MUBIAO}")
        AddText(sceneId,x201701_g_missionText1)
        AddText(sceneId,"{ID=M_SHOUHUO}")
        AddMoneyBonus( sceneId, x201701_g_MoneyBonus )
        AddText(sceneId,"{ID=M_XUANZE}")
        for i, item in x201701_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
    		for i, item in x201701_g_RadioItemBonus do
					AddRadioItemBonus( sceneId, item.id, item.num )
				end
      	EndEvent( )
      	DispatchMissionInfo(sceneId,selfId,targetId,x201701_g_scriptId,x201701_g_missionId)
    end
end

--**********************************
--列举事件
--**********************************
function x201701_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家还未完成上一个任务
--	if 	IsMissionHaveDone(sceneId,selfId,g_missionIdPre) <= 0 then
--    	return
--    end
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x201701_g_missionId) > 0 then
    	return 

    --如果已接此任务
    else
		if IsHaveMission(sceneId,selfId,x201701_g_missionId) > 0 then
			AddNumText(sceneId,x201701_g_scriptId,x201701_g_missionName);

		--满足任务接收条件
		elseif x201701_CheckAccept(sceneId,selfId) > 0 then
			AddNumText(sceneId,x201701_g_scriptId,x201701_g_missionName);
		end
	end
end

--**********************************
--检测触发条件
--**********************************
function x201701_CheckAccept( sceneId, selfId )
	--bDone = IsMissionHaveDone( sceneId, selfId, g_missionIdPre );
	--if bDone > 0 then
		return 1;
	--else
	--	return 0;
	--end
end

--**********************************
--接受
--**********************************
function x201701_OnAccept( sceneId, selfId )

	--加入任务到玩家列表
	--加入任务物品
	BeginAddItem( sceneId )
	AddItem( sceneId, g_ItemID, 1 )
	ret = EndAddItem( sceneId, selfId )
	
	if ret > 0 then 
		AddItemListToHuman(sceneId,selfId)
		ret = AddMission( sceneId,selfId, x201701_g_missionId, x201701_g_scriptId,1, 0, 0 )
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
				misIndex = GetMissionIndexByID(sceneId,selfId,x201701_g_missionId)
				SetMissionParam(sceneId,selfId,misIndex,0,0)
		end
	end
end

--**********************************
--放弃
--**********************************
function x201701_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x201701_g_missionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, g_ItemID, 1 )
	end
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x201701_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,g_missionRenSubmitInfo);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x201701_g_scriptId,x201701_g_missionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x201701_CheckSubmit( sceneId, selfId )
    --	itemNum = GetItemCount( sceneId, selfId, g_ItemID );
		misIndex = GetMissionIndexByID(sceneId,selfId,x201701_g_missionId)
		num = GetMissionParam(sceneId,selfId,misIndex,0)
		if num < 10 then
			return 0
		else
			return 1
		end
end

--**********************************
--提交（完成）
--**********************************
function x201701_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x201701_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = DelMission( sceneId, selfId, x201701_g_missionId );
		if ret > 0 then
			MissionCom( sceneId, selfId, x201701_g_missionId )
			CallScriptFunction( 201801, "OnDefaultEvent",sceneId, selfId, targetId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x201701_OnKillObject( sceneId, selfId, objdataId )
 if objdataId == 301 then
		misIndex = GetMissionIndexByID(sceneId,selfId,x201701_g_missionId)
		num = GetMissionParam(sceneId,selfId,misIndex,0)
		if num < 10 then
	    SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
	  	BeginEvent(sceneId)
	  	strText = format("已杀死剑阁白茅草人%d/10", GetMissionParam(sceneId,selfId,misIndex,0) )
	  	AddText(sceneId,strText);
	  	EndEvent(sceneId)
	  	DispatchMissionTips(sceneId,selfId)
	  end
	end
end

--**********************************
--进入区域事件
--**********************************
function x201701_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x201701_OnItemChanged( sceneId, selfId, itemdataId )
end
