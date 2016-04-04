
--任务系统全局函数的脚本文件

--脚本号
x888890_g_scriptId = 888890

--检测是否可以接
function x888890_CheckAccept( sceneId, selfId, targetId, MissionId )
	local ret = MissionCheckAcceptNM( sceneId, selfId, targetId, MissionId )
	if ret > 0 then
		return 1
	end
	return ret
end

--检测是否可以提交
function x888890_CheckSubmit( sceneId, selfId, targetId, MissionId )
	local ret = MissionCheckSubmitNM( sceneId, selfId, targetId, MissionId )
	if ret > 0 then
		return 1
	end
	return ret
end

function x888890_CheckAndAccept( sceneId, selfId, targetId, ScriptId, MissionId, Ident )
	if Ident == MISSION_PROMULGATOR or Ident == MISSION_PROMULGATOR_AND_SUBMITOR then
		if x888890_CheckAccept( sceneId, selfId, targetId, MissionId ) == 1 then
			AddMissionNM( sceneId, selfId, MissionId, ScriptId )
			MisMsg2PlayerNM( sceneId, selfId, targetId, ScriptId, MissionId, Ident, MSG2PLAYER_PARA )
			local SCENE, X, Z, TIP = GetMonsterWayInfoNM( sceneId, selfId, targetId, ScriptId, MissionId, Ident )
			if SCENE ~= nil then
				CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWayPos", sceneId, selfId, SCENE, X, Z, TIP )
			end
			return 1
		end
	end
	return 0
end

function x888890_CheckAndSubmit( sceneId, selfId, targetId, ScriptId, MissionId, selectId, Ident )
	if Ident == MISSION_SUBMITOR or Ident == MISSION_PROMULGATOR_AND_SUBMITOR then
		if x888890_CheckSubmit( sceneId, selfId, targetId, MissionId ) then
			ret = MissionComplateNM( sceneId, selfId, targetId, ScriptId, MissionId, selectId, Ident )
			if ret == 1 then
				return 1
			else
				BeginEvent(sceneId)
				local strText = "未知错误，无法完成任务"
				if ret == -2 then
					strText = "请选择奖励物品"
				elseif ret == -3 then
					strText = "背包已满,无法完成任务"
				elseif ret == -4 then
					strText = "扣除任务物品失败"
				end
				AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			end
		end
	end
	return 0
end

function x888890_OnContinue( sceneId, selfId, targetId, ScriptId, MissionId, Ident )
	if x888890_CheckSubmit( sceneId, selfId, targetId, MissionId ) == 1 then
		--任务完成，显示完成信息
		MissionComplateInfoNM( sceneId, selfId, targetId, ScriptId, MissionId, Ident )
	else
		--任务未完成。。。
		MissionNotComplateInfoNM( sceneId, selfId, targetId, ScriptId, MissionId, Ident )
	end
end

function x888890_OnEnumerate( sceneId, selfId, targetId, ScriptId, MissionId, Ident )
	--如果该任务已经完成，直接退出
	if IsMissionHaveDoneNM( sceneId, selfId, MissionId ) > 0 then
		return
	end

	if IsHaveMissionNM( sceneId, selfId, MissionId ) > 0 then
		--如果有这个任务，直接显示出来
		if Ident == MISSION_SUBMITOR or Ident == MISSION_PROMULGATOR_AND_SUBMITOR then
			--如果是任务接收者
			AddMissionTextNM( sceneId, selfId, targetId, ScriptId, MissionId, Ident, 1, -1 )
		end
	else
		if Ident == MISSION_PROMULGATOR or Ident == MISSION_PROMULGATOR_AND_SUBMITOR then
			--如果是任务发布者
			if x888890_CheckAccept( sceneId, selfId, targetId, MissionId ) == 1 then
				--如果可以接这个任务，显示。。。
				AddMissionTextNM( sceneId, selfId, targetId, ScriptId, MissionId, Ident, 1, -1 )
			end
		end
	end
end

function x888890_OnDefaultEvent( sceneId, selfId, targetId, ScriptId, MissionId, Ident )
	--如果该任务已经完成，直接退出
	if IsMissionHaveDoneNM( sceneId, selfId, MissionId ) > 0 then
		return
	end

	if IsHaveMissionNM( sceneId, selfId, MissionId ) > 0 then
		--如果有此任务，检查下是否做完了
		if Ident == MISSION_SUBMITOR or Ident == MISSION_PROMULGATOR_AND_SUBMITOR then
			x888890_OnContinue( sceneId, selfId, targetId, ScriptId, MissionId, Ident )
		end
	else
		--如果没有任务。。。。
		if Ident == MISSION_PROMULGATOR or Ident == MISSION_PROMULGATOR_AND_SUBMITOR then
			if x888890_CheckAccept( sceneId, selfId, targetId, MissionId ) == 1 then
				AddDispatchMissionInfoNM( sceneId, selfId, targetId, ScriptId, MissionId, Ident )
			end
		end
	end
end

function x888890_OnItemChanged( sceneId, selfId, ScriptId, MissionId, itemdataId )
	local NeedNum = GetNeedItemNumNM( sceneId, selfId, ScriptId, MissionId, itemdataId )
	if NeedNum > 0 then
		local Num = GetItemCount( sceneId, selfId, itemdataId )
		if Num < NeedNum then --还没有完成任务
			BeginEvent(sceneId)
			local strText = format("已得到@itemid_%d: %d/%d", itemdataId, Num, NeedNum )
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )

			local misIndex = GetMissionIndexByIDNM( sceneId, selfId, MissionId )
			local MisParm = GetMissionParam( sceneId, selfId, misIndex, 0 )
			if MisParm == 1 then --如果任务状态是1,说明任务完成的情况下又把物品减少到不能完成状态
				SetMissionByIndex( sceneId, selfId, misIndex, 0, 0 )
			end
		elseif Num == NeedNum then
			--已经完成任务
			BeginEvent(sceneId)
			local strText = format( "已得到全部的@itemid_%d: %d/%d", itemdataId, Num, NeedNum )
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			local MissionType = GetMissionTypeNM( sceneId, selfId, ScriptId, MissionId )
			if MissionType == 4 then
				FinishKillObjGetItem( sceneId, selfId, ScriptId, MissionId, itemdataId )
			end
		end
	end
end

function x888890_OnAbandon( sceneId, selfId, MissionId )
	local MissionName = GetMissionNameNM( sceneId, selfId, x888890_g_scriptId, MissionId )
	DelMissionNM( sceneId, selfId, MissionId )
	Msg2Player( sceneId, selfId, "#R你已经放弃["..MissionName.."]任务", MSG2PLAYER_PARA )
end

function x888890_OnKillObject( sceneId, selfId, ScriptId, MissionId, objdataId, objId )
															--场景ID, 自己的ID, 脚本ID, 任务ID, 怪物表位置号, 怪物objId
	local MissionType = GetMissionTypeNM( sceneId, selfId, ScriptId, MissionId )
	local NeedKilledNum, ObjIndex = GetNeedKillObjNumNM( sceneId, selfId, ScriptId, MissionId, objdataId )
	local misIndex = GetMissionIndexByIDNM( sceneId, selfId, MissionId )

	if MissionType == 4 then
		--杀怪得物品类型的任务
		if NeedKilledNum > 0 then
			local KilledNum = GetMonsterOwnerCount( sceneId, objId ) --取得这个怪物死后拥有分配权的人数
			for i = 0, KilledNum-1 do
				local humanObjId = GetMonsterOwnerID( sceneId, objId, i ) --取得拥有分配权的人的objId
				if IsHaveMissionNM( sceneId, humanObjId, MissionId ) > 0 then	--如果这个人拥有任务
					local ItemCount, ItemID = GetMissionItemNM( sceneId, humanObjId, ScriptId, MissionId, ObjIndex )
					if ItemCount > 0 then
						if GetItemCount( sceneId, humanObjId, ItemID ) < ItemCount then
							local rand = random(100)
							if rand < 25 then -- 25%的几率得到此物品
								AddMonsterDropItem( sceneId, objId, humanObjId, ItemID )    --给这个人任务道具(道具会出现在尸体包里)
							end
						end
					end
				end
			end
		end
	else
		--单纯的杀怪任务
		local strText
		if NeedKilledNum > 0 then
			local KilledNum = GetMissionParam( sceneId, selfId, misIndex, ObjIndex )
			
			if KilledNum < NeedKilledNum then
				SetMissionByIndex( sceneId, selfId, misIndex, ObjIndex, KilledNum+1 )
				if KilledNum == NeedKilledNum - 1 then
					if IfFinishdKillObjNM( sceneId, selfId, ScriptId, MissionId ) then
						--完成了～～
						BeginEvent(sceneId)
						strText = format( "已经杀死全部的@monsterid_%d: %d/%d", objdataId, KilledNum+1, NeedKilledNum )
						AddText( sceneId, strText )
						EndEvent( sceneId )
						DispatchMissionTips( sceneId, selfId )
						return 1
					end
				else
					BeginEvent(sceneId)
					strText = format( "已经杀死@monsterid_%d: %d/%d", objdataId, KilledNum+1, NeedKilledNum )
					AddText( sceneId, strText )
					EndEvent( sceneId )
					DispatchMissionTips( sceneId, selfId )
				end
			else
			end
		end
	end
	return 0
end













