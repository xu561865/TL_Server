--少林任务主事件脚本
--任务
--脚本号
x220000_g_ScriptId = 220000

--任务号
x220000_g_MissionId = 1060

--任务目标npc
x220000_g_Name	="慧方"

--存储随机数
x220000_g_rand = 0					--变量第1位

--任务文本描述
x220000_g_MissionName="少林寺修炼任务"
x220000_g_MissionInfo="阿弥陀佛"  --任务描述
x220000_g_MissionTarget="完成慧方的任务"		--任务目标
x220000_g_ContinueInfo="任务做完了么?"		--未完成任务的npc对话
x220000_g_MissionComplete="太谢谢你了"					--完成任务npc说的话

--任务奖励


--**********************************
--任务入口函数
--**********************************
function x220000_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家已经接了少林寺任务
	if IsHaveMission(sceneId,selfId,x220000_g_MissionId) > 0 then
		x220000_HaveMissionToDo( sceneId, selfId, targetId )
	else
		--如果未接少林寺任务
		x220000_NoMissionToDo( sceneId, selfId, targetId )
	end
end

--**********************************
--如果玩家  有  任务所作的处理
--**********************************
function x220000_HaveMissionToDo( sceneId, selfId,targetId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x220000_g_MissionId)
	x220000_g_rand = GetMissionParam(sceneId,selfId,misIndex,1)
	x220000_g_MissionCondition = GetMissionParam(sceneId,selfId,misIndex,0)
	if GetName(sceneId,targetId) == x220000_g_Name then			--判断该npc是否是交任务的npc
		if	CallScriptFunction( x220000_g_rand, "CheckSubmit",sceneId, selfId, targetId ) == 1 then
			--因为在子任务脚本中x220000_g_rand会被改成别的数，所以这里需要重新取得一次
			x220000_g_rand = GetMissionParam(sceneId,selfId,misIndex,1)
			CallScriptFunction( x220000_g_rand, "OnDefaultEvent",sceneId, selfId, targetId )
		else
			--显示对话框
			x220000_AcceptDialog(sceneId, selfId,x220000_g_rand,"任务还没完成呢吧？",targetId)
		end
	end
end

--**********************************
--如果玩家没有任务所作的处理
--**********************************
function x220000_NoMissionToDo( sceneId, selfId, targetId )
	--检测是否任务已经达到20个,如果到了,则不能接
	if GetMissionCount(sceneId,selfId) == 20 then
		BeginEvent(sceneId)
			strText = "无法接受更多任务"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--满足任务接收条件
	if x220000_CheckAccept(sceneId,selfId) > 0 then
		--得到玩家等级
		x220000_g_Level = GetLevel(sceneId,selfId)
		if x220000_g_Level >= 10  then	--and x220000_g_Level <20
		--得到一个随机数
		--randomseed(clock())
		x220000_g_rand = random(220001,220027)
		CallScriptFunction( x220000_g_rand, "OnAccept",sceneId, selfId, targetId )
		end
	end
end

--**********************************
--列举事件
--**********************************
function x220000_OnEnumerate( sceneId, selfId, targetId )
	--如果已接任务,则列出任务
	if IsHaveMission(sceneId,selfId,x220000_g_MissionId) > 0 then
		misIndex = GetMissionIndexByID(sceneId,selfId,x220000_g_MissionId)
		x220000_g_rand = GetMissionParam(sceneId,selfId,misIndex,1)
		x220000_g_MissionCondition = GetMissionParam(sceneId,selfId,misIndex,0)		--得到任务是否完成，如果完成，则在交信的人处不再显示任务，未完成则显示
		if GetName(sceneId,targetId) == x220000_g_Name then		--如果是发任务的npc
			AddNumText(sceneId,x220000_g_ScriptId,x220000_g_MissionName)
		end
    --如果没接任务而满足任务接收条件,则列出任务
    elseif x220000_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x220000_g_Name then		--如果是发任务的npc
			AddNumText(sceneId,x220000_g_ScriptId,x220000_g_MissionName)
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x220000_CheckAccept( sceneId, selfId )
	local  MenPai = GetMenPai( sceneId, selfId)
	if	MenPai ~= 0 then
		return 0
	else
		return 1
	end
end

--**********************************
--接受
--**********************************
function x220000_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x220000_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x220000_g_MissionId )
	--如果是送货任务,要把任务物品删除
	--if IsHaveMission(sceneId,selfId,4012) > 0 then
	--	DelMission( sceneId, selfId, 4012 )
	--elseif IsHaveMission(sceneId,selfId,4013) > 0 then
	--	DelMission( sceneId, selfId, 4013 )
	--end
end

--**********************************
--继续
--**********************************
function x220000_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x220000_g_MissionName)
		AddText(sceneId,x220000_g_MissionComplete)
		--AddMoneyBonus( sceneId, g_MoneyBonus )
		--for i, item in g_ItemBonus do
		--	AddItemBonus( sceneId, item.id, item.num )
		--end
		--for i, item in g_RadioItemBonus do
		--	AddRadioItemBonus( sceneId, item.id, item.num )
		--end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x220000_g_ScriptId,x220000_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x220000_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x220000_g_MissionId)
    x220000_g_rand = GetMissionParam(sceneId,selfId,misIndex,1)		--得到子任务序列号
    
		--如果是送信任务
	if x220000_g_rand == 1 then
		num1 = GetMissionParam(sceneId,selfId,misIndex,0)
		if num1 ==1 then
			return 1
		else
		return 0
		end

		--如果是寻物任务
	elseif x220000_g_rand >= 2 and x220000_g_rand <= 9 then
		itemCount = GetItemCount( sceneId, selfId, g_SubMission[x220000_g_rand].id )
		if itemCount < g_SubMission[x220000_g_rand].num then
			return 0
		else
			return 1
		end

		--如果是杀怪任务
	elseif x220000_g_rand == 10 then
		x220000_g_MissionCondition = GetMissionParam(sceneId,selfId,misIndex,0)
		if x220000_g_MissionCondition ==1 then
			return 1
		else
		return 0
		end
	end
end

--**********************************
--提交
--**********************************
function x220000_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x220000_g_MissionId)
	x220000_g_rand = GetMissionParam(sceneId,selfId,misIndex,1)
	x220000_g_MissionRound = GetMissionData(sceneId,selfId,11)

	--计算奖励金钱的数量
	if mod(x220000_g_MissionRound,10) == 0 then
		x220000_g_Money = 100 * 15
	else
		x220000_g_Money = 100 * mod(x220000_g_MissionRound,10)
	end
	--************送信任务****************
	if x220000_g_rand == 1 then
		DelMission( sceneId, selfId, x220000_g_MissionId )
		MissionCom( sceneId,selfId, x220000_g_MissionId )
				
		--给金钱奖励
		AddMoney(sceneId,selfId,x220000_g_Money)
		--给经验值奖励
		AddExp( sceneId,selfId,x220000_g_Money)	
		Msg2Player( sceneId,selfId,"你得到"..x220000_g_Money.."金币",MSG2PLAYER_PARA)
		Msg2Player( sceneId,selfId,"你得到"..x220000_g_Money.."经验",MSG2PLAYER_PARA)
		--显示对话框
		BeginEvent(sceneId)
			AddText(sceneId,"恭喜你完成了任务，给你"..x220000_g_Money.."金币和"..x220000_g_Money.."点经验")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		
	--************寻物任务****************
	elseif x220000_g_rand >= 2 and x220000_g_rand <= 9 then
		ret = DelMission( sceneId, selfId, x220000_g_MissionId )
		if ret > 0 then
			MissionCom( sceneId,selfId, x220000_g_MissionId )
			--扣除任务物品
			DelItem( sceneId, selfId, g_SubMission[x220000_g_rand].id, g_SubMission[x220000_g_rand].num )
			--显示对话框
			AddMoney(sceneId,selfId,x220000_g_Money)
			AddExp( sceneId,selfId,x220000_g_Money)	
			Msg2Player( sceneId,selfId,"你得到"..x220000_g_Money.."金币",MSG2PLAYER_PARA)
			Msg2Player( sceneId,selfId,"你得到"..x220000_g_Money.."经验",MSG2PLAYER_PARA)
			BeginEvent(sceneId)
				AddText(sceneId,"恭喜你完成了任务，给你"..x220000_g_Money.."金币和"..x220000_g_Money.."点经验")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	
	--************杀怪任务****************
	elseif x220000_g_rand == 10 then
		ret = DelMission( sceneId, selfId, x220000_g_MissionId )
		if ret > 0 then
			MissionCom( sceneId,selfId, x220000_g_MissionId )
			AddMoney(sceneId,selfId,x220000_g_Money)
			AddExp( sceneId,selfId,x220000_g_Money)	
			Msg2Player( sceneId,selfId,"你得到"..x220000_g_Money.."金币",MSG2PLAYER_PARA)
			Msg2Player( sceneId,selfId,"你得到"..x220000_g_Money.."经验",MSG2PLAYER_PARA)
			BeginEvent(sceneId)
				AddText(sceneId,"恭喜你完成了任务，给你"..x220000_g_Money.."金币和"..x220000_g_Money.."点经验")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x220000_OnKillObject( sceneId, selfId, objdataId )

end

--**********************************
--进入区域事件
--**********************************
function x220000_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x220000_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--接任务后显示的界面
--**********************************
function x220000_AcceptDialog(sceneId, selfId,x220000_g_rand,g_Dialog,targetId)
	BeginEvent(sceneId)
		AddText(sceneId,g_Dialog)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--交任务后显示的界面
--**********************************
function x220000_SubmitDialog(sceneId, selfId,x220000_g_rand)

end

--**********************************
--把信送到后显示的界面
--**********************************
function x220000_SubmitDialog(sceneId, selfId,x220000_g_rand)

end

function x220000_DisplayMissionTips(sceneId,selfId,g_MissionTip)
	BeginEvent(sceneId)
		strText = g_MissionTip
		AddText(sceneId,strText)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--取得本事件的MissionId，用于obj文件中对话情景的判断
--**********************************
function x220000_GetEventMissionId(sceneId, selfId)
	return x220000_g_MissionId
end
