--洛阳NPC

--单正

--普通



--**********************************

--事件交互入口

--**********************************

function x000022_OnDefaultEvent( sceneId, selfId,targetId )

	BeginEvent(sceneId)

		AddText(sceneId,"  现在漕路淤塞，改走旱路，加上又冒出好多黑市，漕帮兄弟们没的混了。#r #r  我向赵大人推荐这位怀丙师傅来治理淤塞，因为我亲眼见他利用机械从河道底下捞出铁牛，不简单啊。")

	EndEvent(sceneId)

	DispatchEventList(sceneId,selfId,targetId)

end

