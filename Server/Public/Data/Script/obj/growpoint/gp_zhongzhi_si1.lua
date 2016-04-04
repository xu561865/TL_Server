--生长点脚本，丝幼苗
--脚本号
--g_ScriptId = 711051

--此生长点编号
x711051_g_GpId = 552

--下一个生长点的编号
x711051_g_GpIdNext = 553

function	 x711051_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711051_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
