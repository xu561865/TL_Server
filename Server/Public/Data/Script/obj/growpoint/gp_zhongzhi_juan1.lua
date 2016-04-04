--生长点脚本，绢幼苗
--脚本号
--g_ScriptId = 711048

--此生长点编号
x711048_g_GpId = 549

--下一个生长点的编号
x711048_g_GpIdNext = 550

function	 x711048_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711048_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
