--生长点脚本，缎幼苗
--脚本号
--g_ScriptId = 711054

--此生长点编号
x711054_g_GpId = 555

--下一个生长点的编号
x711054_g_GpIdNext = 556

function	 x711054_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711054_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
