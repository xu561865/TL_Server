--生长点脚本，大米幼苗
--脚本号
--g_ScriptId = 711003

--此生长点编号
x711003_g_GpId = 504

--下一个生长点的编号
x711003_g_GpIdNext = 505

function	 x711003_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711003_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
