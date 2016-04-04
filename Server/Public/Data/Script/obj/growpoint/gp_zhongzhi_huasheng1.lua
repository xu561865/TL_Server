--生长点脚本，花生幼苗
--脚本号
--g_ScriptId = 711009

--此生长点编号
x711009_g_GpId = 510

--下一个生长点的编号
x711009_g_GpIdNext = 511

function	 x711009_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711009_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
