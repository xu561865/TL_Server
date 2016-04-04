--学习技能
--九大门派技能传授

--MisDescBegin
--脚本号
x210209_g_ScriptId = 210209

--任务号
x210209_g_MissionId = 449

--任务归类
x210209_g_MissionKind = 13

--任务道具编号
x210209_g_ItemId = 40002108

--任务等级
x210209_g_MissionLevel = 1

--是否是精英任务
x210209_g_IfMissionElite = 0

--任务名
x210209_g_MissionName="新手：学习技能"
x210209_g_MissionInfo="去找九大门派的弟子学习一项技能"
x210209_g_MissionTarget="学习技能"
x210209_g_MissionComplete="既然你拿来了推荐信，那我就教给你一项新手技能，要好好学习，多多练习才可以。"
x210209_g_Name_0="赵天师"
x210209_g_Name_1="慧易"
x210209_g_Name_2="石宝"
x210209_g_Name_3="简宁"
x210209_g_Name_4="张获"
x210209_g_Name_5="路三娘"
x210209_g_Name_6="海风子"
x210209_g_Name_7="破贪"
x210209_g_Name_8="程青霜"
x210209_g_Name_9="澹台子羽"

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210209_OnDefaultEvent( sceneId, selfId, targetId )
	if GetName(sceneId,targetId) ~= x210209_g_Name_0 then
		x210209_OnContinue( sceneId, selfId, targetId, selectRadioId )
	end
end

--**********************************
--列举事件
--**********************************
function x210209_OnEnumerate( sceneId, selfId, targetId )
	if x210209_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x210209_g_Name_1 then
			if	HaveSkill(  sceneId, selfId, 241)<0	then
				AddNumText(sceneId, x210209_g_ScriptId,x210209_g_MissionName);
			end
		elseif	GetName(sceneId,targetId) == x210209_g_Name_2	 then
			if	HaveSkill(  sceneId, selfId, 242)<0	then
				AddNumText(sceneId, x210209_g_ScriptId,x210209_g_MissionName);
			end
		elseif	GetName(sceneId,targetId) == x210209_g_Name_3	 then
			if	HaveSkill(  sceneId, selfId, 243)<0	then
				AddNumText(sceneId, x210209_g_ScriptId,x210209_g_MissionName);
			end
		elseif	GetName(sceneId,targetId) == x210209_g_Name_4	then
			if	HaveSkill(  sceneId, selfId, 244)<0	then
				AddNumText(sceneId, x210209_g_ScriptId,x210209_g_MissionName);
			end
		elseif	GetName(sceneId,targetId) == x210209_g_Name_5 then
			if	HaveSkill(  sceneId, selfId, 245)<0	then
				AddNumText(sceneId, x210209_g_ScriptId,x210209_g_MissionName);
			end
		elseif	GetName(sceneId,targetId) == x210209_g_Name_6 then
			if	HaveSkill(  sceneId, selfId, 246)<0	then
				AddNumText(sceneId, x210209_g_ScriptId,x210209_g_MissionName);
			end
		elseif	GetName(sceneId,targetId) == x210209_g_Name_7 then
			if	HaveSkill(  sceneId, selfId, 247)<0	then
				AddNumText(sceneId, x210209_g_ScriptId,x210209_g_MissionName);
			end
		elseif	GetName(sceneId,targetId) == x210209_g_Name_8 then
			if	HaveSkill(  sceneId, selfId, 248)<0	then
				AddNumText(sceneId, x210209_g_ScriptId,x210209_g_MissionName);
			end
		elseif	GetName(sceneId,targetId) == x210209_g_Name_9 then
			if	HaveSkill(  sceneId, selfId, 249)<0	then
				AddNumText(sceneId, x210209_g_ScriptId,x210209_g_MissionName);
			end
		end
	end
end

--**********************************
--检测接受条件
--**********************************
function x210209_CheckAccept( sceneId, selfId )
	--需要有道具才能接
	if	HaveItemInBag ( sceneId, selfId, x210209_g_ItemId)>0	then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210209_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210209_g_MissionId, x210209_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#Y接受任务：学习技能",MSG2PLAYER_PARA )
end

--**********************************
--放弃
--**********************************
function x210209_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210209_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210209_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210209_g_MissionName)
		AddText(sceneId,x210209_g_MissionComplete)
		AddText(sceneId,"你将学会一项新的技能")
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210209_g_ScriptId,x210209_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210209_CheckSubmit( sceneId, selfId )
	if	HaveItemInBag (  sceneId, selfId, x210209_g_ItemId)==1	then
		return 1
	else
		return 0
	end
end

--**********************************
--提交
--**********************************
function x210209_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210209_CheckSubmit( sceneId, selfId, selectRadioId ) then
		--添加任务奖励
		DelMission( sceneId, selfId, x210209_g_MissionId )
		MissionCom( sceneId, selfId, x210209_g_MissionId )
		--扣除任务物品
		DelItem( sceneId, selfId, x210209_g_ItemId, 1 )
		if  GetName(sceneId,targetId) == x210209_g_Name_1	then
			AddSkill(  sceneId, selfId, 241)
			BeginEvent(sceneId)
				strText = "你学到新的技能：少林新手技能：外功护体"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		elseif	GetName(sceneId,targetId) == x210209_g_Name_2	then
			AddSkill(  sceneId, selfId, 242)
			BeginEvent(sceneId)
				strText = "你学到新的技能：明教新手技能：奋力打击"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		elseif	GetName(sceneId,targetId) == x210209_g_Name_3	then
			AddSkill(  sceneId, selfId, 243)
			BeginEvent(sceneId)
				strText = "你学到新的技能：丐帮新手技能：要害攻击"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		elseif	GetName(sceneId,targetId) == x210209_g_Name_4	then
			AddSkill(  sceneId, selfId, 244)
			BeginEvent(sceneId)
				strText = "你学到新的技能：武当新手技能：内劲攻击"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		elseif	GetName(sceneId,targetId) == x210209_g_Name_5	then
			AddSkill(  sceneId, selfId, 245)
			BeginEvent(sceneId)
				strText = "你学到新的技能：峨嵋新手技能：初级治疗"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		elseif	GetName(sceneId,targetId) == x210209_g_Name_6	then
			AddSkill(  sceneId, selfId, 246)
			BeginEvent(sceneId)
				strText = "你学到新的技能：星宿新手技能：内功护体"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		elseif	GetName(sceneId,targetId) == x210209_g_Name_7	then
			AddSkill(  sceneId, selfId, 247)
			BeginEvent(sceneId)
				strText = "你学到新的技能：大理派新手技能：破绽攻击"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		elseif	GetName(sceneId,targetId) == x210209_g_Name_8	then
			AddSkill(  sceneId, selfId, 248)
			BeginEvent(sceneId)
				strText = "你学到新的技能：天山新手技能：初级影遁"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		elseif	GetName(sceneId,targetId) == x210209_g_Name_9	then
			AddSkill(  sceneId, selfId, 249)
			BeginEvent(sceneId)
				strText = "你学到新的技能：逍遥新手技能：燃烧陷阱"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
	Msg2Player(  sceneId, selfId,"#Y完成任务：学习技能",MSG2PLAYER_PARA )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210209_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210209_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210209_OnItemChanged( sceneId, selfId, itemdataId )
end
