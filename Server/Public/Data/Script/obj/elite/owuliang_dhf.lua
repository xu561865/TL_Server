--无量山精英怪物
--[首领]大黄蜂
--怪物

x320602_g_PosCount =10
x320602_g_RespawnPos={	
			{x=54,z=250},
			{x=58,z=266},
			{x=73,z=277},
			{x=156,z=267},
			{x=86,z=235},
			{x=105,z=223},
			{x=37,z=64},
			{x=58,z=47},
			{x=60,z=63},
			{x=92,z=87}
		}

--**********************************
--事件交互入口
--**********************************
function x320602_OnDefaultEvent( sceneId, selfId,targetId )
	
end

function x320602_OnDie( sceneId, selfId, killerId )
	pos = random(1,x320602_g_PosCount)
	SetRevPos(sceneId, selfId, x320602_g_RespawnPos[pos].x,x320602_g_RespawnPos[pos].z )
end
