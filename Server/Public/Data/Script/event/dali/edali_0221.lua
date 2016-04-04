--׽������

--************************************************************************
--MisDescBegin

--�ű���
x210221_g_ScriptId = 210221

--��һ�������ID
x210221_g_MissionIdPre = 700

--�����
x210221_g_MissionId = 701

--����Ŀ��npc
x210221_g_Name	="��ƮƮ" 

--�������
x210221_g_MissionKind = 13

--����ȼ�
x210221_g_MissionLevel = 7

--�Ƿ��Ǿ�Ӣ����
x210221_g_IfMissionElite = 0

--********���漸���Ƕ�̬��ʾ�����ݣ������������б��ж�̬��ʾ�������******
--�����Ƿ��Ѿ����
x210221_g_IsMissionOkFail = 0		--�����ĵ�0λ
--**********************************�����Ƕ�̬****************************

--�����ı�����
x210221_g_MissionName="���֣���׽����"
x210221_g_MissionInfo="�ҵ�һֻСѼ���ܵ�ľ��һ�����ˣ���ȥ���ü��ʦ�������ľ��һ���СѼ�Ӹ��Ҿȳ�����"  --��������
x210221_g_MissionTarget="ȥ�黨���һ�üɮ[275��49]����ľ��һ��ȳ�СѼ��"		--����Ŀ��
x210221_g_ContinueInfo="���Ѿ�׽��СѼ���ˣ�"		--δ��������npc�Ի�
x210221_g_MissionComplete="��ķǳ���л�㡣"					--�������npc˵���Ļ�
x210221_g_SignPost = {x = 263, z = 129, tip = "��ƮƮ"}

--������
x210221_g_MoneyBonus=100
--g_ItemBonus={{id=40002108,num=1}}

--MisDescEnd
--************************************************************************

--��ɫMission����˵��
x210221_g_Param_ok=0	--0�ţ���ǰ�����Ƿ����(0δ��ɣ�1���)
--1�ţ�δ��
--2�ţ�δ��
--3�ţ�δ��
--4�ţ�δ��
--5�ţ�δ��
--6�ţ�δ��
--7�ţ�δ��
x210221_g_PetDataID=3499	--�������ı��


--������ں���
--**********************************
function x210221_OnDefaultEvent( sceneId, selfId, targetId )	--����������ִ�д˽ű�
	
	if IsHaveMission(sceneId,selfId,x210221_g_MissionId) > 0 then	--����ѽӴ�����
		--���������������Ϣ
		BeginEvent(sceneId)
			AddText(sceneId,x210221_g_MissionName)
			AddText(sceneId,x210221_g_ContinueInfo)
			AddMoneyBonus( sceneId, x210221_g_MoneyBonus )
		EndEvent( )
		bDone = x210221_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210221_g_ScriptId,x210221_g_MissionId,bDone)
	
	elseif x210221_CheckAccept(sceneId,selfId) > 0 then		--���������������
		--�����������ʱ��ʾ����Ϣ
			BeginEvent(sceneId)
				AddText(sceneId,x210221_g_MissionName)
				AddText(sceneId,x210221_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x210221_g_MissionTarget)
				--for i, item in g_ItemBonus do
				--	AddItemBonus( sceneId, item.id, item.num )
				--end
				AddMoneyBonus( sceneId, x210221_g_MoneyBonus )
				EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x210221_g_ScriptId,x210221_g_MissionId)
	end
end

--**********************************
--�о��¼�
--**********************************
function x210221_OnEnumerate( sceneId, selfId, targetId )
    --�����һ�δ�����һ������
    if 	IsMissionHaveDone(sceneId,selfId,x210221_g_MissionIdPre) <= 0 then
    	return
    end
    --��������ɹ��������
	if IsMissionHaveDone(sceneId,selfId,x210221_g_MissionId) > 0 then
		return 
	end
    if IsHaveMission(sceneId,selfId,x210221_g_MissionId) > 0 then
			AddNumText(sceneId,x210221_g_ScriptId,x210221_g_MissionName,2,-1);
		--���������������
	elseif x210221_CheckAccept(sceneId,selfId) > 0 then
			AddNumText(sceneId,x210221_g_ScriptId,x210221_g_MissionName,1,-1);
	end
end

--**********************************
--����������
--**********************************
function x210221_CheckAccept( sceneId, selfId )
	--��������
	if GetLevel( sceneId, selfId ) >= x210221_g_MissionLevel then
		return 1
	else
		return 0
	end
end

--**********************************
--����
--**********************************
function x210221_OnAccept( sceneId, selfId )
	--������������б�
	AddMissionEx( sceneId,selfId, x210221_g_MissionId, x210221_g_ScriptId )		--��������
	SetMissionEvent(sceneId,selfId, x210221_g_MissionId,3)	--���������¼���3��ʾ����仯�¼�
	
	misIndex = GetMissionIndexByID(sceneId,selfId,x210221_g_MissionId)	--�õ���������к�
	SetMissionByIndex(sceneId,selfId,misIndex,x210221_g_Param_ok,0)	--�������кŰ���������ĵ�0λ��0
	Msg2Player(  sceneId, selfId,"#Y�������񣺲�׽����",MSG2PLAYER_PARA )
	CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, SCENE_DALI, x210221_g_SignPost.x, x210221_g_SignPost.z, x210221_g_SignPost.tip )
end

--**********************************
--����
--**********************************
function x210221_OnAbandon( sceneId, selfId )
	--ɾ����������б��ж�Ӧ������
    DelMission( sceneId, selfId, x210221_g_MissionId )
end

--**********************************
--����
--**********************************
function x210221_OnContinue( sceneId, selfId, targetId )
	--�ύ����ʱ��˵����Ϣ
    BeginEvent(sceneId)
		AddText(sceneId,x210221_g_MissionName)
		AddText(sceneId,x210221_g_MissionComplete)
		AddMoneyBonus( sceneId, x210221_g_MoneyBonus )
		--for i, item in g_ItemBonus do
		--	AddItemBonus( sceneId, item.id, item.num )
		--end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210221_g_ScriptId,x210221_g_MissionId)
end

--**********************************
--����Ƿ�����ύ
--**********************************
function x210221_CheckSubmit( sceneId, selfId )
	
	misIndex = GetMissionIndexByID(sceneId,selfId,x210221_g_MissionId)	--�õ���������к�
	bDone = GetMissionParam(sceneId,selfId,misIndex,x210221_g_Param_ok)	--�������кŰ���������ĵ�0λ��1
	return bDone
end

--**********************************
--�ύ
--**********************************
function x210221_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x210221_CheckSubmit( sceneId, selfId )>0 then
	
		petcount = LuaFnGetPetCount(sceneId, selfId) --ȡ�ó�������
		for	i=0,petcount-1 do
		
			petdataid = LuaFnGetPet_DataID(sceneId, selfId, i) --ȡ�ó�����
			if petdataid==x210221_g_PetDataID then
    			--BeginAddItem(sceneId)
				--for i, item in g_ItemBonus do
				--	AddItem( sceneId,item.id, item.num )
				--end
				--ret = EndAddItem(sceneId,selfId)
				
				--����������
				--if ret > 0 then
					ret0 = LuaFnDeletePet(sceneId, selfId, i)
					ret1 = DelMission( sceneId, selfId, x210221_g_MissionId )
					if ret0>0 and ret1>0 then
						MissionCom( sceneId,selfId, x210221_g_MissionId )
						--AddItemListToHuman(sceneId,selfId)
						AddMoney(sceneId,selfId,x210221_g_MoneyBonus );
						LuaFnAddExp( sceneId, selfId,1500)
						BeginEvent(sceneId)
							strText = "�������"
							AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,selfId)
						Msg2Player(  sceneId, selfId,"#Y������񣺲�׽����",MSG2PLAYER_PARA )
						CallScriptFunction( 210223, "OnDefaultEvent",sceneId, selfId, targetId)
					end
				--else	--������û�мӳɹ�
				--	BeginEvent(sceneId)
				--		strText = "��������,�޷��������"
				--		AddText(sceneId,strText);
				--	EndEvent(sceneId)
				--	DispatchMissionTips(sceneId,selfId)
				--end
			end
		end
	end
end

--**********************************
--ɱ����������
--**********************************
function x210221_OnKillObject( sceneId, selfId, objdataId, objId )
end

--**********************************
--���������¼�
--**********************************
function x210221_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--���߸ı�
--**********************************
function x210221_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--����ı�
--**********************************
function x210221_OnPetChanged( sceneId, selfId, petdataId )
	if petdataId==x210221_g_PetDataID then --���������
		misIndex = GetMissionIndexByID(sceneId,selfId,x210221_g_MissionId)	--�õ���������к�
		SetMissionByIndex(sceneId,selfId,misIndex,x210221_g_Param_ok,1)	--�������кŰ���������ĵ�0λ��1

		BeginEvent(sceneId)
			strText = "׽�����������������!"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

--**********************************
--����ύ����Ʒ������
--**********************************
function x210221_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
end
