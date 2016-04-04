--练宠任务

--************************************************************************
--MisDescBegin

--脚本号
x210215_g_ScriptId = 210215

--上一个任务的ID
x210215_g_MissionIdPre = 454

--任务号
x210215_g_MissionId = 455

--任务目标npc
x210215_g_Name	="云飘飘" 

--任务归类
x210215_g_MissionKind = 13

--任务等级
x210215_g_MissionLevel = 5

--是否是精英任务
x210215_g_IfMissionElite = 0

--********下面几项是动态显示的内容，用于在任务列表中动态显示任务情况******

--**********************************以上是动态****************************

--任务文本描述
x210215_g_MissionName="新手：修练宠物"
x210215_g_MissionInfo="这么快就学会了？真不错，现在帮我把小兔子练到2级，让我看看你学的怎么样。## 去剑阁或者无量山把小兔子练到2级。"  --任务描述
x210215_g_MissionTarget="把云飘飘的小兔子练到2级"		--任务目标
x210215_g_ContinueInfo="小兔子还没练到2级吗？"		--未完成任务的npc对话
x210215_g_MissionComplete="嗯，不错，做的挺好，现在你回去找赵天师吧。"					--完成任务npc说话的话
x210215_g_SignPost = {x = 263, z = 129, tip = "云飘飘"}

--任务奖励
x210215_g_MoneyBonus=100
x210215_g_ItemBonus={{id=40002108,num=1}}

--MisDescEnd
--************************************************************************

--角色Mission变量说明
--0号：未用
--1号：未用
--2号：未用
--3号：未用
--4号：未用
--5号：未用
--6号：未用
--7号：未用
x210215_g_PetNeedLevel=2	--需要将宠物练到的等级
x210215_g_PetDataID=3500	--任务宠物的编号

--**********************************
--任务入口函数
--**********************************
function x210215_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	
	if IsHaveMission(sceneId,selfId,x210215_g_MissionId) > 0 then --如果已接此任务
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210215_g_MissionName)
			AddText(sceneId,x210215_g_ContinueInfo)
			AddMoneyBonus( sceneId, x210215_g_MoneyBonus )
		EndEvent( )
		bDone = x210215_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210215_g_ScriptId,x210215_g_MissionId,bDone)
	elseif x210215_CheckAccept(sceneId,selfId) > 0 then --满足任务接收条件
		--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210215_g_MissionName)
				AddText(sceneId,x210215_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210215_g_MissionTarget)
				for i, item in x210215_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
				AddMoneyBonus( sceneId, x210215_g_MoneyBonus )
				EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210215_g_ScriptId,x210215_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210215_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家还未完成上一个任务
    if 	IsMissionHaveDone(sceneId,selfId,x210215_g_MissionIdPre) <= 0 then
    	return
    end
    --如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210215_g_MissionId) > 0 then
		return 
	end
    if IsHaveMission(sceneId,selfId,x210215_g_MissionId) > 0 then
			AddNumText(sceneId,x210215_g_ScriptId,x210215_g_MissionName,2,-1);
		--满足任务接收条件
	elseif x210215_CheckAccept(sceneId,selfId) > 0 then
			AddNumText(sceneId,x210215_g_ScriptId,x210215_g_MissionName,1,-1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210215_CheckAccept( sceneId, selfId )
	--接收条件
	if GetLevel( sceneId, selfId ) >= x210215_g_MissionLevel then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210215_OnAccept( sceneId, selfId )
	local ret = LuaFnCreatePet(sceneId, selfId, x210215_g_PetDataID ) --给玩家生成一只宠物
	if ret==1 then
		--加入任务到玩家列表
		AddMission( sceneId,selfId, x210215_g_MissionId, x210215_g_ScriptId, 0, 0, 0 )	--添加任务
		BeginEvent(sceneId)
			strText = "你得到了一个宠物!"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		Msg2Player(  sceneId, selfId,"#Y接受任务：修炼宠物",MSG2PLAYER_PARA )
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210215_g_SignPost.x, x210215_g_SignPost.z, x210215_g_SignPost.tip )
	end
end

--**********************************
--放弃
--**********************************
function x210215_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210215_g_MissionId )
    
    --删除任务宠物
	petcount = LuaFnGetPetCount(sceneId, selfId) --取得宠物数量
	for	i=0,petcount-1 do
		petdataid = LuaFnGetPet_DataID(sceneId, selfId, i) --取得宠物编号
		if petdataid==x210215_g_PetDataID then
			ret0 = LuaFnDeletePet(sceneId, selfId, i)
		end
    end
end

--**********************************
--继续
--**********************************
function x210215_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210215_g_MissionName)
		AddText(sceneId,x210215_g_MissionComplete)
		AddMoneyBonus( sceneId, x210215_g_MoneyBonus )
		for i, item in x210215_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210215_g_ScriptId,x210215_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210215_CheckSubmit( sceneId, selfId )
	return 2
end

--**********************************
--提交
--**********************************
function x210215_OnSubmit( sceneId, selfId, targetId,selectRadioId )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210215_OnKillObject( sceneId, selfId, objdataId, objId )
end

--**********************************
--进入区域事件
--**********************************
function x210215_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210215_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--玩家提交的物品及宠物
--**********************************
function x210215_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
	
	if indexpet == 255 then --索引值返回255表示空，没提交宠物
		BeginEvent(sceneId)
			strText = "请提供一个宠物!"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	else
		petlevel = LuaFnGetPet_Level(sceneId, selfId, indexpet ) --宠物等级
		petdataid = LuaFnGetPet_DataID(sceneId, selfId, indexpet ) --宠物编号
		
		if petlevel>=x210215_g_PetNeedLevel and petdataid==x210215_g_PetDataID then
	
			--BeginAddItem(sceneId)
			--for i, item in x210215_g_ItemBonus do
			--	AddItem( sceneId,item.id, item.num )
			--end
			--ret = EndAddItem(sceneId,selfId)
			
			--添加任务奖励
			--if ret > 0 then
				AddMoney(sceneId,selfId,x210215_g_MoneyBonus );
				LuaFnAddExp( sceneId, selfId,600)
				ret0 = DelMission( sceneId, selfId, x210215_g_MissionId ) --删除任务
				ret1 = LuaFnDeletePet(sceneId, selfId, indexpet ) --删除宠物
				if ret0>0 and ret1>0 then
					MissionCom( sceneId,selfId, x210215_g_MissionId )
					Msg2Player(  sceneId, selfId,"#Y完成任务：修炼宠物",MSG2PLAYER_PARA )
					CallScriptFunction( 210216, "OnDefaultEvent",sceneId, selfId, npcid)
				end
				
				BeginEvent(sceneId)
					strText = "完成任务"
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
		else
			BeginEvent(sceneId)
				strText = "宠物条件不符!"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
			--else
			--任务奖励没有加成功
--				BeginEvent(sceneId)
--					strText = "背包已满,无法完成任务"
--					AddText(sceneId,strText);
--				EndEvent(sceneId)
--				DispatchMissionTips(sceneId,selfId)
--			end  
--		else
--			BeginEvent(sceneId)
--				strText = "宠物条件不符!"
--				AddText(sceneId,strText);
--			EndEvent(sceneId)
--			DispatchMissionTips(sceneId,selfId)
--		end
end

