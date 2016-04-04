--少林寺任务
--捉宠
--MisDescBegin
--脚本号
x220019_g_ScriptId = 220019

--前提任务
--g_MissionIdPre =

--任务号
x220019_g_MissionId = 1060

--任务目标npc
x220019_g_Name	="慧方"

--任务归类
x220019_g_MissionKind = 20

--任务等级
x220019_g_MissionLevel = 10

--是否是精英任务
x220019_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x220019_g_IsMissionOkFail = 0		--变量的第0位

--任务需要得到的物品
--g_DemandItem={{id=10100001,num=1}}		--从背包中计算

--任务环数
x220019_g_MissionRound	= 11			--记录循环任务变量的第10个数
--以上是动态**************************************************************

--任务变量第一位用来存储随机得到的脚本号

--任务文本描述
x220019_g_MissionName="少林寺门派任务"
x220019_g_MissionInfo="我要一只柴猫，给我捉来"  --任务描述
x220019_g_MissionTarget="帮慧方捉来一只柴猫。"		--任务目标
x220019_g_ContinueInfo="你把柴猫带来了吗？"		--未完成任务的npc对话
x220019_g_MissionComplete="不愧是少林弟子"					--完成任务npc说话的话

x220019_g_PetDataID=3000	--任务宠物的编号

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x220019_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	if IsHaveMission(sceneId,selfId,x220019_g_MissionId) > 0 then	--如果已接此任务
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x220019_g_MissionName)
			AddText(sceneId,x220019_g_ContinueInfo)
		EndEvent( )
		bDone = x220019_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x220019_g_ScriptId,x220019_g_MissionId,bDone)
	elseif x220019_CheckAccept(sceneId,selfId) > 0 then		--满足任务接收条件
		--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x220019_g_MissionName)
				AddText(sceneId,x220019_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x220019_g_MissionTarget)
				EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x220019_g_ScriptId,x220019_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x220019_OnEnumerate( sceneId, selfId, targetId )
    --如果已接此任务
    if IsHaveMission(sceneId,selfId,x220019_g_MissionId) > 0 then
		AddNumText(sceneId,x220019_g_ScriptId,x220019_g_MissionName);
    --满足任务接收条件
    elseif x220019_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x220019_g_ScriptId,x220019_g_MissionName);
    end
end

--**********************************
--检测接受条件
--**********************************
function x220019_CheckAccept( sceneId, selfId )
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
function x220019_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMissionEx( sceneId,selfId, x220019_g_MissionId, x220019_g_ScriptId )		--添加任务
	SetMissionEvent(sceneId,selfId, x220019_g_MissionId,3)	--设置任务事件，3表示宠物变化事件
	--加入任务到玩家列表
	misIndex = GetMissionIndexByID(sceneId,selfId,x220019_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0 (任务完成情况)
	SetMissionByIndex(sceneId,selfId,misIndex,1,x220019_g_ScriptId)						--根据序列号把任务变量的第1位置为任务脚本号
	--得到环数
	x220019_g_MissionRound = GetMissionData(sceneId,selfId,11)
	--环数增加1
	x220019_g_MissionRound = x220019_g_MissionRound + 1
	if	x220019_g_MissionRound >= 21 then
		SetMissionData(sceneId, selfId, 11, 1)
	else
		SetMissionData(sceneId, selfId, 11, x220019_g_MissionRound)
	end
	--检测玩家身上的道具是否已经满足完成条件，如果已经满足，则把完成任务的变量置为0
	if x220019_CheckSubmit( sceneId, selfId ) == 1 then
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)					--把任务完成标志置为1
	end
	--显示内容告诉玩家已经接受了任务
	BeginEvent(sceneId)
		AddText(sceneId,x220019_g_MissionInfo)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	Msg2Player(  sceneId, selfId,"#Y接受任务：少林寺师门任务",MSG2PLAYER_PARA )
end

--**********************************
--放弃
--**********************************
function x220019_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x220019_g_MissionId )
	SetMissionData(sceneId,selfId,11,0)	--环数清0
end

--**********************************
--继续
--**********************************
function x220019_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x220019_g_MissionName)
    AddText(sceneId,x220019_g_MissionComplete)
    --AddMoneyBonus( sceneId, g_MoneyBonus )
    --for i, item in g_ItemBonus do
	--	AddItemBonus( sceneId, item.id, item.num )
	--end
    --for i, item in g_RadioItemBonus do
	--	AddRadioItemBonus( sceneId, item.id, item.num )
	--end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x220019_g_ScriptId,x220019_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x220019_CheckSubmit( sceneId, selfId )
	petcount = LuaFnGetPetCount(sceneId, selfId) --取得宠物数量
	for	i=0,petcount-1 do
		petdataid = LuaFnGetPet_DataID(sceneId, selfId, i) --取得宠物编号
		if petdataid==x220019_g_PetDataID then
			misIndex = GetMissionIndexByID(sceneId,selfId,x220019_g_MissionId)	--得到任务的序列号
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)	--根据序列号把任务变量的第0位置1
			bDone = GetMissionParam(sceneId,selfId,misIndex,0)	--根据序列号把任务变量的第0位置1
			return bDone
		end
	end
end

--**********************************
--提交
--**********************************
function x220019_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	local Level = GetLevel( sceneId, selfId)	
	if x220019_CheckSubmit( sceneId, selfId )>0 then
		petcount = LuaFnGetPetCount(sceneId, selfId) --取得宠物数量
		for	i=0,petcount-1 do
			petdataid = LuaFnGetPet_DataID(sceneId, selfId, i) --取得宠物编号
			if petdataid==x220019_g_PetDataID then
				ret0 = LuaFnDeletePet(sceneId, selfId, i)
				ret1 = DelMission( sceneId, selfId, x220019_g_MissionId )
				if ret0>0 and ret1>0 then
					DelMission( sceneId, selfId, x220019_g_MissionId )
					MissionCom( sceneId,selfId, x220019_g_MissionId )
					--得到环数
					x220019_g_MissionRound = GetMissionData(sceneId,selfId,11)
					--计算奖励经验的数量
					if mod(x220019_g_MissionRound,10) == 0 then
						x220019_g_Exp = Level * 10 * 10										--等级+环数函数，受经验调节常数的影响
					else
						x220019_g_Exp = Level * mod(x220019_g_MissionRound,10) * 10
					end
					if	floor((x220019_g_MissionRound - 1) / 10) >=1  then
						x220019_g_Exp = x220019_g_Exp +50												--11~20环任务，每环额外增加50点经验
					end
					--增加经验值
					AddExp( sceneId,selfId,x220019_g_Exp)
					AddMoney( sceneId, selfId, x220019_g_Exp)	
					--显示对话框
					BeginEvent(sceneId)
						AddText(sceneId,"恭喜你完成了任务，给你"..x220019_g_Exp.."点经验和"..x220019_g_Exp.."钱")
					EndEvent(sceneId)
					DispatchEventList(sceneId,selfId,targetId)
				end
			end
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x220019_OnKillObject( sceneId, selfId, objdataId, objId )
end

--**********************************
--进入区域事件
--**********************************
function x220019_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x220019_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--宠物改变
--**********************************
function x220019_OnPetChanged( sceneId, selfId, petdataId )
	if petdataId==x220019_g_PetDataID then --是任务宠物
		misIndex = GetMissionIndexByID(sceneId,selfId,x220019_g_MissionId)	--得到任务的序列号
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)	--根据序列号把任务变量的第0位置1
		BeginEvent(sceneId)
			strText = "捉到宠物啦，任务完成!"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

--**********************************
--玩家提交的物品及宠物
--**********************************
function x220019_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
end

