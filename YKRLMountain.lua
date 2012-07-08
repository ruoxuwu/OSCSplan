--SANGUOSHA EXTENSION-RETURN OF LEGEND--MOUNTAIN--
--Design: YOKA (2011)
--Code: 【群】皇叔
--Version：16.12 (After Taqing 16)
--Last Update：July 5 2012 23:50 UTC+8

module("extensions.YKRLMountain", package.seeall)

extension = sgs.Package("YKRLMountain")

--0112 姜维
luatiaoxincard = sgs.CreateSkillCard
{--挑衅 by 【群】皇叔
	name = "luatiaoxincard",
	once = true,
	will_throw = true,
	filter=function(self,targets,to_select,player)
		return to_select:getAttackRange() >= to_select:distanceTo(player) 
	end,
	on_effect=function(self,effect)
		local from = effect.from
		local to = effect.to
		local room = from:getRoom()
		local slash = room:askForCard(to, "slash", "@myslash:",sgs.QVariant(data))
		if slash then 
			local use = sgs.CardUseStruct()
  			use.card = slash
			use.to : append(from)
			use.from = to 
			room:useCard(use,false)
			return false 
		end
		if (not slash) and (not to:isNude()) then
			room:throwCard(room:askForCardChosen(from,to,"he",self:objectName()))
			return false
		end
	end,
}

luatiaoxin = sgs.CreateViewAsSkill{
	name = "luatiaoxin",
	n=0,
	view_filter=function()
		return false
	end,
	view_as=function(self, cards)        
		return luatiaoxincard:clone()
	end,
	enabled_at_play=function(self,player) 
		return (not player:hasUsed("#luatiaoxincard"))
	end,
	enabled_at_response=function(self,player,pattern)
		return false
	end,
}

luazhiji=sgs.CreateTriggerSkill
{--志继 by 【群】皇叔
luazhiji=sgs.CreateTriggerSkill{
	name = "luazhiji",
	frequency = sgs.Skill_Wake,
	priority=3,
	events = {sgs.TurnStart},
	can_trigger=function(self,player)
		return player:hasSkill(self:objectName()) and (player:getMark("luazhiji")==0)
	end,
	on_trigger=function(self,event,player,data)
--  	if player:getPhase() ~= sgs.Player_Start then return false end
		if (not player:faceUp()) then return false end
		local room = player:getRoom()
		if (player:isKongcheng() ) then
--  	if (not player:isWounded()) then return player:drawCards(2) end
--  	else
		local choice = room:askForChoice(player,self:objectName(),"recover_zj+draw_zj")
		if choice == "recover_zj" then 
			local recover = sgs.RecoverStruct()
			recover.who = player
			recover.reason = self:objectName()
			room:recover(player,recover)
		end 
		if choice == "draw_zj" then
			player:drawCards(2)
		end
		room:acquireSkill(player,"luaguanxing")
		room:loseMaxHp(player)
		player:addMark("luazhiji")
		return false
		end
	end,
}

--0112
luajiangwei = sgs.General(extension, "luajiangwei", "shu", 4)
luajaingwei:addSkill(luatiaoxin)
luajiangwei:addSkill(luazhiji)

sgs.LoadTranslationTable{
	["#zhanghe"] = "0209",
	["#dengai"] = "0215",
	["#liushan"] = "0113",
	["#jiangwei"] = "0112",
	["#sunce"] = "0310",
	["#erzhang"] = "0315",
	["#caiwenji"] = "0412",
	["#zuoci"] = "0409",
	["#zuocif"] = "9409",
}