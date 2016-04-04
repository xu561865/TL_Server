--生长点脚本，红薯幼苗
--脚本号
--g_ScriptId = 711012

--此生长点编号
x711012_g_GpId = 513

--下一个生长点的编号
x711012_g_GpIdNext = 514

function	 x711012_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711012_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
