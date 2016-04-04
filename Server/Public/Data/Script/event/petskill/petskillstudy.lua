--宠物技能学习UI 3

x311111_g_ScriptId = 311111;

x311111_g_MenPaiId = 0;
x311111_g_MenPaiSkillIds = {701,702,703}
--**********************************
--列举事件
--**********************************
function x311111_OnEnumerate( sceneId, selfId, targetId, sel )
	if(sel == 6) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId); --调用发布征友信息界面
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 5)
		
		local ret = DispatchPetPlacardList(sceneId,selfId,targetId,-1,-1,1);
		if(0 == ret) then
			Msg2Player( sceneId,selfId,"现在没有注册的宠物",MSG2PLAYER_PARA)
		end
	else
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt(sceneId,sel)		--调用技能学习界面
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 3)
	end
end

--条件检查，返回0 检查失败 ,1 检查成功
function x311111_PetSkillStudy_MenPaiCheck(sceneId, selfId)
	if(x311111_g_MenPaiId ~= tonumber(GetMenPai(sceneId, selfId))) then
		return 0;
	else
		return 1;
	end
end

--门派技能学习
function x311111_PetSkillStudy_MenPai_Learn(sceneId, selfId, petHid, petLid, skillId)
	local ret = PetStudySkill_MenPai(sceneId, selfId, petHid, petLid, skillId);
	if( 1 == ret ) then
		Msg2Player( sceneId,selfId,"宠物门派技能学习成功",MSG2PLAYER_PARA)
	else
		Msg2Player( sceneId,selfId,"宠物门派技能学习失败",MSG2PLAYER_PARA)
	end
end

--驯养费查询
function x311111_PetSkillStudy_Ask_Money(sceneId, selfId, petHid, petLid)
	local money = CalcPetDomesticationMoney(sceneId, selfId, petHid, petLid);
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, money)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 4)
end

--驯养宠物
function x311111_PetSkillStudy_Domestication(sceneId, selfId, petHid, petLid)
	local ret = PetDomestication(sceneId, selfId, petHid, petLid);
	if( 1 == ret ) then
		Msg2Player( sceneId,selfId,"宠物驯养成功",MSG2PLAYER_PARA)
	else
		Msg2Player( sceneId,selfId,"宠物驯养失败",MSG2PLAYER_PARA)
	end
end

--查看前一篇征友信息
function x311111_PetInviteFriend_Ask_NewPage(sceneId, selfId, npcId, guid1, guid2, dir)
	local ret = DispatchPetPlacardList(sceneId, selfId, npcId, guid1, guid2, dir)
	if(0 == ret) then
		Msg2Player( sceneId,selfId,"没有更多宠物了",MSG2PLAYER_PARA)
	end
end
