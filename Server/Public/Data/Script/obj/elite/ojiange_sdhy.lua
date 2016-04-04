--剑阁精英怪物
--[首领]蜀道黑猿
--怪物

x320702_g_PosCount =10
x320702_g_RespawnPos={	
			{x=67,z=133},
			{x=67,z=115},
			{x=40,z=140},
			{x=43,z=55},
			{x=83,z=54},
			{x=83,z=96},
			{x=67,z=167},
			{x=41,z=109},
			{x=99,z=70},
			{x=197,z=267}
		}

--**********************************
--事件交互入口
--**********************************
function x320702_OnDefaultEvent( sceneId, selfId,targetId )
	
end

function x320702_OnDie( sceneId, selfId, killerId )
	pos = random(1,x320702_g_PosCount)
	SetRevPos(sceneId, selfId, x320702_g_RespawnPos[pos].x,x320702_g_RespawnPos[pos].z )
end
