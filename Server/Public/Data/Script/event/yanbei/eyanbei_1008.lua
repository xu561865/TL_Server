--找人任务
--回复曲端
--MisDescBegin
--脚本号
x211008_g_ScriptId = 211008

--前提任务
--g_MissionIdPre  = 

--任务号
x211008_g_MissionId = 538

--任务归类
x211008_g_MissionKind = 30

--任务等级
x211008_g_MissionLevel = 29

--是否是精英任务
x211008_g_IfMissionElite = 0

--任务文本描述
x211008_g_MissionName="回复曲端"
x211008_g_MissionInfo="回去告诉曲端，我答应了他的要求"
x211008_g_MissionTarget="回复曲端"
x211008_g_ContinueInfo="你有什么事吗？"
x211008_g_MissionComplete="哦，收到"

x211008_g_MoneyBonus=1008

x211008_g_Name	="曲端"

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211008_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if (IsMissionHaveDone(sceneId,selfId,x211008_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x211008_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x211008_g_Name then
			x211008_OnContinue( sceneId, selfId, targetId )
		end
	--满足任务接收条件
	elseif x211008_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211008_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,x211008_g_MissionName)
			AddText(sceneId,x211008_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x211008_g_MissionTarget)
			AddMoneyBonus( sceneId, x211008_g_MoneyBonus )
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x211008_g_ScriptId,x211008_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x211008_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家还未完成上一个任务
	--if 	IsMissionHaveDone(sceneId,selfId,g_MissionIdPre) <= 0 then
		--return
	--end
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x211008_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x211008_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x211008_g_Name then
			AddNumText(sceneId, x211008_g_ScriptId,x211008_g_MissionName);
		end
	--满足任务接收条件
	elseif x211008_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211008_g_Name then
			AddNumText(sceneId,x211008_g_ScriptId,x211008_g_MissionName);
		end
	end
end

--**********************************
--检测接受条件
--**********************************
function x211008_CheckAccept( sceneId, selfId )
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
function x211008_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x211008_g_MissionId, x211008_g_ScriptId, 0, 0, 0 )
	npcobjid = LuaFnGetCopySceneData_Param(sceneId, 2)
	if npcobjid ~= 0 then
		LuaFnDeleteMonster( sceneId, npcobjid )
		LuaFnSetCopySceneData_Param(sceneId, 2, 0)
		if HaveItem (sceneId,selfId,40002054) >0 then
			DelItem ( sceneId,selfId,40002054,1)
		end
	end
end

--**********************************
--放弃
--**********************************
function x211008_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x211008_g_MissionId )
end

--**********************************
--继续
--**********************************
function x211008_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	BeginEvent(sceneId)
		AddText(sceneId,x211008_g_MissionName)
		AddText(sceneId,x211008_g_ContinueInfo)
		AddMoneyBonus( sceneId, x211008_g_MoneyBonus )
	EndEvent( )
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x211008_g_ScriptId,x211008_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211008_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x211008_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x211008_CheckSubmit( sceneId, selfId, selectRadioId ) then
		AddItemListToHuman(sceneId,selfId)
		AddMoney(sceneId,selfId,x211008_g_MoneyBonus );
		DelMission( sceneId,selfId,  x211008_g_MissionId )
		--设置任务已经被完成过
		MissionCom( sceneId,selfId,  x211008_g_MissionId )
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x211008_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x211008_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211008_OnItemChanged( sceneId, selfId, itemdataId )
end
