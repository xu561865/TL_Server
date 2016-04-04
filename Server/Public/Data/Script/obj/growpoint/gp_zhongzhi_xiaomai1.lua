--生长点脚本，小麦1
--脚本号
--g_ScriptId = 711000

--此生长点编号
x711000_g_GpId = 501

--下一个生长点的编号
x711000_g_GpIdNext = 502

function	 x711000_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711000_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
