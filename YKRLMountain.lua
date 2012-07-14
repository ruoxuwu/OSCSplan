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

--刘禅
luaruoyu=sgs.CreateTriggerSkill{--若愚by卍冰の羽卍
        name="luaruoyu$",
        events=sgs.TurnStart,                
        on_trigger=function(self,event,player,data)
        local room=player:getRoom()
        if  player:hasFlag("luaruoyu_waked")then return false end
        local x=player:getHp()
        local m={} 
        for _,p in sgs.qlist(room:getOtherPlayers(player)) do
                        table.insert(m,p:getHp())                        
        end
        if x>math.min(unpack(m)) then m=nil return end
        local log=sgs.LogMessage()
        log.from =player
        log.type ="#luaruoyu"
        room:sendLog(log)
        room:setPlayerFlag(player,"luaruoyu_waked")
        local recover=sgs.RecoverStruct()
        recover.who=player
        recover.recover=1
        room:recover(player,recover)
        room:setPlayerProperty(player,"maxhp",sgs.QVariant(player:getMaxHP()+1))        
        room:attachSkillToPlayer(player,"jijiang")
    end
}

--固政 by [争据] Ellis 
Guzhenglist = {}
Guzheng_trs=sgs.CreateTriggerSkill{
        name="guzheng_trs",
        events={sgs.CardLost, sgs.PhaseChange},
        priority=-1,
        
        can_trigger=function()
                  return true
        end,
        
        on_trigger=function(self,event,player,data)
                local room = player:getRoom()
                local erzhang = room:findPlayerBySkillName(self:objectName())
                if erzhang == nil then return end
                
                if event == sgs.CardLost then
                        local current = room:getCurrent();
                        
                        if erzhang:objectName() == current:objectName() then return end
                        
                        if current:getPhase() == sgs.Player_Discard then
                                local move = data:toCardMove()
                                table.insert(Guzhenglist, move.card_id)
                        end
                else
                        if player:hasSkill(self:objectName()) then return end
                        if player:isDead() then return end

                        local cards = sgs.IntList()
                        for _,id in ipairs(Guzhenglist) do
                                if room:getCardPlace(id) == sgs.Player_DiscardedPile then
                                        cards:append(id)
                                end
                        end
                        table.remove(Guzhenglist)

                        if cards:isEmpty() then return end

                        if room:askForSkillInvoke(erzhang, self:objectName()) then
                                room:fillAG(cards, erzhang)

                                local to_back = room:askForAG(erzhang, cards, false, self:objectName())
                                player:obtainCard(sgs.Sanguosha:getCard(to_back))

                                cards:removeOne(to_back)

                                erzhang:invoke("clearAG")

                                for _,id in sgs.qlist(cards) do
                                        erzhang:obtainCard(sgs.Sanguosha:getCard(id))
                                end
                        end
                end
        end,
}

--魂姿 by 卍冰の羽卍
luahunzi = sgs.CreateTriggerSkill{
        frequency = sgs.Skill_Wake,
        name = "luahunzi",
        events = sgs.TurnStart,        
        on_trigger = function(self,event,player,data)
                if (not player:faceUp()) then return false end
        local room = player:getRoom()
                local x = player:getHp()
                local m = {}
                for _,p in sgs.qlist(room:getOtherPlayers(player)) do
                        table.insert(m,p:getHp())
                end
                if x > 1 then m=nil return false end
                local log = sgs.LogMessage()
                log.from = player
                log.type = "#luahunzi"
                room:sendLog(log)
        room:acquireSkill(player,"yingzi")
        room:acquireSkill(player,"yinghun")
        room:loseMaxHp(player)
        player:addMark("lua_hunzi")
        return false
    end,
        can_trigger=function(self,player)
        return player:hasSkill(self:objectName()) and (player:getMark("lua_hunzi")==0)
    end
}

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