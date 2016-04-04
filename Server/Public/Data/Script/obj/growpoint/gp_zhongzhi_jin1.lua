--生长点脚本，锦幼苗
--脚本号
--g_ScriptId = 711069

--此生长点编号
x711069_g_GpId = 570

--下一个生长点的编号
x711069_g_GpIdNext = 571

function	 x711069_OnRecycle(sceneId,selfId,targetId)
	itemBoxX = GetItemBoxWorldPosX(sceneId,targetId)
	itemBoxZ = GetItemBoxWorldPosZ(sceneId,targetId)
	ItemBoxId = ItemBoxEnterScene(itemBoxX,itemBoxZ,x711069_g_GpIdNext,sceneId,0)
	
	SetItemBoxMaxGrowTime(sceneId,ItemBoxId,450000)	--设定回收时间
	return 1
end
