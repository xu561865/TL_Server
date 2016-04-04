--生长点脚本，马铃薯幼苗
--脚本号
--g_ScriptId = 711030

--此生长点编号
x711030_g_GpId = 531

--下一个生长点的编号
x711030_g_GpIdNext = 532

function	 x711030_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711030_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
