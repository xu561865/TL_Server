--生长点脚本，玉米幼苗
--脚本号
--g_ScriptId = 711006

--此生长点编号
x711006_g_GpId = 507

--下一个生长点的编号
x711006_g_GpIdNext = 508

function	 x711006_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711006_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
