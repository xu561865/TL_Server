--生长点脚本，帛2
--脚本号
--g_ScriptId = 711046

--此生长点编号
x711046_g_GpId = 547

--下一个生长点的编号
x711046_g_GpIdNext = 548

function	 x711046_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711046_g_GpIdNext,sceneId,1,20105004)
	
	SetItemBoxOwner(sceneId,ItemBoxId,selfId)		--给ItemBox设定主人
	SetItemBoxPickOwnerTime(sceneId,ItemBoxId,480000)	--设定绑定时间
	EnableItemBoxPickOwnerTime(sceneId,ItemBoxId)		--保护时间开始计时

	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,600000)	--设定回收时间
	return 1
end
