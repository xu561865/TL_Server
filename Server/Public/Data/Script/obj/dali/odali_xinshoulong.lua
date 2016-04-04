--钱龙

--脚本号
x002031_g_scriptId = 002031


--所拥有的事件ID列表
--x002031_g_eventList={210205,210207,210208,311100}--210206
x002031_g_eventList={}
x002031_g_SkillList={{283,1,1},{283,2,2},{283,3,3},{283,4,4},{283,5,4}}
x002031_g_nowtargetId = 31;
--**********************************
--事件列表
--**********************************
function x002031_UpdateEventList( sceneId, selfId,targetId )
	
end

--**********************************
--事件交互入口
--**********************************
function x002031_OnDefaultEvent( sceneId, selfId,targetId )
	x002031_g_MenPai = GetMenPai(sceneId, selfId)
	if x002031_g_MenPai == 0 then  --0为战士
		BeginEvent(sceneId)
			AddText(sceneId,"你找为师有何事啊？")
			AddNumText(sceneId, x002031_g_scriptId, "学习技能",-1,0)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"老衲玄难，施主找贫僧有何事啊？")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x002031_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if 0 == GetNumText() then
		BeginEvent(sceneId)
		for i, skill in x002031_g_SkillList do
			local skillid = skill[1]
			local skilllevel = skill[2]
			local skilltype = skill[3]
			--检查是否已经会这个技能
			--Msg2Player( sceneId, selfId, "#R技能ID:"..skillid.."\n技能等级:"..skilllevel.."\n技能类型:"..skilltype,0)
			if HaveSkillAndLevelNS(sceneId,selfId,skillid,skilllevel) <= 0 then
				AddSkillStudy(sceneId,skillid,skilllevel,skilltype)			
			end
		end
		
		EndEvent(sceneId);
		DispatchSkillStudyList(sceneId,selfId,targetId);
		x002031_g_nowtargetId = targetId;
	end
end
 
--**********************************
--死亡事件
--**********************************
function x002031_OnDie( sceneId, selfId, killerId )
end

--**********************************
--技能学习
--**********************************
function x002031_OnSkillStudyEvent( sceneId, targetId, selfId , skillidandlevel )
	local skilllevel = mod(skillidandlevel,100);
	local skillid = (skillidandlevel-skilllevel)/100;
	if CheckStudySkillNS(sceneId,selfId,skillid,skilllevel) > 0 then
		--扣钱
		local money = GetStudyMoneyNS(sceneId,selfId,skillid,skilllevel);
		if money > 0 then
			if CostMoney(sceneId,selfId,money) < 0 then
				SaveLog(sceneId,selfId,"没有足够的金钱去学习技能");
				--Msg2Player( sceneId, selfId, "#R金钱不足", MSG2PLAYER_PARA );
			else
				if AddSkill(sceneId,selfId,skillid,skilllevel) <= 0 then
				--学习技能没有成功？？
				--扣的钱还得加回去
					AddMoney(sceneId,selfId,money);
					SaveLog(sceneId,selfId,"学习技能失败反还花费的金钱");
				else
					BeginEvent(sceneId)
					for i, skill in x002031_g_SkillList do
						local skillid = skill[1]
						local skilllevel = skill[2]
						local skilltype = skill[3]
						--检查是否已经会这个技能
						--Msg2Player( sceneId, selfId, "#R技能ID:"..skillid.."\n技能等级:"..skilllevel.."\n技能类型:"..skilltype,0)
						if HaveSkillAndLevelNS(sceneId,selfId,skillid,skilllevel) <= 0 then
							AddSkillStudy(sceneId,skillid,skilllevel,skilltype)		
						end
					end
					
					EndEvent(sceneId);
					DispatchSkillStudyList(sceneId,selfId,targetId,x002031_g_nowtargetId);
				end
			end
		end
	else
		SaveLog(sceneId,selfId,"没到学习技能的条件");
	end
end