--生长点脚本，黄豆幼苗
--脚本号
--g_ScriptId = 711024

--此生长点编号
x711024_g_GpId = 525

--下一个生长点的编号
x711024_g_GpIdNext = 526

function	 x711024_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711024_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
