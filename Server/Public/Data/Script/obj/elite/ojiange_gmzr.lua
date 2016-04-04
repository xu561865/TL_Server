--剑阁精英怪物
--[首领]鬼面侏儒
--怪物

x320704_g_PosCount =10
x320704_g_RespawnPos={	
			{x=209,z=146},
			{x=166,z=161},
			{x=139,z=60},
			{x=167,z=43},
			{x=125,z=82},
			{x=186,z=76},
			{x=238,z=55},
			{x=275,z=41},
			{x=275,z=80},
			{x=233,z=98}
		}

--**********************************
--事件交互入口
--**********************************
function x320704_OnDefaultEvent( sceneId, selfId,targetId )
	
end

function x320704_OnDie( sceneId, selfId, killerId )
	pos = random(1,x320704_g_PosCount)
	SetRevPos(sceneId, selfId, x320704_g_RespawnPos[pos].x,x320704_g_RespawnPos[pos].z )
end
