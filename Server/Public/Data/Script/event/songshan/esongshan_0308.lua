--找人任务
--丹书铁券
--MisDescBegin
--脚本号
x210308_g_ScriptId = 210308

--任务号
x210308_g_MissionId = 468

--目标NPC
x210308_g_Name	="种世衡"

--任务归类
x210308_g_MissionKind = 14

--任务等级
x210308_g_MissionLevel = 25

--是否是精英任务
x210308_g_IfMissionElite = 0

--任务名
x210308_g_MissionName="丹书铁券"
x210308_g_MissionInfo=[[
    这件事情到此为止吧，我会告诉凝霜，不要再追究下去了。
前些日子，雁南的种世衡元帅写信给柴大官人，说从俘虏的辽兵口中得到了柴氏丹书铁券的事情，麻烦你去看看吧，也许能得到一些情况的。
]]
x210308_g_MissionTarget="找到雁南的种世衡"
x210308_g_ContinueInfo="你找到雁南的种世衡了吗？快去找吧！"
x210308_g_MissionComplete="你终于来了。"
x210308_g_MoneyBonus=12000

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210308_OnDefaultEvent( sceneId, selfId, targetId )

	--如果玩家完成过这个任务
  if( IsMissionHaveDone(sceneId,selfId,x210308_g_MissionId) > 0 ) then
  	return
	elseif( IsHaveMission(sceneId,selfId,x210308_g_MissionId) > 0)  then
		if GetName(sceneId, targetId) == x210308_g_Name then
			x210308_OnComplete( sceneId, selfId, targetId );
		else
			x210308_OnContinue( sceneId, selfId, targetId );
		end
    --满足任务接收条件
	elseif x210308_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x210308_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId);
				AddText(sceneId, x210308_g_MissionName);
				AddText(sceneId, x210308_g_MissionInfo);
				AddText(sceneId, "#{M_MUBIAO}");
				AddText(sceneId, x210308_g_MissionTarget);
			EndEvent( );
			DispatchMissionInfo(sceneId,selfId,targetId,x210308_g_ScriptId,x210308_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x210308_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    print("到了吗1? check:" .. IsMissionHaveDone(sceneId,selfId,x210308_g_MissionId));
    if IsMissionHaveDone(sceneId,selfId,x210308_g_MissionId) > 0 then
    	return 
    --如果已接此任务
    elseif IsHaveMission(sceneId,selfId,x210308_g_MissionId) > 0 then
			AddNumText(sceneId, x210308_g_ScriptId, x210308_g_MissionName);
    elseif x210308_CheckAccept(sceneId,selfId) > 0 then --满足任务接收条件
      print("到了吗?");
			if GetName(sceneId,targetId) ~= x210308_g_Name then
				AddNumText(sceneId, x210308_g_ScriptId, x210308_g_MissionName);
			end
    end
end

--**********************************
--检测接受条件
--**********************************
function x210308_CheckAccept( sceneId, selfId )
	--需要2级才能接
	if GetLevel( sceneId, selfId ) >= 15 and IsMissionHaveDone(sceneId, selfId, 467)==1 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210308_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId, selfId, x210308_g_MissionId, x210308_g_ScriptId, 0, 0, 0 )
end

--**********************************
--放弃
--**********************************
function x210308_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210308_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210308_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
  BeginEvent(sceneId)
		AddText(sceneId, x210308_g_MissionName)
		AddText(sceneId, x210308_g_ContinueInfo)
  EndEvent( )
  DispatchMissionDemandInfo(sceneId, selfId, targetId, x210308_g_ScriptId, x210308_g_MissionId, 0);
end

--**********************************
--完成
--**********************************
function x210308_OnComplete( sceneId, selfId, targetId )
	--提交任务时的说明信息
  BeginEvent(sceneId)
		AddText(sceneId, x210308_g_MissionName)
		AddText(sceneId, x210308_g_MissionComplete)
  EndEvent( )
  DispatchMissionContinueInfo(sceneId,selfId,targetId,x210308_g_ScriptId,x210308_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210308_CheckSubmit( sceneId, selfId )
	return 1
end

--**********************************
--提交
--**********************************
function x210308_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x210308_CheckSubmit( sceneId, selfId, selectRadioId ) then
		--添加任务奖励
		AddMoney(sceneId,selfId,x210308_g_MoneyBonus );
		DelMission( sceneId,selfId,  x210308_g_MissionId )
		--设置任务已经被完成过
		MissionCom( sceneId,selfId,  x210308_g_MissionId )
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210308_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210308_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210308_OnItemChanged( sceneId, selfId, itemdataId )
end
