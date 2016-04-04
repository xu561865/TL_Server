x311100_g_ScriptId = 311100

x311100_g_MissionName="我问你答"

-- 问题UI 	2

--1.client弹出NPC第一个对话界面
--2.给client出题
--3.告诉client答错了。
--4.告诉答够了12道题，结束。

--**********************************
function x311100_OnDefaultEvent( sceneId, selfId, targetId )
		local TransportNPCName=GetName(sceneId,targetId);
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddString(sceneId,TransportNPCName)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 2)

		return
end

--**********************************
--列举事件
--**********************************
function x311100_OnEnumerate( sceneId, selfId, targetId )
	if	LuaFnGetLevel( sceneId, selfId)>=2	then
			AddNumText(sceneId,x311100_g_ScriptId,x311100_g_MissionName);
    end
end

--**********************************
--提问
--**********************************
function x311100_AskQuestion( sceneId, selfId, Question_Sequence)

	if Question_Sequence > 12 then
		if( IsHaveMission(sceneId,selfId,447) > 0)  then			
			misIndex = GetMissionIndexByID(sceneId,selfId,447)
			SetMissionByIndex(sceneId,selfId,misIndex,1,1)
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,4)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 2)
		return
	end

--随机出一个号码
	wenti = random(1,10)
	if Question_Sequence >=1 and Question_Sequence <= 3 then
		wenti = wenti + 110000
	elseif Question_Sequence >=4 and Question_Sequence <= 6 then
		wenti = wenti + 120000
	elseif Question_Sequence >=7 and Question_Sequence <= 9 then
		wenti = wenti + 130000
	elseif Question_Sequence >=10 and Question_Sequence <= 12 then
		wenti = wenti + 140000
	else
		Msg2Player( sceneId,selfId,"未找到问题",MSG2PLAYER_PARA)
	end

	con,opt0,opt1,opt2,opt3,opt4,opt5,key0,key1,key2,key3,key4,key5=GetQuestionsRecord(wenti)

	if con=="" then		--注意这里如果选项是空则用  ==""   来判断
		Msg2Player( sceneId,selfId,"未找到问题",MSG2PLAYER_PARA)
	end
	
	local key_position = {}
	--把他们位置随机掉
	x311100_g_rand = random(0,2)
	if x311100_g_rand == 0 then
		key_position[0] = 1
		key_position[1] = 2
		key_position[2] = 0
		key_position[3] = -1
		key_position[4] = -1
		key_position[5] = -1
	elseif x311100_g_rand == 1 then
		key_position[0] = 2
		key_position[1] = 0
		key_position[2] = 1
		key_position[3] = -1
		key_position[4] = -1
		key_position[5] = -1
	else
		key_position[0] = 0
		key_position[1] = 1
		key_position[2] = 2
		key_position[3] = -1
		key_position[4] = -1
		key_position[5] = -1
	end

	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,2)
		UICommand_AddInt(sceneId,Question_Sequence)
		UICommand_AddInt(sceneId,wenti)		
		UICommand_AddString(sceneId,con)
		UICommand_AddString(sceneId,opt0)
		UICommand_AddString(sceneId,opt1)
		UICommand_AddString(sceneId,opt2)
		UICommand_AddString(sceneId,opt3)
		UICommand_AddString(sceneId,opt4)
		UICommand_AddString(sceneId,opt5)
		UICommand_AddInt(sceneId,key_position[0])
		UICommand_AddInt(sceneId,key_position[1])
		UICommand_AddInt(sceneId,key_position[2])
		UICommand_AddInt(sceneId,key_position[3])
		UICommand_AddInt(sceneId,key_position[4])
		UICommand_AddInt(sceneId,key_position[5])
		UICommand_AddInt(sceneId,targetId )
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 2)
	return

end

--**********************************
--回答
--**********************************
function x311100_AnswerQuestion( sceneId, selfId, Question, Answer1,  Question_Sequence)

	local Answer_List={}

	con,opt0,opt1,opt2,opt3,opt4,opt5,key0,key1,key2,key3,key4,key5=GetQuestionsRecord(Question)
	Answer_List[0] = key0;
	Answer_List[1] = key1;
	Answer_List[2] = key2;
	Answer_List[3] = key3;
	Answer_List[4] = key4;
	Answer_List[5] = key5;
	
	if con=="" then		--注意这里如果选项是空则用  ==""   来判断
		Msg2Player( sceneId,selfId,"未找到问题",MSG2PLAYER_PARA)
	end
	
	if Answer_List[Answer1-1] == 1 then
		--奖励金钱
		x311100_g_Money = 10 * Question_Sequence
		AddMoney(sceneId,selfId,x311100_g_Money)
		x311100_g_Bronze = mod(x311100_g_Money,100)
		x311100_g_Silver = (mod(x311100_g_Money,10000) - x311100_g_Bronze)/100
		x311100_g_Gold = (x311100_g_Money - x311100_g_Bronze - x311100_g_Silver * 100)/10000
		if x311100_g_Gold ~= 0 and x311100_g_Silver ~= 0 and x311100_g_Bronze ~= 0 then
			Msg2Player( sceneId,selfId,"你得到"..x311100_g_Gold.."金"..x311100_g_Silver.."银"..x311100_g_Bronze.."铜",MSG2PLAYER_PARA)
		elseif x311100_g_Gold ~= 0 and x311100_g_Silver ~= 0 and x311100_g_Bronze == 0 then
			Msg2Player( sceneId,selfId,"你得到"..x311100_g_Gold.."金"..x311100_g_Silver.."银",MSG2PLAYER_PARA)
		elseif x311100_g_Gold ~= 0 and x311100_g_Silver == 0 and x311100_g_Bronze ~= 0 then
			Msg2Player( sceneId,selfId,"你得到"..x311100_g_Gold.."金"..x311100_g_Bronze.."铜",MSG2PLAYER_PARA)
		elseif x311100_g_Gold ~= 0 and x311100_g_Silver == 0 and x311100_g_Bronze == 0 then
			Msg2Player( sceneId,selfId,"你得到"..x311100_g_Gold.."金",MSG2PLAYER_PARA)
		elseif x311100_g_Gold == 0 and x311100_g_Silver ~= 0 and x311100_g_Bronze ~= 0 then
			Msg2Player( sceneId,selfId,"你得到"..x311100_g_Silver.."银"..x311100_g_Bronze.."铜",MSG2PLAYER_PARA)
		elseif x311100_g_Gold == 0 and x311100_g_Silver ~= 0 and x311100_g_Bronze == 0 then
			Msg2Player( sceneId,selfId,"你得到"..x311100_g_Silver.."银",MSG2PLAYER_PARA)
		elseif x311100_g_Gold == 0 and x311100_g_Silver == 0 and x311100_g_Bronze ~= 0 then
			Msg2Player( sceneId,selfId,"你得到"..x311100_g_Bronze.."铜",MSG2PLAYER_PARA)
		end
		--告诉他答对了
		x311100_AskQuestion( sceneId, selfId, Question_Sequence + 1)
	else
	--告诉他答错了
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,3)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 2)
	end

end
