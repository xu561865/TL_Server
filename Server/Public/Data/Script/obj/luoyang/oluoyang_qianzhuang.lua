--钱庄脚本

--脚本号
x000076_g_scriptId = 000076

--所拥有的事件ID列表
--g_eventList={211105,211106,211108}	

--购买4个存储箱花费的钱
--默认有20个格子，此时购买下一个需要花费50000（5金币）
x000076_g_Box	 = {{Capacity=20,Money=50000},
			{Capacity=40,Money=100000},
			{Capacity=60,Money=200000},
			{Capacity=80,Money=400000}
	    }

x000076_g_BoxNum = 0

--npc点击默认函数，这里用来显示对话文字和功能按钮
function x000076_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		--添加打开银行界面的按钮
		AddNumText(sceneId, 7, "打开银行")
		--得到当前银行的存储格数
		local CurrentRentIndex = GetBankRentIndex(sceneId, selfId)
		--查找存储箱序号
		x000076_g_BoxNum = x000076_FindBoxNum( sceneId, selfId,targetId,CurrentRentIndex )
		if x000076_g_BoxNum ~= 0 then
			AddNumText(sceneId, x000076_g_Box[x000076_g_BoxNum].Capacity, "购买新的储物箱")
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x000076_OnEventRequest( sceneId, selfId, targetId, eventId )
		--打开银行
		if eventId == 7 then
			BankBegin(sceneId, selfId,targetId)	
		--购买新的储物箱
		elseif eventId == 8 then
			--得到当前银行的存储格数
			local CurrentRentIndex = GetBankRentIndex(sceneId, selfId)
			--查找存储箱序号
			x000076_g_BoxNum = x000076_FindBoxNum( sceneId, selfId,targetId,CurrentRentIndex )

			if GetMoney( sceneId, selfId) >= x000076_g_Box[x000076_g_BoxNum].Money then
				CostMoney(sceneId,selfId,x000076_g_Box[x000076_g_BoxNum].Money)
				--增加存储箱并提示
				x000076_EnableBankBox( sceneId, selfId,targetId,x000076_g_BoxNum )
				--打开银行界面
	  			BankBegin(sceneId, selfId,targetId)	
			else
				BeginEvent(sceneId)
	  				AddText(sceneId,"你的金钱不足");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,selfId)
			end
		else
			--得到当前银行的存储格数
			local CurrentRentIndex = GetBankRentIndex(sceneId, selfId)
			--查找存储箱序号
			x000076_g_BoxNum = x000076_FindBoxNum( sceneId, selfId,targetId,CurrentRentIndex )
			--需要花费钱的显示
			x000076_g_NeedMoney = x000076_MoneyChange( sceneId, selfId,targetId,x000076_g_Box[x000076_g_BoxNum].Money)
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,x000076_g_scriptId);
				UICommand_AddInt(sceneId,targetId);
				UICommand_AddInt(sceneId,8)
				UICommand_AddString(sceneId,"OnEventRequest");
				UICommand_AddString(sceneId,"如果要购买储物箱，你需要花费"..x000076_g_NeedMoney..".");
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 24)		--银行这里的询问窗口这里必须填写24
		end
end

--自定义函数，给出序号，打开第序号个存储箱
function x000076_EnableBankBox( sceneId, selfId,targetId,Num )
	--需要花费钱的显示
	x000076_g_NeedMoney = x000076_MoneyChange( sceneId, selfId,targetId,x000076_g_Box[Num].Money)
	EnableBankRentIndex(sceneId, selfId, Num+1)
	BeginEvent(sceneId)
		AddText(sceneId,"你花费"..x000076_g_NeedMoney.."，得到一个储物箱");
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--自定义函数，给出容量,返回序号
function x000076_FindBoxNum( sceneId, selfId,targetId,Capacity )
	--得到储物柜序号
	for i, findBox in x000076_g_Box do
		if findBox.Capacity == Capacity then
			return i
		end
	end
	return 0
end

--自定义函数,给出变量Money,返回xx金xx银xx铜,这里不处理数字是0的情况
function x000076_MoneyChange( sceneId, selfId,targetId,Money )
		x000076_g_Money = Money
		x000076_g_Bronze = mod(x000076_g_Money,100)
		x000076_g_Silver = (mod(x000076_g_Money,10000) - x000076_g_Bronze)/100
		x000076_g_Gold = (x000076_g_Money - x000076_g_Bronze - x000076_g_Silver * 100)/10000
		if x000076_g_Gold ~= 0 and x000076_g_Silver ~= 0 and x000076_g_Bronze ~= 0 then
			x000076_g_MoneyMessage = x000076_g_Gold.."#-02"..x000076_g_Silver.."#-03"..x000076_g_Bronze.."#-04"
		elseif x000076_g_Gold ~= 0 and x000076_g_Silver ~= 0 and x000076_g_Bronze == 0 then
			x000076_g_MoneyMessage = x000076_g_Gold.."#-02"..x000076_g_Silver.."#-03"
		elseif x000076_g_Gold ~= 0 and x000076_g_Silver == 0 and x000076_g_Bronze ~= 0 then
			x000076_g_MoneyMessage = x000076_g_Gold.."#-02"..x000076_g_Bronze.."#-04"
		elseif x000076_g_Gold ~= 0 and x000076_g_Silver == 0 and x000076_g_Bronze == 0 then
			x000076_g_MoneyMessage = x000076_g_Gold.."#-02"
		elseif x000076_g_Gold == 0 and x000076_g_Silver ~= 0 and x000076_g_Bronze ~= 0 then
			x000076_g_MoneyMessage = x000076_g_Silver.."#-03"..x000076_g_Bronze.."#-04"
		elseif x000076_g_Gold == 0 and x000076_g_Silver ~= 0 and x000076_g_Bronze == 0 then
			x000076_g_MoneyMessage = x000076_g_Silver.."#-03"
		elseif x000076_g_Gold == 0 and x000076_g_Silver == 0 and x000076_g_Bronze ~= 0 then
			x000076_g_MoneyMessage = x000076_g_Bronze.."#-04"
		else
			x000076_g_MoneyMessage = "#-04"
		end
		return x000076_g_MoneyMessage
end
