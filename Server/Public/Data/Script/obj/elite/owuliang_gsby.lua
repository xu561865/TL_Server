--无量山精英怪物
--[首领]高山白猿
--怪物

x320601_g_PosCount =10
x320601_g_RespawnPos={	
			{x=91,z=153},
			{x=66,z=148},
			{x=54,z=132},
			{x=92,z=192},
			{x=84,z=178},
			{x=126,z=154},
			{x=42,z=130},
			{x=85,z=179},
			{x=57,z=114},
			{x=62,z=201}
		}

--**********************************
--事件交互入口
--**********************************
function x320601_OnDefaultEvent( sceneId, selfId,targetId )
	
end

function x320601_OnDie( sceneId, selfId, killerId )
	pos = random(1,x320601_g_PosCount)
	SetRevPos(sceneId, selfId, x320601_g_RespawnPos[pos].x,x320601_g_RespawnPos[pos].z )
end
