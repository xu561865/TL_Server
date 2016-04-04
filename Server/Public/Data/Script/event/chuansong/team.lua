--传送函数
x400900_g_scriptId=400900
--传送函数
x400900_g_scriptId=400900

function	x400900_TransferFunc(sceneId, selfId, newSceneId, posX, posY)
	--如果玩家没有处于组队状态,则直接传送
	local life=LuaFnIsCharacterLiving( sceneId,selfId)
	if	life==0	then
		return
	else
		if	GetTeamId( sceneId, selfId)<0	then
			NewWorld(sceneId, selfId, newSceneId, posX, posY)
		--如果玩家处于组队状态但不处于组队跟随状态,则直接传送
		elseif	IsTeamFollow(sceneId, selfId)~=1	then
			NewWorld(sceneId, selfId, newSceneId, posX, posY)
		--如果玩家处于组队跟随状态,且玩家是队长,则小队传送
		elseif	LuaFnIsTeamLeader(sceneId,selfId)==1	 then
			num=LuaFnGetFollowedMembersCount( sceneId, selfId)
			local mems = {}
			for	i=0,num-1 do
				mems[i] = GetFollowedMember(sceneId, selfId, i)
				if mems[i] == -1 then
					return
				end
			end
			for	i=0,num-1 do
				NewWorld(sceneId, mems[i], newSceneId, posX, posY)
			end
		--如果玩家处于组队跟随状态,且不是队长,则……可以发条消息也好啊
		end
	end
end
