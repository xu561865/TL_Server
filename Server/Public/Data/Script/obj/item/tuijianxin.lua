function x300019_OnDefaultEvent( sceneId, selfId, targetId )	
	BeginEvent(sceneId)
			AddText(sceneId,"九大门派的兄弟姐妹们：#r#r你们好！#r#r请把你最得意的技能传授给这封信的持有人，这个人是大理城四大善人最可以信任的朋友。谢谢。");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


function x300019_IsSkillLikeScript( sceneId, selfId)
	return 0;
end
