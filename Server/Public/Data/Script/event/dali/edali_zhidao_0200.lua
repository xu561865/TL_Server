--找人任务
--赵天师寻找蒲良
--MisDescBegin
--脚本号
x210200_g_ScriptId = 210200

--任务号
x210200_g_MissionId = 440

--上一个任务的ID
--g_MissionIdPre = 

--目标NPC
x210200_g_Name	="蒲良"

--任务归类
x210200_g_MissionKind = 13

--任务等级
x210200_g_MissionLevel = 1

--是否是精英任务
x210200_g_IfMissionElite = 0

--任务名
x210200_g_MissionName="新手：武林大会"
x210200_g_MissionInfo="你可以先去武器店老板蒲良那里看看，他有特别的礼物送你哦！"
x210200_g_MissionTarget="找到蒲良，武器店[216,135]"
x210200_g_MissionComplete="是赵天师要你来的吧，看看自己喜欢什么，随便挑一件吧，初入江湖，要有武器防身才好。"
x210200_g_MoneyBonus=120
x210200_g_SignPost = {x = 216, z = 135, tip = "蒲良"}
x210200_g_RadioItemBonus={{id=10101000 ,num=1},{id=10102000,num=1},{id=10104000,num=1},{id=10103000,num=1}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210200_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
	if (IsMissionHaveDone(sceneId,selfId,x210200_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x210200_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x210200_g_Name then
			x210200_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
	elseif x210200_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210200_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x210200_g_MissionName)
				AddText(sceneId,x210200_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210200_g_MissionTarget)
				for i, item in x210200_g_RadioItemBonus do
					AddRadioItemBonus( sceneId, item.id, item.num )
				end
				AddMoneyBonus( sceneId, x210200_g_MoneyBonus )
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210200_g_ScriptId,x210200_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x210200_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210200_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x210200_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210200_g_Name then
			AddNumText(sceneId, x210200_g_ScriptId,x210200_g_MissionName,2,-1);
		end
	--满足任务接收条件
	elseif x210200_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210200_g_Name then
			AddNumText(sceneId,x210200_g_ScriptId,x210200_g_MissionName,1,-1);
		end
	end
end

--**********************************
--检测接受条件
--**********************************
function x210200_CheckAccept( sceneId, selfId )
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
function x210200_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210200_g_MissionId, x210200_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#Y接受任务：武林大会",MSG2PLAYER_PARA )
	CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210200_g_SignPost.x, x210200_g_SignPost.z, x210200_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210200_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210200_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210200_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210200_g_MissionName)
		AddText(sceneId,x210200_g_MissionComplete)
		AddMoneyBonus( sceneId, x210200_g_MoneyBonus )
		for i, item in x210200_g_RadioItemBonus do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210200_g_ScriptId,x210200_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210200_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210200_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210200_CheckSubmit( sceneId, selfId, selectRadioId ) then
    	BeginAddItem(sceneId)
			for i, item in x210200_g_RadioItemBonus do
				if item.id == selectRadioId then
					AddItem( sceneId,item.id, item.num )
				end
			end
		ret = EndAddItem(sceneId,selfId)
		--添加任务奖励
		if ret > 0 then
			AddMoney(sceneId,selfId,x210200_g_MoneyBonus );
			LuaFnAddExp( sceneId, selfId, 20)
			
			ret = DelMission( sceneId, selfId, x210200_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId, selfId, x210200_g_MissionId )
				--扣除任务物品
				--for i, item in g_DemandItem do
				--	DelItem( sceneId, selfId, item.id, item.num )
				--end
				AddItemListToHuman(sceneId,selfId)
				Msg2Player(  sceneId, selfId,"#Y完成任务：武林大会",MSG2PLAYER_PARA )
				CallScriptFunction( 210201, "OnDefaultEvent",sceneId, selfId, targetId)
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
function x210200_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210200_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210200_OnItemChanged( sceneId, selfId, itemdataId )
end
