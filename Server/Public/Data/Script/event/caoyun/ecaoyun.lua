--MisDescBegin

x311010_g_MissionId = 4021

x311010_g_ScriptId = 311010
--MisDescEnd
-- 漕运使对话UI 	0
-- 交易UI					1

--任务步骤 
--1.弹出漕运使对话UI
--2.弹出货商UI
--3.弹出交易UI
--4.选择"热销"时价格改变
--5.选择"杀价"时价格改变
--6.选择"获得官票"后，界面的显示，后一位，若是1，则表示接到了，显示正确的信息；
--																				若是0，则表示没接到，提示错误。
--7.

--任务变量
--第一位存的是(卖)热销的值  						第0位		Price_Up
--第二位存的是(买)杀价的值							第1位		Price_Down
--第三位存的是身上盐、铁、米的数量			第2位   盐*100+铁*10+米
--第四位存的是热销的CD上次使用时间			第3位		
--第五位存的是杀价的CD上次使用时间			第4位		
--第六位存的是官票上的面额  						第5位		Balance
--第七位存的是哪个漕运使，1:代表洛阳的漕运使，2:代表苏州，3代表大理，4代表可以出售漕货的		第6位 TransNPC
--第八位存的是货商上次发生事件的时间，一定的时间内，只能执行一次货商的特殊事件。
--
--官票的物品编号40002109
--g_CashItem={{id=40002109,num=1}}
x311010_g_CashItem_id = 40002109
x311010_g_CashItem_count = 1

--**********************************
--任务入口函数
--**********************************
function x311010_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
  if IsMissionHaveDone(sceneId,selfId,x311010_g_MissionId) > 0 then
		return
	end
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x311010_g_MissionId) > 0 then
--发送任务需求的信息

--		BeginEvent(sceneId)
--		AddText(sceneId,g_MissionName)
--		AddText(sceneId,g_ContinueInfo)
--		for i, item in g_DemandItem do
--			AddItemDemand( sceneId, item.id, item.num )
--		end
--		EndEvent( )

--		bDone = CheckSubmit( sceneId, selfId )
--		DispatchMissionDemandInfo(sceneId,selfId,targetId,x311010_g_ScriptId,x311010_g_MissionId,bDone)


	--满足任务接收条件
	elseif x311010_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
	end
end

--**********************************
--列举事件
--**********************************
function x311010_OnEnumerate( sceneId, selfId, targetId )
--如果玩家完成过这个任务

	  if IsMissionHaveDone(sceneId,selfId,x311010_g_MissionId) > 0 then
	   	return 
		end

    --如果已接此任务
    if IsHaveMission(sceneId,selfId,x311010_g_MissionId) > 0 then
--			AddNumText(sceneId,x311010_g_ScriptId,"买卖漕货");
--			AddNumText(sceneId,x311010_g_ScriptId,"兑换官票");
			CallScriptFunction( SCENE_SCRIPT_ID, "PlaySoundEffect", sceneId, selfId, 101 );
			
			local TransportNPCName=GetName(sceneId,targetId);
			local TransNPC = -1;

			if TransportNPCName == "赵明诚" then
				TransNPC = 1;
			elseif TransportNPCName == "陆士铮" then
				TransNPC = 3;
			elseif TransportNPCName == "王若禹" then
				TransNPC = 2;
			elseif TransportNPCName == "货商" then
			
				local ItemNum = GetItemCount(sceneId,selfId,x311010_g_CashItem_id)
				if ItemNum < x311010_g_CashItem_count then
					BeginUICommand(sceneId)
						UICommand_AddInt(sceneId,5)
						UICommand_AddInt(sceneId,6)
					EndUICommand(sceneId)
					DispatchUICommand(sceneId,selfId, 0)
					return
				end
				
				--***
				misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)

				local Pre_Time = GetMissionParam(sceneId,selfId,misIndex,7)
				Pre_Time = 0
				local Now_Time = LuaFnGetCurrentTime()

				if Now_Time - Pre_Time > 10*60 then
					SetMissionByIndex(sceneId,selfId,misIndex,7,Now_Time)
					--随机一次事件
					--接下面
					--****
				else
					BeginUICommand(sceneId)
						UICommand_AddInt(sceneId,5)
						UICommand_AddInt(sceneId,10)
					EndUICommand(sceneId)
					DispatchUICommand(sceneId,selfId, 0)
					return
				end
					--是否出现出售漕货
				if 1 > 0 then
						TransNPC = 4;
						SetMissionByIndex(sceneId,selfId,misIndex,6,TransNPC)
						x311010_OnPopupBargainingUI(sceneId, selfId );
						return
				end
			
				--是否出现结束杀价cool down			
				if 1 < 0 then
					--结束他的杀CD
					misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
					SetMissionByIndex(sceneId,selfId,misIndex,4,0)
					
					BeginUICommand(sceneId)
						UICommand_AddInt(sceneId,5)
						UICommand_AddInt(sceneId,11)
						UICommand_AddInt(sceneId,0)
					EndUICommand(sceneId)
					DispatchUICommand(sceneId,selfId, 0)
					return
						
				end
			
				--是否出现结束热销cool down
				if 1 < 0 then
					--结束他的热销CD
					misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
					SetMissionByIndex(sceneId,selfId,misIndex,3,0)
					
					BeginUICommand(sceneId)
						UICommand_AddInt(sceneId,5)
						UICommand_AddInt(sceneId,11)
						UICommand_AddInt(sceneId,1)
					EndUICommand(sceneId)
					DispatchUICommand(sceneId,selfId, 0)
					return
						
				end
				
				BeginUICommand(sceneId)
					UICommand_AddInt(sceneId,5)
					UICommand_AddInt(sceneId,10)
				EndUICommand(sceneId)
				DispatchUICommand(sceneId,selfId, 0)
				return
				
			end
			
			if TransNPC == -1 then
				return
			end
			
			misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
			SetMissionByIndex(sceneId,selfId,misIndex,6,TransNPC)
			SetMissionByIndex(sceneId,selfId,misIndex,0,0)
			SetMissionByIndex(sceneId,selfId,misIndex,1,0)
			
--			local Mission_Round =	GetMissionData(sceneId,selfId,2)
--	missiondata中第2位记录的是漕运的环数
--			PrintStr("发送环数：")
--			PrintNum(Mission_Round+1)
--			SetMissionData(sceneId,selfId,2,Mission_Round + 1)
--			PrintStr("发送完毕！")
			
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,3)
				--client 要在UI 上显示"买卖漕货"和"兑换官票"这2个button
				UICommand_AddInt(sceneId,targetId)
				--并且把NPC的ID传给client，以备下一步调用。
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 0)
			
    --满足任务接收条件
    elseif x311010_CheckAccept(sceneId,selfId) > 0 then
    
    	local TransportNPCName=GetName(sceneId,targetId);
			local TransNPC = -1;
			
			if TransportNPCName == "赵明诚" then
				TransNPC = 1;
			elseif TransportNPCName == "陆士铮" then
				TransNPC = 3;
			elseif TransportNPCName == "王若禹" then
				TransNPC = 2;
			elseif TransportNPCName == "货商" then
				TransNPC = 4;
			end
			
			if TransportNPCName == "货商" then
				BeginUICommand(sceneId)
					UICommand_AddInt(sceneId,5)
					UICommand_AddInt(sceneId,10)
				EndUICommand(sceneId)
				DispatchUICommand(sceneId,selfId, 0)
				return
			end
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,4)
				--client 要在UI 上显示"获得官票"这个button
				UICommand_AddInt(sceneId,targetId)
				--并且把NPC的ID传给client，以备下一步调用。
				UICommand_AddInt(sceneId,TransNPC)
				

			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 0)
		else
			
			BeginUICommand(sceneId)
					UICommand_AddInt(sceneId,5)
					UICommand_AddInt(sceneId,10)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 0)
			return

    end
end 


--**********************************
--检测接受条件
--**********************************
function x311010_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel( sceneId, selfId ) >= 1 then
		return 1
	else
		return 0
	end
end

function x311010_OnHaggleUp( sceneId, selfId )	--点击该任务"热销"后执行此脚本

--判断他是否可热销
--比如时间的判断，判断这次和上次之间时间的差距
--should add some code

--取任务变量的值
	misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
	Price_Up = GetMissionParam(sceneId,selfId,misIndex,0)
	Pre_Time = GetMissionParam(sceneId,selfId,misIndex,3)
	TransNpc = GetMissionParam(sceneId,selfId,misIndex,6)

	local Now_Time = LuaFnGetCurrentTime();
--当前时间怎么取?
	if Now_Time - Pre_Time < 10*60 then
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,5)
				UICommand_AddInt(sceneId,9)
				UICommand_AddInt(sceneId,Pre_Time + 10*60 - Now_Time)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 0)
			return
			
	end
	if TransNpc == 0 then
		return
	end

--经计算改变此Price_Up
--****
--should add some code

--热销后价格变为10000
	Price_Up = 10000
	--设置成新的值

	SetMissionByIndex(sceneId,selfId,misIndex,0,Price_Up)	

--还需要存储这时的时间
--当前时间怎么取?
	local New_Time = LuaFnGetCurrentTime();
	SetMissionByIndex(sceneId,selfId,misIndex,3,New_Time)	
--should add some code
	BeginEvent(sceneId)
		strText = "热销成功，商品卖出价提升为1金币"			
		AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
	BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,4)
--热销后价格变为Price_Up
			UICommand_AddInt(sceneId,misIndex)
--此时热销的冷却时间变为10分钟，并告知client
	
--第2位表示当前还剩的PriceUp时间
		Pre_Time = GetMissionParam(sceneId,selfId,misIndex,3)
		Now_Time = LuaFnGetCurrentTime();
		if Now_Time - Pre_Time < 10*60 then
			UICommand_AddInt(sceneId,Pre_Time + 10*60 - Now_Time)
		else
			UICommand_AddInt(sceneId,0)
		end
		--第3位表示当前还剩的PriceDown时间
		Pre_Time = GetMissionParam(sceneId,selfId,misIndex,4)
		if Now_Time - Pre_Time < 15*60 then
			UICommand_AddInt(sceneId,Pre_Time + 15*60 - Now_Time)
		else
			UICommand_AddInt(sceneId,0)
		end
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1)
end


function x311010_OnHaggleDown( sceneId, selfId )	--点击该任务"杀价"后执行此脚本

--判断他是否可杀价
--比如时间的判断，判断这次和上次之间时间的差距
--should add some code
--取任务变量的值
	misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
	Price_Down = GetMissionParam(sceneId,selfId,misIndex,1)
	Pre_Time = GetMissionParam(sceneId,selfId,misIndex,4)
	TransNpc = GetMissionParam(sceneId,selfId,misIndex,6)
	

--当前时间怎么取?
	Now_Time = LuaFnGetCurrentTime();
	if Now_Time - Pre_Time < 15*60 then

			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,5)
				UICommand_AddInt(sceneId,9)
				UICommand_AddInt(sceneId,Pre_Time + 15*60 - Now_Time)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 0)
			return
			
	end
	
	if TransNpc == 0 then
		return
	end

--经计算改变此Price_Up
--*****
--should add some code

--杀价后价格变为7000
	Price_Down = 7000
	--设置成新的值

	SetMissionByIndex(sceneId,selfId,misIndex,1,Price_Down)	
	


--还需要存储这时的时间
--当前时间怎么取?
	local New_Time = LuaFnGetCurrentTime();
	SetMissionByIndex(sceneId,selfId,misIndex,4,New_Time)	
--should add some code

	BeginEvent(sceneId)
		strText = "杀价成功，商品买入价降低为70银币"			
		AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)

	BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,5)
--杀价后价格变为Price_Down
			UICommand_AddInt(sceneId,misIndex)
--			UICommand_AddInt(sceneId,15*60)
--此时热销的冷却时间变为15分钟，并告知client
--第2位表示当前还剩的PriceUp时间
		Pre_Time = GetMissionParam(sceneId,selfId,misIndex,3)
		Now_Time = LuaFnGetCurrentTime();
		if Now_Time - Pre_Time < 10*60 then
			UICommand_AddInt(sceneId,Pre_Time + 10*60 - Now_Time)
		else
			UICommand_AddInt(sceneId,0)
		end
		--第3位表示当前还剩的PriceDown时间
		Pre_Time = GetMissionParam(sceneId,selfId,misIndex,4)
		if Now_Time - Pre_Time < 15*60 then
			UICommand_AddInt(sceneId,Pre_Time + 15*60 - Now_Time)
		else
			UICommand_AddInt(sceneId,0)
		end
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1)

end

--**********************************
--杀死怪物或玩家
--**********************************
function x311010_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x311010_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x311010_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--接这个任务
--也就是点了“获得官票”
--**********************************
function x311010_OnAcceptMission( sceneId, selfId )

  --如果已接此任务
  if IsHaveMission(sceneId,selfId,x311010_g_MissionId) > 0 then
  		return
  end
  
	local ItemNum = GetItemCount(sceneId,selfId,x311010_g_CashItem_id)
	if ItemNum >= x311010_g_CashItem_count then
		--1,0,1是控制x311010_OnKillObject,x311010_OnEnterArea,x311010_OnItemChanged是否有用
		ret = AddMission( sceneId,selfId, x311010_g_MissionId, x311010_g_ScriptId, 0, 0, 0 )
		misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)			--得到任务的序列号
		SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0 (任务完成情况)
		SetMissionByIndex(sceneId,selfId,misIndex,1,0)
		SetMissionByIndex(sceneId,selfId,misIndex,2,0)
		SetMissionByIndex(sceneId,selfId,misIndex,3,0)
		SetMissionByIndex(sceneId,selfId,misIndex,4,0)
		--计算到底该给他多少钱
		--should add some code
		local Balance = 20000;
		SetMissionByIndex(sceneId,selfId,misIndex,5,Balance)
		SetMissionByIndex(sceneId,selfId,misIndex,6,0)
		SetMissionByIndex(sceneId,selfId,misIndex,7,0)
		if ret > 0 then
			AddItemListToHuman(sceneId,selfId)
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,5)
				UICommand_AddInt(sceneId,2)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 0)
		end
	elseif x311010_CheckAccept(sceneId,selfId) > 0 then
		--1,0,1是控制x311010_OnKillObject,x311010_OnEnterArea,x311010_OnItemChanged是否有用
		BeginAddItem( sceneId )
		AddItem( sceneId, x311010_g_CashItem_id, x311010_g_CashItem_count )
		ret = EndAddItem( sceneId, selfId )
		CallScriptFunction( SCENE_SCRIPT_ID, "PlaySoundEffect", sceneId, selfId, 62 );
		if ret > 0 then 
		
			ret = AddMission( sceneId,selfId, x311010_g_MissionId, x311010_g_ScriptId, 0, 0, 0 )
			misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)			--得到任务的序列号
			SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0 (任务完成情况)
			SetMissionByIndex(sceneId,selfId,misIndex,1,0)
			SetMissionByIndex(sceneId,selfId,misIndex,2,0)
			SetMissionByIndex(sceneId,selfId,misIndex,3,0)
			SetMissionByIndex(sceneId,selfId,misIndex,4,0)
			--计算到底该给他多少钱
			--should add some code
			local Balance = 20000;
			SetMissionByIndex(sceneId,selfId,misIndex,5,Balance)
			SetMissionByIndex(sceneId,selfId,misIndex,6,0)
			SetMissionByIndex(sceneId,selfId,misIndex,7,0)
			
			if ret > 0 then
				AddItemListToHuman(sceneId,selfId)
				BeginUICommand(sceneId)
					UICommand_AddInt(sceneId,5)
					UICommand_AddInt(sceneId,2)
				EndUICommand(sceneId)
				DispatchUICommand(sceneId,selfId, 0)
			end
			
		else
		
			BeginEvent(sceneId)
				strText = "背包已满,无法接受任务"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			
		end
			
	end

end

--**********************************
--弹出交易界面
--就是在漕运使处点击了“买卖漕货”或者点击货商，并随机弹出了交易界面
--**********************************
function x311010_OnPopupBargainingUI( sceneId, selfId )

	  if IsMissionHaveDone(sceneId,selfId,x311010_g_MissionId) > 0 then
	   	return 
		end
	
    --如果已接此任务
    if IsHaveMission(sceneId,selfId,x311010_g_MissionId) > 0 then

  	  local ItemNum = GetItemCount(sceneId,selfId,x311010_g_CashItem_id)

			if ItemNum < x311010_g_CashItem_count then
				BeginUICommand(sceneId)
					UICommand_AddInt(sceneId,5)
					UICommand_AddInt(sceneId,6)
				EndUICommand(sceneId)
				DispatchUICommand(sceneId,selfId, 0)
				return
			end
			
    	local Mission_Round =	GetMissionData(sceneId,selfId,2)
    	if Mission_Round >= 20 then
    	
				BeginUICommand(sceneId)
					UICommand_AddInt(sceneId,5)
					UICommand_AddInt(sceneId,5)
				EndUICommand(sceneId)
				DispatchUICommand(sceneId,selfId, 0)
				return
				
    	end

			BeginUICommand(sceneId)
				--第1位表示这个UI具体是哪步。
				UICommand_AddInt(sceneId,3)
				
				misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
				local TransNPC = GetMissionParam(sceneId,selfId,misIndex,6)
				
				if TransNPC == 0 or TransNPC == -1 then
					return
				end
				
				--第2位表示这个任务索引号。
				UICommand_AddInt(sceneId,misIndex)
				
--				if TransNPC == 1 then
--					UICommand_AddInt(sceneId,1)
--				elseif TransNPC == 2 then
--					UICommand_AddInt(sceneId,2)
--				elseif TransNPC == 3 then
--					UICommand_AddInt(sceneId,3)
--				elseif TransNPC == 4 then
--					UICommand_AddInt(sceneId,4)
					--这里还要验证，是不是能出现买卖漕货这个UI
					--should add some code.
--				end
				--上面这步可能不发。
				
				--计算他对盐，铁，米的价格到底是多少，存到下面的变量中
				--should add some code
				local Price_Buy,Price_Sell;
				
--				if GetTime() == 23 or GetTime() == 0 then
						Price_Buy = 8000;
						Price_Sell = Price_Buy * 120 / 100
--				else
--						Price_Buy = 10000;
--						Price_Sell = Price_Buy * 120 / 100
--				end
				 
				--第3位表示买的价格
				UICommand_AddInt(sceneId,Price_Buy)
				--第4位表示卖的价格
				UICommand_AddInt(sceneId,Price_Sell)
				--第5位表示任务脚本的ID
				UICommand_AddInt(sceneId,x311010_g_ScriptId)
				--第6位表示货商不收哪种商品
				UICommand_AddInt(sceneId,1)
				--第7位表示当前还剩的PriceUp时间
				Pre_Time = GetMissionParam(sceneId,selfId,misIndex,3)
				Now_Time = LuaFnGetCurrentTime();
				if Now_Time - Pre_Time < 10*60 then
					UICommand_AddInt(sceneId,Pre_Time + 10*60 - Now_Time)
				else
					UICommand_AddInt(sceneId,0)
				end
--				PrintNum(Pre_Time + 10*60 - Now_Time);
				--第8位表示当前还剩的PriceDown时间
				Pre_Time = GetMissionParam(sceneId,selfId,misIndex,4)
				if Now_Time - Pre_Time < 15*60 then
					UICommand_AddInt(sceneId,Pre_Time + 15*60 - Now_Time)
				else
					UICommand_AddInt(sceneId,0)
				end
--				PrintNum(Pre_Time + 15*60 - Now_Time);

--client 要显示出交易界面，根据上面的第一个参数，来放盐、铁、米的button和显示杀价热销button
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 1)

		end

end

--**********************************
--购买或卖出某个盐，铁，米
--**********************************
function x311010_OnTrade( sceneId, selfId, ManipulateID )

--判断他是否可以操作这步
--should add some code

--			local trade,cargo;

			misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
			local TransNPC = GetMissionParam(sceneId,selfId,misIndex,6)
			local trade = 0;

--	 		trade = ManipulateID / 10;
--			cargo = mod(ManipulateID,10);
				
			if TransNPC == 0 or TransNPC == -1 then
				return
			end
			
--cargo
--1 对盐操作
--2	对铁操作
--3	对米操作

--trade
--0	买
--1 卖
--不用这位判断了。

--根据这个NPC和Player身上的情况来判断，对盐，铁，米这个东西是买还是卖
			if ManipulateID == TransNPC then

					--这时是购买盐
					--先判断这个Player是否已经购买了盐

					misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
					Price_Down = GetMissionParam(sceneId,selfId,misIndex,1)
					Cargo			= GetMissionParam(sceneId,selfId,misIndex,2)
					local Cargo_Standard = 0;
					local purchased = 0;

					--先判断这个Player是否已经购买了盐
					if TransNPC == 1 then
						Cargo_Standard = 100;
						if Cargo >= Cargo_Standard then
							purchased = 1;							
						end
					elseif TransNPC == 2 then
						Cargo_Standard = 10;
						if mod(Cargo,100) >= Cargo_Standard then
							purchased = 1;
						end
					elseif TransNPC == 3 then
						Cargo_Standard = 1;
						if mod(Cargo,10) >= Cargo_Standard then
							purchased = 1;
						end
					end
						
					if purchased > 0 then
					
						BeginUICommand(sceneId)
							UICommand_AddInt(sceneId,5)
							UICommand_AddInt(sceneId,7)
							UICommand_AddInt(sceneId,ManipulateID)
						EndUICommand(sceneId)
						DispatchUICommand(sceneId,selfId, 0)
				
						return
					end
					--should add some code

					if Price_Down == 0 then
					--没有经过杀价，这里要重新计算到底该多少钱购买
					--should add some code
--***					--和上面某部分相同就可以
						Price_Down = 8000;
						
						--取随机数
						--随机给玩家个东东
						BeginAddItem(sceneId)
						AddItem( sceneId,20101002, 1 )
						ret = EndAddItem(sceneId,selfId)
						if ret > 0 then
							AddItemListToHuman(sceneId,selfId)
						else
						--奖励物品没有加成功
							BeginEvent(sceneId)
								strText = "背包已满,没有拿到奖励物品"
								AddText(sceneId,strText);
							EndEvent(sceneId)
							DispatchMissionTips(sceneId,selfId)
						end	
					end

					Balance = GetMissionParam(sceneId,selfId,misIndex,5)
					Balance = Balance - Price_Down;
					SetMissionByIndex(sceneId,selfId,misIndex,5,Balance)
					SetMissionByIndex(sceneId,selfId,misIndex,1,0)
					Cargo = Cargo + Cargo_Standard
					SetMissionByIndex(sceneId,selfId,misIndex,2,Cargo)
						BeginEvent(sceneId)
							if (ManipulateID ==1) then
								strText = "你成功买入了一份盐"
							elseif ( ManipulateID == 2) then
								strText = "你成功买入了一份铁"
							elseif( ManipulateID ==3) then
								strText = "你成功买入了一份米"
							end
							AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,selfId)
					--并把身上的标记位置为买入了盐
					--告诉client在UI上我的货舱内，显示盐
					BeginUICommand(sceneId)
							UICommand_AddInt(sceneId,5)
							UICommand_AddInt(sceneId,11)
							UICommand_AddInt(sceneId,Price_Down)
					EndUICommand(sceneId)
					DispatchUICommand(sceneId,selfId, 0)
				else
					--if TransNPC == 2 or TransNPC == 3 or TransNPC ==4 then
					--这时是出售盐
					misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
					Price_Up = GetMissionParam(sceneId,selfId,misIndex,0)
					Cargo			= GetMissionParam(sceneId,selfId,misIndex,2)
	
					--先判断这个Player是否已经购买了盐
					--should add some code
					
					local Cargo_Standard=0
					local purchased = 0;
					
					--先判断这个Player是否已经购买了盐
					if ManipulateID == 1 then
						Cargo_Standard = 100
						if Cargo < Cargo_Standard then
							purchased = 1;
						end
					elseif ManipulateID == 2 then
						Cargo_Standard = 10
						if mod(Cargo,100) < Cargo_Standard then
							purchased = 1;
						end
					elseif ManipulateID == 3 then
						Cargo_Standard = 1
						if mod(Cargo,10) < Cargo_Standard then
							purchased = 1;
						end
					end
					
					if purchased > 0 then
						BeginUICommand(sceneId)
							UICommand_AddInt(sceneId,5)
							UICommand_AddInt(sceneId,8)
							UICommand_AddInt(sceneId,ManipulateID)
						EndUICommand(sceneId)
						DispatchUICommand(sceneId,selfId, 0)
						
						return
					end
					
					if Price_Up == 0 then
					--没有经过热销，这里要重新计算到底该多少钱购买
					--should add some code
--***					--和上面某部分相同就可以
						Price_Up = 9600;
					end
					Balance = GetMissionParam(sceneId,selfId,misIndex,5)
					INP = 10000;
					--***INP要根据时间变化
					Balance = Balance + Price_Up + INP * 10 * mod( GetMissionData(sceneId,selfId,2) , 10 ) / 100;
					SetMissionByIndex(sceneId,selfId,misIndex,5,Balance)
					SetMissionByIndex(sceneId,selfId,misIndex,0,0)
					--并把身上的标记为置为卖出了货物

					Cargo = Cargo - Cargo_Standard

					SetMissionByIndex(sceneId,selfId,misIndex,2,Cargo)
					trade = 1
				end
--			elseif ManipulateID == 2 then
--should add some code
--			elseif ManipulateID == 3 then
--should add some code
--			elseif ManipulateID == 4 then
--should add some code
--		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,5)
			UICommand_AddInt(sceneId,11)
			UICommand_AddInt(sceneId,Price_Up)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 0)
		
--并取人物身上这个价格数据来执行操作。
--卖就是结束这环，环数要改变
		if trade == 1 then
--环数+1
			misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
			local Mission_Round =	GetMissionData(sceneId,selfId,2)
--missiondata中第2位记录的是漕运的环数
			SetMissionData(sceneId,selfId,2,Mission_Round + 1)
			BeginEvent(sceneId)
				if (ManipulateID == 1) then
					strText = "你成功卖出了一份盐"
				elseif ( ManipulateID == 2) then
					strText = "你成功卖出了一份铁"
				elseif ( ManipulateID ==3 ) then
					strText = "你成功卖出了一份米"				
				end
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			BeginEvent(sceneId)
				strText = format("本次漕运为第%d环", (Mission_Round + 1))
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
--奖励是最后根据sell_price和buy_price来计算的
--这里先不计算。

		end
	
end

--**********************************
--兑换官票
--**********************************
function x311010_OnRedeemUI( sceneId, selfId )

	  if IsMissionHaveDone(sceneId,selfId,x311010_g_MissionId) > 0 then
	   	return 
		end

    --如果已接此任务
    if IsHaveMission(sceneId,selfId,x311010_g_MissionId) > 0 then
				
				local ItemNum = GetItemCount(sceneId,selfId,x311010_g_CashItem_id)
				
				if ItemNum < x311010_g_CashItem_count then
					BeginUICommand(sceneId)
						UICommand_AddInt(sceneId,5)
						UICommand_AddInt(sceneId,4)
					EndUICommand(sceneId)
					DispatchUICommand(sceneId,selfId, 0)
					return
				end
				
			--结束此任务，并根据官票上的面额来给予相关奖励
			--钱和经验等
			--可能奖励还跟环数有关系
			GetMissionData(sceneId,selfId,2)
			
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,5)
				UICommand_AddInt(sceneId,3)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 0)
			
--		计算奖励
			misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
			Balance = GetMissionParam(sceneId,selfId,misIndex,5)
			TransNPC = GetMissionParam(sceneId,selfId,misIndex,6)
			
			if TransNPC == 4 then
				return
			end
			
			if	Balance > 20000	then
				AddMoney(sceneId,selfId,(Balance-20000 ));
				BeginEvent(sceneId)	
					strText = format("你在这次漕运中得到%d铜币的漕运花红。", (Balance-20000 ) )
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			else
				BeginEvent(sceneId)	
					strText = format("你经营不善，在这次漕运中没有获得花红。" )
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			end
			--扣除官票

			DelItem( sceneId, selfId, x311010_g_CashItem_id, x311010_g_CashItem_count )
			CallScriptFunction( SCENE_SCRIPT_ID, "PlaySoundEffect", sceneId, selfId, 66 );
			ret = DelMission( sceneId, selfId, x311010_g_MissionId )
			if ret > 0 then
				SetMissionData(sceneId,selfId,2,0)
			end
						
		end

end


--**********************************
--判断应该结束他的打压市场的cool down
--**********************************
function x311010_OnFinishHaggleDown( sceneId, selfId )

	misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,4,0)
			
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,5)
		UICommand_AddInt(sceneId,14)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 0)
	return
end

--**********************************
--判断应该结束他的哄抬物价的cool down
--**********************************
function x311010_OnFinishHaggleUp( sceneId, selfId )

	--结束他的热销CD
	misIndex = GetMissionIndexByID(sceneId,selfId,x311010_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,3,0)
		
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,5)
		UICommand_AddInt(sceneId,13)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 0)
	return
end

--**********************************
--放弃
--**********************************
function x311010_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    res = DelMission( sceneId, selfId, x311010_g_MissionId )
	if res > 0 then
		--移去任务物品
		DelItem( sceneId, selfId, x311010_g_CashItem_id, x311010_g_CashItem_count )
	end
	SetMissionData(sceneId,selfId,2,0)
end
