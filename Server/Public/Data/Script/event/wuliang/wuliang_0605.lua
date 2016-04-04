--探索地图任务
--无量玉璧
--MisDescBegin
--脚本号
x210605_g_ScriptId = 210605

--前提任务
--g_MissionIdPre  = 

--任务号
x210605_g_MissionId = 495

--任务归类
x210605_g_MissionKind = 17

--任务等级
x210605_g_MissionLevel = 15

--是否是精英任务
x210605_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况*******
--任务是否已经完成
x210605_g_IsMissionOkFail = 0		--变量的第0位


--*******************以上是动态显示***********

--自定义
--g_Custom={{id="已眺望无量玉璧",num=1}}

--任务文本描述
x210605_g_MissionName="无量玉璧\n"
x210605_g_MissionInfo="  在这无量山中，有一个幽谷深潭，天气好的话，可以透过薄雾看到一个壮观的玉壁，仿佛仙子的妆镜。\n\n  那里隐约能看到仙人斗剑的景象，剑湖宫的剑法，好多从中悟出。"
x210605_g_MissionTarget="\n\n任务目标：\n到剑湖宫北面山谷边眺望无量玉璧"
x210605_g_ContinueInfo="  你看到了么？"		--未完成任务的npc对话
x210605_g_MissionComplete="  真是怀念过去啊，很多无量弟子一生不曾知道有这样一个去处，而有的人则把自己最美好的记忆沉淀于那里。"

--奖励

--交任务目标npc
x210605_g_Name = "辛双清"

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210605_OnDefaultEvent( sceneId, selfId, targetId )
	 --如果已完成任务
    if IsMissionHaveDone( sceneId, selfId, x210605_g_MissionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x210605_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210605_g_Name then
			--发送交任务前的需求信息
    		BeginEvent(sceneId)
    		AddText(sceneId,x210605_g_ContinueInfo);
    		EndEvent(sceneId)
    		
    		done = x210605_CheckSubmit( sceneId, selfId );
   			DispatchMissionDemandInfo(sceneId,selfId,targetId,x210605_g_ScriptId,x210605_g_MissionId,done)
 		end
    --满足任务接收条件
    elseif x210605_CheckAccept(sceneId,selfId) > 0 then
		--if GetName(sceneId,targetId) ~= x210605_g_Name then		--这个任务是探索地图,所以发任务和交任务是同一个npc,以前送货不是同一个npc,因此不需要这个判断
			--发送任务接受时显示的信息
	    	BeginEvent(sceneId)
    		AddText(sceneId,x210605_g_MissionName);
    		AddText(sceneId,x210605_g_MissionInfo);
    		AddText(sceneId,x210605_g_MissionTarget);
	    	EndEvent(sceneId)
	    	DispatchMissionInfo(sceneId,selfId,targetId,x210605_g_ScriptId,x210605_g_MissionId)
		--end
    end
end

--**********************************
--列举事件
--**********************************
function x210605_OnEnumerate( sceneId, selfId, targetId )
	
	if IsMissionHaveDone( sceneId, selfId, x210605_g_MissionId ) > 0 then
		return 
    elseif IsHaveMission(sceneId,selfId,x210605_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x210605_g_Name then
			AddNumText(sceneId, x210605_g_ScriptId,x210605_g_MissionName)
		end
    --满足任务接收条件
    elseif x210605_CheckAccept(sceneId,selfId) > 0 then
		--if GetName(sceneId,targetId) ~= x210605_g_Name then      --这个任务是探索地图,所以发任务和交任务是同一个npc,以前送货不是同一个npc,因此不需要这个判断
		AddNumText(sceneId, x210605_g_ScriptId, x210605_g_MissionName);
		--end
    end
end

--**********************************
--检测触发条件
--**********************************
function x210605_CheckAccept( sceneId, selfId )
	--bDone = IsMissionHaveDone( sceneId, selfId, g_MissionIdPre );
	--if bDone > 0 then
		return 1;
	--else
	--	return 0;
	--end
end

--**********************************
--接受
--**********************************
function x210605_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210605_g_MissionId, x210605_g_ScriptId, 0, 1, 0 )
	misIndex = GetMissionIndexByID(sceneId,selfId,x210605_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
end

--**********************************
--放弃
--**********************************
function x210605_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210605_g_MissionId )
end

--**********************************
--已经接了任务再给出的提示
--**********************************
function x210605_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
    AddText(sceneId,x210605_g_MissionComplete);
    EndEvent(sceneId)
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210605_g_ScriptId,x210605_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210605_CheckSubmit( sceneId, selfId )
    misIndex = GetMissionIndexByID(sceneId,selfId,x210605_g_MissionId)	
	num = GetMissionParam(sceneId,selfId,misIndex,0)
	if num < 1 then
		return 0
	else
		return 1
	end
end

--**********************************
--提交（完成）
--**********************************
function x210605_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	ret = x210605_CheckSubmit( sceneId, selfId );
	if ret > 0 then
		--删除玩家任务列表中对应的任务
		ret = DelMission( sceneId, selfId, x210605_g_MissionId );
		if ret > 0 then
			MissionCom( sceneId, selfId, x210605_g_MissionId )
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210605_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210605_OnEnterArea( sceneId, selfId, areaId )
	if areaId ==0611  then
		--显示看到景象对话框
		BeginEvent(sceneId)
			AddText(sceneId,"  ...（耳边依稀记起辛双清的描述）...\n\n  隐隐青山掩映着一处幽谷，鹤翔林间，仿佛一处仙境。薄雾中一块如玉般的大石若隐若现，怨不得这里叫做无量玉壁。  \n\n  玉壁成峰映水屏\n  修山点水落风情\n  谁家仙子开妆镜\n  便是人间万点金\n")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,selfId)
		--任务处理
		misIndex=GetMissionIndexByID(sceneId,selfId,x210605_g_MissionId)		--取得任务在任务列表中的index
		num = GetMissionParam(sceneId,selfId,misIndex,0)				--根据index取得任务变量第一位的值
		if num < 1 then				--如果不满足任务完成得条件
			SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)		--任务变量第一位增加1
			BeginEvent(sceneId)										--显示提示信息
				strText = format("无量玉璧（已完成）", GetMissionParam(sceneId,selfId,misIndex,0) )
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)						--将提示信息发出
		end
	end
end

--**********************************
--道具改变
--**********************************
function x210605_OnItemChanged( sceneId, selfId, itemdataId )
end
