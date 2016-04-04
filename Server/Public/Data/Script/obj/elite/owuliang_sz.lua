--无量山精英怪物
--[首领]山蛛
--怪物

x320604_g_PosCount =10
x320604_g_RespawnPos={	
			{x=164,z=70},
			{x=154,z=42},
			{x=136,z=47},
			{x=125,z=91},
			{x=126,z=235},
			{x=127,z=191},
			{x=161,z=172},
			{x=198,z=195},
			{x=171,z=217},
			{x=164,z=97}
		}

--**********************************
--事件交互入口
--**********************************
function x320604_OnDefaultEvent( sceneId, selfId,targetId )
	
end

function x320604_OnDie( sceneId, selfId, killerId )
	pos = random(1,x320604_g_PosCount)
	SetRevPos(sceneId, selfId, x320604_g_RespawnPos[pos].x,x320604_g_RespawnPos[pos].z )
end
