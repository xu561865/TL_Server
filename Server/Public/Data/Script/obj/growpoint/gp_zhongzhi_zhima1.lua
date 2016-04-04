--生长点脚本，芝麻幼苗
--脚本号
--g_ScriptId = 711018

--此生长点编号
x711018_g_GpId = 5193

--下一个生长点的编号
x711018_g_GpIdNext = 520

function	 x711018_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711018_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
