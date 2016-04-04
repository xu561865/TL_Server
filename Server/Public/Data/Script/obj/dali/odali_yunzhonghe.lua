--大理NPC
--云中鹤
--普通

--**********************************
--事件交互入口
--**********************************
function x002017_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"听说大理国要召开什么武林大会，我也来凑凑热闹，哎呀呀，这大理国的女子啊，个个都水灵灵的真招人喜欢。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
