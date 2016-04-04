--±¦²ØÌ½²âÆ÷

--½Å±¾ºÅ
x300004_g_scriptId = 300004

x300004_g_event = 500500
--**********************************
--Ë¢ÐÂÊÂ¼þ
--**********************************
function x300004_OnDefaultEvent( sceneId, selfId, targetId, eventId )
	CallScriptFunction(x300004_g_event,"OnUseItem",sceneId, selfId, targetId, eventId)
end

function x300004_IsSkillLikeScript( sceneId, selfId)
	return 0;
end
