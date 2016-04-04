--生长点脚本，绒幼苗
--脚本号
--g_ScriptId = 711063

--此生长点编号
x711063_g_GpId = 564

--下一个生长点的编号
x711063_g_GpIdNext = 565

function	 x711063_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711063_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
