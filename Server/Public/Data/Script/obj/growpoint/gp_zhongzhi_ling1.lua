--生长点脚本，绫幼苗
--脚本号
--g_ScriptId = 711057

--此生长点编号
x711057_g_GpId = 558

--下一个生长点的编号
x711057_g_GpIdNext = 559

function	 x711057_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711057_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
