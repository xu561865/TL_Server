--生长点脚本，帛幼苗
--脚本号
--g_ScriptId = 711045

--此生长点编号
x711045_g_GpId = 546

--下一个生长点的编号
x711045_g_GpIdNext = 547

function	 x711045_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711045_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
