--洛阳NPC
--苏辙
--普通

x000000_g_scriptId=000000

--**********************************

--事件交互入口

--**********************************

function x000000_OnDefaultEvent( sceneId, selfId,targetId )

	BeginEvent(sceneId)

		AddText(sceneId,"你可以选择建立属于自己的商铺。")

		AddNumText(sceneId,x000000_g_scriptId,"建立自己的商店",-1,0)
		AddNumText(sceneId,x000000_g_scriptId,"管理自己的商店",-1,1)
		AddNumText(sceneId,x000000_g_scriptId,"查看所有商店",-1,2)

		AddNumText(sceneId,x000000_g_scriptId,"查看正准备盘出的店",-1,3)

	EndEvent(sceneId)

	DispatchEventList(sceneId,selfId,targetId)

end



--**********************************

--事件列表选中一项

--**********************************

function x000000_OnEventRequest( sceneId, selfId, targetId, eventId )

		--0.建立自己的商店->显示建店条款->由客户端请求建店
		if	GetNumText()==0	then

			BeginEvent(sceneId)

				AddText(sceneId,"#{PS_OPEN_SHOP_NOTICE}")

			EndEvent(sceneId)

			DispatchMissionDemandInfo(sceneId,selfId,targetId,x000047_g_ScriptId,0,1)

	
		--1.管理自己店铺
		elseif	GetNumText()==1	then
		
			--1.0通过店铺名来判定是否此店已经打开
			strShop0Name = LuaFnGetShopName(sceneId, selfId, 0)
			strShop1Name = LuaFnGetShopName(sceneId, selfId, 1)
			
			--1.1没店铺直接发错误提示
			if((strShop0Name == "")and(strShop1Name == "")) then
				BeginEvent(sceneId)

					strText = "对不起，你好象并没有店铺。"

					AddText(sceneId,strText);

				EndEvent(sceneId)

				DispatchMissionTips(sceneId,selfId)
				
			--1.2有店铺根据不同情况不同处理
			else
				--1.2.1有两个店铺，等待进一步选择
				if((strShop0Name ~= "") and (strShop1Name ~= "")) then
						BeginEvent(sceneId)

							AddText(sceneId,"哦哦，原来是掌柜的到了，请问您要去哪间店看看？")

							AddNumText(sceneId,x000000_g_scriptId,"店铺1  "..strShop0Name,-1,4)
							AddNumText(sceneId,x000000_g_scriptId,"店铺2  "..strShop1Name,-1,5)
		
				EndEvent(sceneId)
						DispatchEventList(sceneId,selfId,targetId)
				
				--1.2.2只有一个直接打开这个
				elseif(strShop0Name ~= "") then
						LuaFnOpenPlayerShop(sceneId, selfId, 0)
				
				--1.2.3只有一个直接打开这个
				elseif(strShop1Name ~= "") then
						LuaFnOpenPlayerShop(sceneId, selfId, 1)
				end
				
			end

		--2.察看所有商店的列表

		elseif	GetNumText()==2	then

			DispatchPlayerShopList( sceneId, selfId, targetId )	
			
		--3.察看所有盘出商店的列表
		elseif	GetNumText()==3	then

			DispatchPlayerShopSaleOutList( sceneId, selfId, targetId )	
			
		--4.察看自己身上的指定商店
		elseif	GetNumText()==4	then

			LuaFnOpenPlayerShop(sceneId, selfId, 0)
			
		--5.察看自己身上的指定商店
		elseif	GetNumText()==5	then

			LuaFnOpenPlayerShop(sceneId, selfId, 1)
		end


end



--**********************************

--继续

--**********************************

function x000000_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )

	ApplyPlayerShop( sceneId, selfId, targetId )

end

