--生长点脚本，纱幼苗
--脚本号
--g_ScriptId = 711066

--此生长点编号
x711066_g_GpId = 567

--下一个生长点的编号
x711066_g_GpIdNext = 568

function	 x711066_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711066_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
