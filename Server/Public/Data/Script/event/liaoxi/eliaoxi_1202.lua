--打开生长点    1接任务得到任务物品 2带着任务打怪得到第二件任务物品 3带着任务和2个任务物品打开生长点 
--驱赶黑蜂
--MisDescBegin
--脚本号
x211202_g_ScriptId = 211202

--上一个任务的ID
--g_MissionIdPre = 39

--任务号
x211202_g_MissionId = 552

--目标NPC
x211202_g_Name	="伯颜"

--任务道具编号
x211202_g_ItemId1 =40002069				--狼粪

--任务道具需求数量
x211202_g_ItemNeedNum1 = 1				

--打怪时需要带在身上的道具编号
x211202_g_ItemId2 = 40002070			--火折子

--打怪时需要带在身上的道具的数量
x211202_g_ItemNeedNum2 = 1

--任务归类
x211202_g_MissionKind = 32

--任务等级
x211202_g_MissionLevel = 57

--是否是精英任务
x211202_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况
--任务是否已经完成
x211202_g_IsMissionOkFail = 0		--变量的第0位

--自定义
x211202_g_Custom={{id="已驱赶黑蜂",num=1}}	--变量的第一位

--任务文本描述
x211202_g_MissionName="驱赶黑蜂"
x211202_g_MissionInfo="这里黑蜂成群,你看天上,黑压压的一片,连阳光都挡住了.你拿着这个火折子,再找到一堆干狼粪,点燃烽火台就能驱走黑蜂"  --任务描述
x211202_g_MissionTarget="在烽火台点燃干狼粪,驱赶黑蜂"		--任务目标
x211202_g_ContinueInfo="你要先杀死草原狼,得到一堆干狼粪,然后到烽火台点燃,就能驱赶黑蜂了"		--未完成任务的npc对话
x211202_g_MissionComplete="干得不错"					--完成任务npc说的话

x211202_g_MoneyBonus=1032
x211202_g_ItemBonus={{id=30002001,num=1},{id=10412001,num=1}}
x211202_g_RadioItemBonus={{id=10100001,num=1},{id=10210001,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211202_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
    --if IsMissionHaveDone(sceneId,selfId,x211202_g_MissionId) > 0 then
	--	return
	--end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x211202_g_MissionId) > 0 then
		--发送任务需求的信息
		BeginEvent(sceneId)
		AddText(sceneId,x211202_g_MissionName)
		AddText(sceneId,x211202_g_ContinueInfo)
		--for i, item in g_DemandItem do
		--			AddItemDemand( sceneId, item.id, item.num )
		--end
		EndEvent( )
		bDone = x211202_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x211202_g_ScriptId,x211202_g_MissionId,bDone)
	--满足任务接收条件
	elseif x211202_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,x211202_g_MissionName)
		AddText(sceneId,x211202_g_MissionInfo)
		AddText(sceneId,"#{M_MUBIAO}")
		AddText(sceneId,x211202_g_MissionTarget)
		AddMoneyBonus( sceneId, x211202_g_MoneyBonus )
		for i, item in x211202_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
			for i, item in x211202_g_RadioItemBonus do
					AddRadioItemBonus( sceneId, item.id, item.num )
				end
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x211202_g_ScriptId,x211202_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x211202_OnEnumerate( sceneId, selfId, targetId )

    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x211202_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    --else
    if IsHaveMission(sceneId,selfId,x211202_g_MissionId) > 0 then
		AddNumText(sceneId,x211202_g_ScriptId,x211202_g_MissionName);

    --满足任务接收条件
    elseif x211202_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x211202_g_ScriptId,x211202_g_MissionName);
    end

end

--**********************************
--检测接受条件
--**********************************
function x211202_CheckAccept( sceneId, selfId )

	--需要2级才能接
	if GetLevel( sceneId, selfId ) >= 1 then
		return 1
	else
		return 0
	end

end

--**********************************
--接受
--**********************************
function x211202_OnAccept( sceneId, selfId )
	BeginAddItem( sceneId )
	AddItem( sceneId, x211202_g_ItemId2, 1 )
	ret = EndAddItem( sceneId, selfId )
	--加入任务到玩家列表
	if ret >0 then
		ret = AddMission( sceneId,selfId, x211202_g_MissionId, x211202_g_ScriptId, 1, 0, 0 )
		--if ret >0 then
			AddItemListToHuman(sceneId,selfId)
		--end
	end
end

--**********************************
--放弃
--**********************************
function x211202_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    ret = DelMission( sceneId, selfId, x211202_g_MissionId )
	--if ret >0 then
		DelItem ( sceneId,selfId,x211202_g_ItemId2,1)
	--end	
end

--**********************************
--继续
--**********************************
function x211202_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x211202_g_MissionName)
    AddText(sceneId,x211202_g_MissionComplete)
    AddMoneyBonus( sceneId, x211202_g_MoneyBonus )
    for i, item in x211202_g_ItemBonus do
		AddItemBonus( sceneId, item.id, item.num )
	end
    for i, item in x211202_g_RadioItemBonus do
		AddRadioItemBonus( sceneId, item.id, item.num )
	end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x211202_g_ScriptId,x211202_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211202_CheckSubmit( sceneId, selfId )

--  for i, item in g_DemandItem do
--		itemCount = GetItemCount( sceneId, selfId, item.id )
--		if itemCount < item.num then
--			return 0
--		end
--	end
--	return 1
	
	misIndex = GetMissionIndexByID(sceneId,selfId,x211202_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,0)
    
    if num == 1 then
       return 1
    end
	return 0
end

--**********************************
--提交
--**********************************
function x211202_OnSubmit( sceneId, selfId, targetId,selectRadioId )
		
	if x211202_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
		for i, item in x211202_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		for i, item in x211202_g_RadioItemBonus do
			if item.id == selectRadioId then
				AddItem( sceneId,item.id, item.num )
			end
		end
		
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x211202_g_MoneyBonus );
			--扣除任务物品
			--for i, item in g_DemandItem do
			--	DelItem( sceneId, selfId, item.id, item.num )
			--end
			ret = DelMission( sceneId, selfId, x211202_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId,selfId, x211202_g_MissionId )
				AddItemListToHuman(sceneId,selfId)
			end
		else
		--任务奖励没有加成功
			BeginEvent(sceneId)
				strText = "背包已满,无法完成任务"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end      
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x211202_OnKillObject( sceneId, selfId, objdataId ,objId)--参数意思：场景号、玩家objId、怪物表位置号、怪物objId
	if objdataId == 1810 then
		num = GetMonsterOwnerCount(sceneId,objId)--取得这个怪物死后拥有分配权的人数
		for i=0,num-1 do
			humanObjId = GetMonsterOwnerID(sceneId,objId,i)--取得拥有分配权的人的objId
			if IsHaveMission(sceneId,humanObjId,x211202_g_MissionId) > 0 then	--如果这个人拥有任务	
				if (GetItemCount(sceneId,humanObjId,x211202_g_ItemId1) < x211202_g_ItemNeedNum1) then	--检测是否已经拿到足够的任务物品
					if (HaveItem (sceneId,humanObjId,x211202_g_ItemId2) > 0) then	--检测身上是否带有需要带的任务道具
						AddMonsterDropItem(sceneId,objId,humanObjId,x211202_g_ItemId1)    --给这个人任务道具(道具会出现在尸体包里)
					end
				end
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x211202_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211202_OnItemChanged( sceneId, selfId, itemdataId )
end
