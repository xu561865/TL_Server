--找人任务,使用道具,出现npc,交任务
--寻找鲁平
--MisDescBegin
--脚本号
x211005_g_ScriptId = 211005

--前提任务
--g_MissionIdPre =

--任务号
x211005_g_MissionId = 535

--哨子
x211005_g_ItemID = 40002054

--任务归类
x211005_g_MissionKind = 30

--任务等级
x211005_g_MissionLevel = 29

--是否是精英任务
x211005_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x211005_g_IsMissionOkFail = 0		--变量的第0位

--任务文本描述
x211005_g_MissionName="寻找鲁平"
x211005_g_MissionInfo="鲁平看来是准备见我们了，现在去树林中的小屋找到鲁平"
x211005_g_MissionTarget="找到鲁平"
x211005_g_MissionComplete="你有什么事吗？"

x211005_g_MoneyBonus=1005

x211005_g_Name	="鲁平"

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x211005_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if (IsMissionHaveDone(sceneId,selfId,x211005_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x211005_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x211005_g_Name then
			x211005_OnContinue( sceneId, selfId, targetId )
		end
	--满足任务接收条件
	elseif x211005_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211005_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x211005_g_MissionName)
				AddText(sceneId,x211005_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x211005_g_MissionTarget)
				AddMoneyBonus( sceneId, x211005_g_MoneyBonus )
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x211005_g_ScriptId,x211005_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x211005_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家还未完成上一个任务
	--if 	IsMissionHaveDone(sceneId,selfId,g_MissionIdPre) <= 0 then
		--return
	--end
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x211005_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x211005_g_MissionId) > 0 then
	if GetName(sceneId,targetId) == x211005_g_Name then
			AddNumText(sceneId, x211005_g_ScriptId,x211005_g_MissionName);
		end
	--满足任务接收条件
	elseif x211005_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x211005_g_Name then
			AddNumText(sceneId,x211005_g_ScriptId,x211005_g_MissionName);
		end
	end
end

--**********************************
--检测接受条件
--**********************************
function x211005_CheckAccept( sceneId, selfId )
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
function x211005_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	--加入任务物品
	BeginAddItem( sceneId )
	AddItem( sceneId, x211005_g_ItemID, 1 )
	ret = EndAddItem( sceneId, selfId )
	--if ret > 0 then 
		--AddItemListToHuman(sceneId,selfId)		
		ret = AddMission( sceneId,selfId, x211005_g_MissionId, x211005_g_ScriptId, 0, 0, 0 )	
		--if ret > 0 then
		AddItemListToHuman(sceneId,selfId)
		--end
	--end
end

--**********************************
--放弃
--**********************************
function x211005_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x211005_g_MissionId )
end

--**********************************
--继续
--**********************************
function x211005_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	BeginEvent(sceneId)
		AddText(sceneId,x211005_g_MissionName)
		AddText(sceneId,x211005_g_MissionComplete)
		AddMoneyBonus( sceneId, x211005_g_MoneyBonus )
	EndEvent( )
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x211005_g_ScriptId,x211005_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x211005_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x211005_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x211005_CheckSubmit( sceneId, selfId, selectRadioId ) then
		AddMoney(sceneId,selfId,x211005_g_MoneyBonus );
		DelMission( sceneId,selfId,  x211005_g_MissionId )
		--设置任务已经被完成过
		MissionCom( sceneId,selfId,  x211005_g_MissionId )
		npcobjid = LuaFnGetCopySceneData_Param(sceneId, 2)
		if npcobjid ~= 0 then
			LuaFnDeleteMonster( sceneId, npcobjid )
			LuaFnSetCopySceneData_Param(sceneId, 2, 0)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x211005_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x211005_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x211005_OnItemChanged( sceneId, selfId, itemdataId )
end
