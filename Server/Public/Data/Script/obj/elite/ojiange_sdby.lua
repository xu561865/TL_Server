--剑阁精英怪物
--[首领]蜀道白猿
--怪物

x320701_g_PosCount =10
x320701_g_RespawnPos={	
				{x=65,z=252},
				{x=95,z=271},
				{x=93,z=224},
				{x=91,z=190},
				{x=44,z=199},
				{x=65,z=180},
				{x=121,z=277},
				{x=135,z=246},
				{x=119,z=212},
				{x=141,z=257}
		}

--**********************************
--事件交互入口
--**********************************
function x320701_OnDefaultEvent( sceneId, selfId,targetId )
	
end

function x320701_OnDie( sceneId, selfId, killerId )
	pos = random(1,x320701_g_PosCount)
	SetRevPos(sceneId, selfId, x320701_g_RespawnPos[pos].x,x320701_g_RespawnPos[pos].z )
end
