--生长点脚本，麻幼苗
--脚本号
--g_ScriptId = 711036

--此生长点编号
x711036_g_GpId = 537

--下一个生长点的编号
x711036_g_GpIdNext = 538

function	 x711036_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711036_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
