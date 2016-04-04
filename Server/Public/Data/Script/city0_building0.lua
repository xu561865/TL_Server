--苏州NPC
--杨婷
--美女

--工具
x805007_g_shoptableindex=7

x805007_g_scriptId=805007

--**********************************
--事件交互入口
--**********************************
function x805007_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"你是不是缺少劳动工具啊？别着急，我马上给你拿。")
		AddNumText(sceneId,x805007_g_scriptId,"购买工具",-1,0)
		AddNumText(sceneId,x805007_g_scriptId,"设置树木到一级",-1,1)
		AddNumText(sceneId,x805007_g_scriptId,"设置树木到二级",-1,2)
		AddNumText(sceneId,x805007_g_scriptId,"设置树木到三级",-1,3)
		AddNumText(sceneId,x805007_g_scriptId,"设置树木到四级",-1,4)
		AddNumText(sceneId,x805007_g_scriptId,"设置树木到五级",-1,5)
		AddNumText(sceneId,x805007_g_scriptId,"回到入口场景",-1,6)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x805007_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		CityBuildingChange(sceneId, selfId, 2, 1)
	elseif GetNumText() == 2 then
		CityBuildingChange(sceneId, selfId, 2, 2)
	elseif GetNumText() == 3 then
		CityBuildingChange(sceneId, selfId, 2, 3)
	elseif GetNumText() == 4 then
		CityBuildingChange(sceneId, selfId, 2, 4)
	elseif GetNumText() == 5 then
		CityBuildingChange(sceneId, selfId, 2, 5)
	elseif GetNumText() == 6 then
		NewWorld(sceneId, selfId, 1, 177, 144)
	end
end
