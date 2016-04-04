--无量山精英怪物
--[首领]闪电豹
--怪物

x320603_g_PosCount =10
x320603_g_RespawnPos={	
			{x=224,z=244},
			{x=224,z=217},
			{x=277,z=274},
			{x=193,z=135},
			{x=202,z=110},
			{x=254,z=44},
			{x=225,z=107},
			{x=277,z=48},
			{x=277,z=274},
			{x=191,z=79}
		}

--**********************************
--事件交互入口
--**********************************
function x320603_OnDefaultEvent( sceneId, selfId,targetId )
	
end

function x320603_OnDie( sceneId, selfId, killerId )
	pos = random(1,x320603_g_PosCount)
	SetRevPos(sceneId, selfId, x320603_g_RespawnPos[pos].x,x320603_g_RespawnPos[pos].z )
end
