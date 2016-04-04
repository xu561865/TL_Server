--循环任务
--召集同伴
--************************************************************************
--MisDescBegin
--脚本号
x210211_g_ScriptId = 210211

--上一个任务的ID
x210211_g_MissionIdPre =450

--任务号
x210211_g_MissionId = 451

--任务目标npc
x210211_g_Name	="孙八爷" 

x210211_g_ItemId	=40002107

--任务归类
x210211_g_MissionKind = 13

--任务等级
x210211_g_MissionLevel = 3

--是否是精英任务
x210211_g_IfMissionElite = 0

--********下面几项是动态显示的内容，用于在任务列表中动态显示任务情况******
x210211_g_IsMissionOkFail = 0					--变量的第0位
--**********************************以上是动态****************************


--任务文本描述
x210211_g_MissionName="新手：召集弟兄"
x210211_g_MissionInfo="九大门派的高手们想请一些师兄弟来大理，提升武林大会的人气。武林中人的通讯方法好厉害的，你只要去宣武台上，找一个合适的地方，点燃这个传讯焰火就可以了。"  --任务描述
x210211_g_MissionTarget="在宣武台上释放传讯焰火"		--任务目标
x210211_g_ContinueInfo="放了吗？"		--未完成任务的npc对话
x210211_g_MissionComplete="干的不错"					--完成任务npc说话的话
x210211_g_ItemBonus={{id=10111000,num=1}}
x210211_g_SignPost = {x = 172, z = 131, tip = "孙八爷"}
x210211_g_MoneyBonus=360

--MisDescEnd
--************************************************************************

--角色Mission变量说明
--0号：任务状态
--1号：
--2号：所在场景编号
--3号：指定x坐标
--4号：指定z坐标
--5号：未用
--6号：未用
--7号：未用

--宝藏位置
x210211_g_TreasureAddress = {	{scene=2,x=104,z=221},
						{scene=2,x=104,z=201},
--						{scene=2,x=242,z=55},
--						{scene=2,x=202,z=237},
--						{scene=2,x=255,z=232},
--						{scene=2,x=82,z=220},
--						{scene=2,x=46,z=255},
--						{scene=2,x=44,z=151},
						{scene=2,x=79,z=222}}

--**********************************
--任务入口函数
--**********************************
function x210211_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	if IsHaveMission(sceneId,selfId,x210211_g_MissionId) > 0 then
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210211_g_MissionName)
			AddText(sceneId,x210211_g_ContinueInfo)
			AddMoneyBonus( sceneId, x210211_g_MoneyBonus )
		EndEvent( )
		bDone = x210211_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210211_g_ScriptId,x210211_g_MissionId,bDone)
	--满足任务接收条件
	elseif x210211_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210211_g_MissionName)
			AddText(sceneId,x210211_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}#r")
			AddText(sceneId,x210211_g_MissionTarget)
			for i, item in x210211_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
			AddMoneyBonus( sceneId, x210211_g_MoneyBonus )
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x210211_g_ScriptId,x210211_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210211_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x210211_g_MissionIdPre) <= 0 then
    	return
    end
	if IsMissionHaveDone(sceneId,selfId,x210211_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210211_g_MissionId) > 0 then
		AddNumText(sceneId,x210211_g_ScriptId,x210211_g_MissionName,2,-1);
    --满足任务接收条件
    elseif x210211_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x210211_g_ScriptId,x210211_g_MissionName,1,-1);
    end
end

--**********************************
--检测接受条件
--**********************************
function x210211_CheckAccept( sceneId, selfId )
	--需要3级才能接
	if GetLevel( sceneId, selfId ) >= 3 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210211_OnAccept( sceneId, selfId )

	if x210211_CheckAccept(sceneId, selfId )<=0 then
		return
	end
	
	x210211_g_sequence = random(3)					--根据宝物地点总数获得一个随机数
	SceneNum = x210211_g_TreasureAddress[x210211_g_sequence].scene
	X		 = x210211_g_TreasureAddress[x210211_g_sequence].x
	Z		 = x210211_g_TreasureAddress[x210211_g_sequence].z
	--添加烟花
	BeginAddItem(sceneId)
		ret = AddItem( sceneId,x210211_g_ItemId, 1 )
	EndAddItem(sceneId,selfId)
	--加入任务到玩家列表
	ret = AddMission( sceneId,selfId, x210211_g_MissionId, x210211_g_ScriptId, 0, 0, 1 )

	--设置任务变量宝物的场景编号和坐标位置
	misIndex = GetMissionIndexByID(sceneId,selfId,x210211_g_MissionId)		--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)					--根据序列号把任务变量的第一位置0	第一位是完成/失败情况
	SetMissionByIndex(sceneId,selfId,misIndex,2,SceneNum)			--把第三位置为宝物的场景编号
	SetMissionByIndex(sceneId,selfId,misIndex,3,X)					--把第四位置为宝物的X坐标
	SetMissionByIndex(sceneId,selfId,misIndex,4,Z)					--把第五位置为宝物的Z坐标
	
	AddItemListToHuman(sceneId,selfId)
	Msg2Player(  sceneId, selfId,"#Y接受任务：召集弟兄",MSG2PLAYER_PARA )
	CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210211_g_SignPost.x, x210211_g_SignPost.z, x210211_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210211_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x210211_g_MissionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, x210211_g_ItemId, 1 )
	end
end

--**********************************
--继续
--**********************************
function x210211_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210211_g_MissionName)
		AddText(sceneId,x210211_g_MissionComplete)
		AddMoneyBonus( sceneId, x210211_g_MoneyBonus )
		for i, item in x210211_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210211_g_ScriptId,x210211_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210211_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x210211_g_MissionId)
	x210211_g_MissionCondition = GetMissionParam(sceneId,selfId,misIndex,0)		--获得任务状态
	if	x210211_g_MissionCondition>=1	then
		return	1
	else
		return	0
	end
end

--**********************************
--提交
--**********************************
function x210211_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x210211_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in x210211_g_ItemBonus do
				AddItem( sceneId,item.id, item.num )
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
			if ret > 0 then
					AddMoney(sceneId,selfId,x210211_g_MoneyBonus );
					LuaFnAddExp( sceneId, selfId,200)
					ret = DelMission( sceneId, selfId, x210211_g_MissionId )
				if ret > 0 then
					MissionCom( sceneId, selfId, x210211_g_MissionId )
					AddItemListToHuman(sceneId,selfId)
					Msg2Player(  sceneId, selfId,"#Y完成任务：召集弟兄",MSG2PLAYER_PARA )
					CallScriptFunction( 210212, "OnDefaultEvent",sceneId, selfId, targetId)
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
function x210211_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210211_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210211_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--道具使用
--**********************************
function x210211_OnUseItem( sceneId, selfId, targetId, eventId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x210211_g_MissionId)
	x210211_g_MissionCondition = GetMissionParam(sceneId,selfId,misIndex,0)		--获得任务状态
	scene = GetMissionParam(sceneId,selfId,misIndex,2)					--获得宝物场景号
	treasureX = GetMissionParam(sceneId,selfId,misIndex,3)				--获得宝物X坐标
	treasureZ = GetMissionParam(sceneId,selfId,misIndex,4)				--获得宝物Z坐标	
	--如果任务已经完成
	if x210211_g_MissionCondition == 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"施放传讯焰火成功")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--取得玩家当前坐标
	PlayerX = GetHumanWorldX(sceneId,selfId)
	PlayerZ = GetHumanWorldZ(sceneId,selfId)
	--计算玩家与宝藏的距离
	Distance = floor(sqrt((treasureX-PlayerX)*(treasureX-PlayerX)+(treasureZ-PlayerZ)*(treasureZ-PlayerZ)))
	if sceneId ~= scene then
		BeginEvent(sceneId)
			AddText(sceneId,"似乎在这个场景不能施放传讯焰火")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	if Distance > 2 then
		BeginEvent(sceneId)
			AddText(sceneId,"距离施放传讯焰火的地方还有"..Distance.."米")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	elseif Distance <= 2 then
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)		--把任务状态变量设置为1,表示已经完成
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210211_g_SignPost.x, x210211_g_SignPost.z, x210211_g_SignPost.tip )
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 4820, 0);
		BeginEvent(sceneId)
			AddText(sceneId,"各大门派弟子们闻讯纷纷赶来")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		DelItem( sceneId, selfId, x210211_g_ItemId, 1 )
	end
end
