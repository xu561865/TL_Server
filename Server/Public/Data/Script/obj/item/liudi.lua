--柳笛

--脚本号
x300002_g_scriptId = 300002
--**********************************
--刷新事件
--**********************************
function x300002_OnDefaultEvent( sceneId, selfId, targetId, eventId )
		if	sceneId == 30 then
			LuaFnCreateMonster(sceneId,529,181,258,1,0,-1)
		else
			BeginEvent(sceneId)
				strText = "在这里无法使用"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
		DelItem( sceneId,selfId,40002077,1)
end

function x300002_IsSkillLikeScript( sceneId, selfId)
	return 0;
end
