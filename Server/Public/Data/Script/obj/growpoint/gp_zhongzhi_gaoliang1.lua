--生长点脚本，高粱幼苗
--脚本号
--g_ScriptId = 711015

--此生长点编号
x711015_g_GpId = 516

--下一个生长点的编号
x711015_g_GpIdNext = 517

function	 x711015_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711015_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
