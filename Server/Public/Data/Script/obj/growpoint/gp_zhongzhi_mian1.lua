--生长点脚本，棉幼苗
--脚本号
--g_ScriptId = 711039

--此生长点编号
x711039_g_GpId = 540

--下一个生长点的编号
x711039_g_GpIdNext = 541

function	 x711039_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711039_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
