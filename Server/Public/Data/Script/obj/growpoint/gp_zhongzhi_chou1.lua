--生长点脚本，绸幼苗
--脚本号
--g_ScriptId = 711042

--此生长点编号
x711042_g_GpId = 543

--下一个生长点的编号
x711042_g_GpIdNext = 544

function	 x711042_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711042_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
