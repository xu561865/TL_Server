--苏州NPC
--杨婷
--美女

--工具
x805008_g_shoptableindex=7

x805008_g_scriptId=805008

--**********************************
--事件交互入口
--**********************************
function x805008_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"请设置建筑物级别")
		AddNumText(sceneId,x805008_g_scriptId,"设置建筑到一级",-1,1)
		AddNumText(sceneId,x805008_g_scriptId,"设置建筑到二级",-1,2)
		AddNumText(sceneId,x805008_g_scriptId,"设置建筑到三级",-1,3)
		AddNumText(sceneId,x805008_g_scriptId,"设置建筑到四级",-1,4)
		AddNumText(sceneId,x805008_g_scriptId,"设置建筑到五级",-1,5)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x805008_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		CityBuildingChange(sceneId, selfId, 1, 1)
	elseif GetNumText() == 2 then
		CityBuildingChange(sceneId, selfId, 1, 2)
	elseif GetNumText() == 3 then
		CityBuildingChange(sceneId, selfId, 1, 3)
	elseif GetNumText() == 4 then
		CityBuildingChange(sceneId, selfId, 1, 4)
	elseif GetNumText() == 5 then
		CityBuildingChange(sceneId, selfId, 1, 5)
	end
	
end
