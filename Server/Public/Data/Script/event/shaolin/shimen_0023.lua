--����������
--Ѱ��
--MisDescBegin
--�ű���
x220023_g_ScriptId = 220023

--ǰ������
--g_MissionIdPre =

--�����
x220023_g_MissionId = 1060

--����Ŀ��npc
x220023_g_Name	="�۷�"

--������߱��
x220023_g_ItemId = 40002124

--���������������
x220023_g_ItemNeedNum = 1

--�������
x220023_g_MissionKind = 20

--����ȼ�
x220023_g_MissionLevel = 10

--�Ƿ��Ǿ�Ӣ����
x220023_g_IfMissionElite = 0

--���漸���Ƕ�̬��ʾ�����ݣ������������б��ж�̬��ʾ�������**********************
--�����Ƿ��Ѿ����
x220023_g_IsMissionOkFail = 0		--�����ĵ�0λ

--������Ҫ�õ�����Ʒ
x220023_g_DemandItem={{id=40002124,num=1}}		--�ӱ����м���

--������
x220023_g_MissionRound	= 11			--��¼ѭ����������ĵ�10����
--�����Ƕ�̬**************************************************************

--���������һλ�����洢����õ��Ľű���

--�����ı�����
x220023_g_MissionName="��������������"
x220023_g_MissionInfo="�����ɨ�㣬ȥ��ɽ�Ŵ�ɨ�ɾ�����ɨ����Ҫ��ɨ�㻹���ҡ�"  --��������
x220023_g_MissionTarget="��ɨɽ��"		--����Ŀ��
x220023_g_ContinueInfo="ɽ�Ŵ�ɨ�ɾ�����"		--δ��������npc�Ի�
x220023_g_MissionComplete="���������ֵ���"					--�������npc˵���Ļ�

--MisDescEnd

--**********************************
--������ں���
--**********************************
function x220023_OnDefaultEvent( sceneId, selfId, targetId )	--����������ִ�д˽ű�
	--��������ɹ��������ʵ��������������������Ͳ�����ʾ�������ټ��һ�αȽϰ�ȫ��
    --if IsMissionHaveDone(sceneId,selfId,x220023_g_MissionId) > 0 then
	--	return
	--end
	--����ѽӴ�����
	if IsHaveMission(sceneId,selfId,x220023_g_MissionId) > 0 then
		--���������������Ϣ
		BeginEvent(sceneId)
			AddText(sceneId,x220023_g_MissionName)
			AddText(sceneId,x220023_g_ContinueInfo)
			for i, item in x220023_g_DemandItem do
				AddItemDemand( sceneId, item.id, item.num )
			end
		EndEvent()
		bDone = x220023_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x220023_g_ScriptId,x220023_g_MissionId,bDone)		
    --���������������
    elseif x220023_CheckAccept(sceneId,selfId) > 0 then
		--�����������ʱ��ʾ����Ϣ
		BeginEvent(sceneId)
			AddText(sceneId,x220023_g_MissionName)
			AddText(sceneId,x220023_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x220023_g_MissionTarget)
			--for i, item in g_ItemBonus do
			--	AddItemBonus( sceneId, item.id, item.num )
			--end
			--for i, item in g_RadioItemBonus do
			--	AddRadioItemBonus( sceneId, item.id, item.num )
			--end
			EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x220023_g_ScriptId,x220023_g_MissionId)
    end
end

--**********************************
--�о��¼�
--**********************************
function x220023_OnEnumerate( sceneId, selfId, targetId )
    --����ѽӴ�����
    if IsHaveMission(sceneId,selfId,x220023_g_MissionId) > 0 then
		AddNumText(sceneId,x220023_g_ScriptId,x220023_g_MissionName,2,-1);
		--���������������
	elseif x220023_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x220023_g_ScriptId,x220023_g_MissionName,1,-1);
	end
end

--**********************************
--����������
--**********************************
function x220023_CheckAccept( sceneId, selfId )
	--��Ҫ1�����ܽ�
	if GetLevel( sceneId, selfId ) >= 1 then
		return 1
	else
		return 0
	end
end

--**********************************
--����
--**********************************
function x220023_OnAccept( sceneId, selfId )
	--������������б�
	AddMission( sceneId,selfId, x220023_g_MissionId, x220023_g_ScriptId, 0, 0, 0 )
	BeginAddItem(sceneId)
		--�����ż�����Ʒ
		AddItem( sceneId,x220023_g_ItemId, x220023_g_ItemNeedNum )
	ret = EndAddItem(sceneId,selfId)
		--����������
	if ret > 0 then
		misIndex = GetMissionIndexByID(sceneId,selfId,x220023_g_MissionId)			--�õ���������к�
		SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--�������кŰ���������ĵ�0λ��0 (����������)
		SetMissionByIndex(sceneId,selfId,misIndex,1,x220023_g_ScriptId)						--�������кŰ���������ĵ�1λ��Ϊ����ű���
		SetMissionByIndex(sceneId,selfId,misIndex,4,3)						--�������кŰ���������ĵ�1λ��Ϊ����Ŀ�������ţ�3Ϊɽ��
		AddItemListToHuman(sceneId,selfId)
		--�õ�����
		x220023_g_MissionRound = GetMissionData(sceneId,selfId,11)
		--��������1
		x220023_g_MissionRound = x220023_g_MissionRound + 1
		if	x220023_g_MissionRound >= 21 then
			SetMissionData(sceneId, selfId, 11, 1)
		else
			SetMissionData(sceneId, selfId, 11, x220023_g_MissionRound)
		end
		--���������ϵĵ����Ƿ��Ѿ������������������Ѿ����㣬����������ı�����Ϊ0
		--if x220023_CheckSubmit( sceneId, selfId ) == 1 then
		--	SetMissionByIndex(sceneId,selfId,misIndex,0,1)					--��������ɱ�־��Ϊ1
		--end
		--��ʾ���ݸ�������Ѿ�����������
		BeginEvent(sceneId)
			AddText(sceneId,x220023_g_MissionInfo)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		Msg2Player(  sceneId, selfId,"#Y��������������ʦ������",MSG2PLAYER_PARA )
	else
		--������û�мӳɹ�
		BeginEvent(sceneId)
			strText = "��������,�޷���������"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

--**********************************
--����
--**********************************
function x220023_OnAbandon( sceneId, selfId )
	--ɾ����������б��ж�Ӧ������
    DelMission( sceneId, selfId, x220023_g_MissionId )
	for i, item in x220023_g_DemandItem do
		DelItem( sceneId, selfId, item.id, item.num )
	end
	SetMissionData(sceneId,selfId,11,0)	--������0
end

--**********************************
--����
--**********************************
function x220023_OnContinue( sceneId, selfId, targetId )
	--�ύ����ʱ��˵����Ϣ
    BeginEvent(sceneId)
		AddText(sceneId,x220023_g_MissionName)
		AddText(sceneId,x220023_g_MissionComplete)
		--for i, item in g_ItemBonus do
		--	AddItemBonus( sceneId, item.id, item.num )
		--end
		--for i, item in g_RadioItemBonus do
		--	AddRadioItemBonus( sceneId, item.id, item.num )
		--end
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x220023_g_ScriptId,x220023_g_MissionId)
end

--**********************************
--����Ƿ�����ύ
--**********************************
function x220023_CheckSubmit( sceneId, selfId )
	misIndex = GetMissionIndexByID(sceneId,selfId,x220023_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,0)
    if num == 1 then
		return 1
	end
	return 0
end

--**********************************
--�ύ
--**********************************
function x220023_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	local Level = GetLevel( sceneId, selfId)	
	if x220023_CheckSubmit( sceneId, selfId, selectRadioId ) then
		for i, item in x220023_g_DemandItem do
			DelItem( sceneId, selfId, item.id, item.num )
		end
		DelMission( sceneId, selfId, x220023_g_MissionId )
		MissionCom( sceneId,selfId, x220023_g_MissionId )
		--�õ�����
		x220023_g_MissionRound = GetMissionData(sceneId,selfId,11)
		--���㽱�����������
		if mod(x220023_g_MissionRound,10) == 0 then
			x220023_g_Exp = Level * 10 * 10										--�ȼ�+�����������ܾ�����ڳ�����Ӱ��
		else
			x220023_g_Exp = Level * mod(x220023_g_MissionRound,10) * 10
		end
		if	floor((x220023_g_MissionRound - 1) / 10) >=1  then
			x220023_g_Exp = x220023_g_Exp +50												--11~20������ÿ����������50�㾭��
		end
		--���Ӿ���ֵ
		AddExp( sceneId,selfId,x220023_g_Exp)
		AddMoney( sceneId, selfId, x220023_g_Exp)	
		--��ʾ�Ի���
		BeginEvent(sceneId)
			AddText(sceneId,"��ϲ����������񣬸���"..x220023_g_Exp.."�㾭���"..x220023_g_Exp.."Ǯ")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--ɱ����������
--**********************************
function x220023_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--���������¼�
--**********************************
function x220023_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--���߸ı�
--**********************************
function x220023_OnItemChanged( sceneId, selfId, itemdataId )
end