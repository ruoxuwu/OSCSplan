--桌游志SP包
--现包含：SP关羽、、☆SP赵云、☆SP貂蝉、☆SP曹仁、☆SP庞统、☆SP张飞、☆SP刘备、☆SP大乔、☆SP吕蒙
module("extensions.BGSP", package.seeall)

extension = sgs.Package("BGSP")

--0806 SP关羽
luaspwusheng = sgs.CreateViewAsSkill
{--武圣 by 【群】皇叔
	name = "luaspwusheng",
	n = 1,
	
	view_filter = function(self, selected, to_select)
		return to_select:isRed() 
	end,
	
	view_as = function(self, cards)
		if #cards == 0 then return nil end
		if #cards == 1 then         
			local card = cards[1]
			local acard = sgs.Sanguosha:cloneCard("slash", card:getSuit(), card:getNumber()) 
			acard:addSubcard(card:getId())
			acard:setSkillName(self:objectName())
			return acard
		end
	end,
	
	enabled_at_play = function()
		return (sgs.Self:canSlashWithoutCrossbow()) or (sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Crossbow")
	end,
	
	enabled_at_response = function(self, player, pattern)
		return pattern == "slash"
	end,
}

luadanqi = sgs.CreateTriggerSkill
{--单骑 by 【群】皇叔, ibicdlcod修复魏武帝/神曹操不能觉醒的BUG。如果没有定义【马术】技能则不允许觉醒（未经测试）
	name = "luadanqi",
	frequency = sgs.Skill_Wake,
	events = {sgs.PhaseChange},
	
	can_trigger = function(self,target)
		if(sgs.Sanguosha:getSkill("luamashu") == nil) then return false end
		return target:hasSkill("luadanqi") and (target:getMark("luadanqi") == 0)
	end,
	
	on_trigger = function(self, event, player, data)
		if player:getPhase() ~= sgs.Player_Start then return false end
		local room = player:getRoom()
		if(player:getHandcardNum() > player:getHp()) and (room:getLord():isCaoCao()) then
			room:loseMaxHp(player,1)
			room:acquireSkill(player,"luamashu")
			player:addMark("luadanqi")
			return false
		end
	end,
}

luasp_guanyu = sgs.General(extension, "luasp-guanyu", "wei", 4)
luasp_guanyu:addSkill(luaspwusheng)
luasp_guanyu:addSkill(luadanqi)

sgs.LoadTranslationTable{
	["#luasp-guanyu"] = "0806",
}
-- ☆SP赵云、☆SP貂蝉 by佚名
luaNewSpZhaoyun=sgs.General(extension, "luaNewSpZhaoyun", "qun","3",true)
luaNewSpDiaochan=sgs.General(extension, "luaNewSpDiaochan", "qun","3",false)

ldtmp={}
luaLongdan = sgs.CreateViewAsSkill
{
	name = "luaLongdan",
	n = 1,
	
	view_filter = function(self, selected, to_select)
		if ldtmp[1] == "slash" then return to_select:inherits("Jink") end
		if ldtmp[1] == "jink" then return to_select:inherits("Slash") end
	end,
	
	view_as = function(self, cards)
		if #cards == 1 then
			local card = cards[1]
			local ld_card = sgs.Sanguosha:cloneCard(ldtmp[1], cards[1]:getSuit(), cards[1]:getNumber())
			ld_card:addSubcard(cards[1])
			ld_card:setSkillName(self:objectName())
			return ld_card
		end
	end,
	
	enabled_at_play = function(self, player, pattern) 
		ldtmp[1] = "slash"
		return(sgs.Self:canSlashWithoutCrossbow()) or (sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Crossbow")
	end,
	
	enabled_at_response = function(self, player, pattern)
		if(pattern == "jink") or (pattern == "slash") then 
			ldtmp[1] = pattern
			return true 
		end
	end,
}

luaChongzhen = sgs.CreateTriggerSkill
{
	name = "luaChongzhen",
	events = {sgs.CardEffected, sgs.CardEffect, sgs.CardResponsed},
			
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
						
		if event == sgs.CardEffected then
			local effect = data:toCardEffect()
			local value = sgs.QVariant()
			value:setValue(effect.from)
			room:setTag("chongzhenTo", value)
		elseif event == sgs.CardEffect then
			local effect = data:toCardEffect()
			if effect.card:getSkillName() == "luaLongdan" and not effect.to:isKongcheng() and room:askForSkillInvoke(player, "luaChongzhen") then
				local card_id = room:askForCardChosen(effect.from, effect.to, "h", "chongzhen")
				room:moveCardTo(sgs.Sanguosha:getCard(card_id), effect.from, sgs.Player_Hand, false)
			end
		else
			local card = data:toCard()
			local target = room:getTag("chongzhenTo"):toPlayer()
			if not target or card:getSkillName() ~= "luaLongdan" or target:isKongcheng() or not room:askForSkillInvoke(player, "luaChongzhen") then return false end
			local card_id = room:askForCardChosen(player, target, "h", "chongzhen")
			room:moveCardTo(sgs.Sanguosha:getCard(card_id), player, sgs.Player_Hand, false)
		end
	end,
}

luaLihunCard = sgs.CreateSkillCard 
{
	name = "lihuncard",
	
	filter = function(self, selected, to_select)
		if not to_select:getGeneral():isMale() or #selected>=1 then
			return false
		end
		if not #selected == 0 then
			return false
		end
		
		return true
	end,
 
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		room:throwCard(self)
		effect.from:turnOver()
		for _,cd in sgs.qlist(effect.to:getHandcards()) do
			room:moveCardTo(cd, effect.from, sgs.Player_Hand, false)
		end
		local value = sgs.QVariant()
		value:setValue(effect.to)
		room:setTag("LihunTarget", value)		
		effect.from:setFlags("Lihun_used")
	end,
}
 
luaLihunGet = sgs.CreateViewAsSkill
{
	name = "luaLihun",
	n = 1,
	view_filter = function(self, selected, to_selected)
		return true
	end,
	view_as = function(self, cards)
	if #cards == 0 then return end
		local acard = luaLihunCard:clone()
		acard:addSubcard(cards[1])
		return acard
	end,
	enabled_at_play = function(self, player)
		return not player:hasUsed("#lihuncard")
	end,
}
 
luaLihun = sgs.CreateTriggerSkill
{
	name = "luaLihun",
	events = sgs.PhaseChange,
	view_as_skill = luaLihunGet,
	priority = 3,
	can_trigger = function(self, player)
		return player:hasSkill(self:objectName()) and player:hasUsed("#lihuncard")
	end,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.PhaseChange and player:getPhase() == sgs.Player_Discard then
			local card_ids = sgs.IntList()
			local target = room:getTag("LihunTarget"):toPlayer()
			
			if(player:getCards("he"):length() <= target:getHp()) then
				for _,cd in sgs.qlist(player:getCards("he")) do
					if player:isNude() then return false end
					local cd_id = cd:getEffectiveId()
					if room:getCardPlace(cd_id) == sgs.Player_Hand then
						room:moveCardTo(cd, target, sgs.Player_Hand, false)
					else
						room:moveCardTo(cd, target, sgs.Player_Hand, true)
					end
				end
			else
				local x = target:getHp()
				local card_ids = sgs.IntList()
				for _,cd in sgs.qlist(player:getCards("he")) do
					local cd_id = cd:getEffectiveId()
					card_ids:append(cd_id)
				end
				for v =1 , x, 1 do
					room:fillAG(card_ids, player)
					local card_id = room:askForAG(player, card_ids, false, self:objectName())
					local card = sgs.Sanguosha:getCard(card_id)
					if room:getCardPlace(card_id) == sgs.Player_Hand then
						room:moveCardTo(card, target, sgs.Player_Hand, false)
					else
						room:moveCardTo(card, target, sgs.Player_Hand, true)
					end
					card_ids:removeOne(card_id)
					player:invoke("clearAG")                    
				end
			end
		end
		return false
	end,
}

luaBiyue = sgs.CreateTriggerSkill--闭月 by ibicdlcod
{
	name = "luaBiyue",
	events = {sgs.PhaseChange},
	frequency = sgs.Skill_Frequent,
	
	on_trigger = function(self, event, player, data)
		if(player:getPhase() == sgs.Player_Finish) then
			local room = player:getRoom()
			if(room:askForSkillInvoke(player, "luaBiyue")) then
				room:playSkillEffect("luaBiyue")
				player:drawCards(1)
			end
		end
		return false
	end
}


luaNewSpZhaoyun:addSkill(luaLongdan)
luaNewSpZhaoyun:addSkill(luaChongzhen)

luaNewSpDiaochan:addSkill(luaLihun)
luaNewSpDiaochan:addSkill(luaBiyue)

-- ☆SP曹仁 by佚名
----无懈可击用的附加技能
askfornull=sgs.CreateTriggerSkill{
	name="#askfornull",
	events=sgs.CardEffected,--卡片对其他角色生效
	priority=0,
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		local effect=data:toCardEffect()
		local card=effect.card--获取卡片
		if not card:inherits("TrickCard") then return false end--是否非延时锦囊
		local num=0--统计无懈可击的数目
		local t=true--上一圈是否有人出过无懈
		while t do
			t=false
			for _,theplayer in sgs.qlist(room:getAllPlayers()) do--循环，逐一检视所有角色
				if (not t and (theplayer:getMark("cannull")==1 and theplayer:getEquips():length() ~= 0 and theplayer:getHandcardNum() > theplayer:getHp()) or theplayer:hasNullification()) then--手里有无懈或者拥有无懈技能
					local nullcard=nil
					if num%2==0 then
						nullcard=room:askForCard(theplayer,"nullification","askfornullification1",data)--让他出一张无懈
						if nullcard ~= nil then
						room:playSkillEffect("luayz")
	                    room:setEmotion(theplayer, "nullification")
						end
					else
						nullcard=room:askForCard(theplayer,"nullification","askfornullification2",data)
						if nullcard ~= nil then
						room:playSkillEffect("luayz")
						room:setEmotion(theplayer, "nullification")
						end
					end
					if nullcard then
						t=true
						num=num+1--计数
					end
				end
			end
		end
		if num%2==1 then return true end
		if card:inherits("Collateral") or card:inherits("Lightning") then return false end
		card:onEffect(effect)--偶数张无懈，则原卡片有效
		return true
	end,
	can_trigger=function(self,player)
		return player and player:isAlive()
	end,
}
temp=sgs.General(extension,"temp","hide","0",true,true)
temp:addSkill(askfornull)
				
luaspcr = sgs.General(extension, "luaspcr", "wei", 4, true,false)
luakuiweisp = sgs.CreateTriggerSkill{
 name="luakuiweisp",
 events={sgs.PhaseChange},
 frequency = sgs.Skill_Frequency,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
if (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Draw) then
   if (player:getMark("kwx")) > 0 then
       local players=room:getAlivePlayers()
			local x = 0
			local players=room:getAlivePlayers()
			for _,aplayer in sgs.qlist(players) do
					if aplayer:getWeapon() then
					x = x+1
			        end
			end
			   if x==0 then return false end
			   local e = (player:getEquips():length()+player:getHandcardNum())
			   if x < e then
               room:askForDiscard(player, "luakuiweisp", x, false,true)
			   player:setMark("kwx",0)
			   else
			   player:throwAllHandCards()
			   player:throwAllEquips()
			   player:setMark("kwx",0)
			   end
    end
end	
if (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Finish) then 
    local players=room:getAlivePlayers()
			local x = 0
			local players=room:getAlivePlayers()
			for _,aplayer in sgs.qlist(players) do
					if aplayer:getWeapon() then
					x = x+1
			        end
			end
		if not room:askForSkillInvoke(player,self:objectName()) then return false end
		player:drawCards(x+2)
		player:turnOver()
		player:addMark("kwx")
end
end,
}

luayzCard=sgs.CreateSkillCard{--空白技能卡，无目标
	name="luayzCard",
	target_fixed=true,
	will_throw = true,
	on_effect = function(self, effect)
		room:throwCard(self)		
	end,
}
luayz=sgs.CreateViewAsSkill{
	name="luayz",
	n=1,
	view_filter = function(self, selected, to_select)
		return to_select:isEquipped()
	end,
	view_as=function(self,cards)
        if #cards==0 then return nil end
       if #cards==1 then      
		local acard=luayzCard:clone()--玩家操作的话当成无懈可击将造成对象选择问题……所以当成一张空白技能卡
		acard:addSubcard(cards[1])        
        acard:setSkillName(self:objectName())
		return acard
		end
	end,
	enabled_at_play=function(self,player,pattern)
		return false
	end,--出牌阶段不可用
	enabled_at_response=function(self,player,pattern)
		return sgs.Self:getHandcardNum() > sgs.Self:getHp() and pattern=="nullification"
	end,
}
luayzcf=sgs.CreateTriggerSkill{
	name="#luayzcf",
	events={sgs.CardResponsed,sgs.GameStart},--出无懈的时候
	on_trigger=function(self,event,player,data)
	        local room=player:getRoom()
		if event==sgs.GameStart then
			player:gainMark("cannull",1)--获得一枚标记，询问无懈时一定问你		
			return false
		end	
	end
}

sgs.LoadTranslationTable{
    ["crsp"] = "SP曹仁",
    ["luaspcr"] = "SP曹仁",
	["luakuiweisp"] = "溃围",
	["luayz"] = "严整",
	[":luakuiweisp"] = "回合结束阶段开始时，你可以摸2+X张牌，然后将你的武将牌翻面。在你的下个摸牌阶段开始时，你须弃置X张牌。X等于当时场上装备区内的武器牌的数量。",
	[":luayz"] = "若你的手牌数大于你的体力值，你可以将你装备区内的牌当[无懈可击]使用。",
	["cannull"]="lua无懈可击",
	["askfornullification1"]="你可以使用【无懈可击】使此次结算无效",
	["askfornullification2"]="你可以使用【无懈可击】使此次结算有效",
	["luayzCard"]="严整",
	["$luayz"]="无懈可击！",
	["designer:luaspcr"] = "官方"
}

luaspcr:addSkill(luakuiweisp)
luaspcr:addSkill(luayz)	
luaspcr:addSkill(luayzcf)
luaspcr:addSkill("#askfornull")		
  
--☆SP庞统 by佚名
cdids = sgs.IntList()
manjuan=sgs.CreateTriggerSkill{
name="manjuan",
events={sgs.CardLost,sgs.GameStart,sgs.CardGot,sgs.CardLostDone,sgs.CardDrawnDone},
can_trigger=function(self,event,player,data)
    return true end,
on_trigger=function(self,event,player,data)
	local room=player:getRoom()
	if event==sgs.CardLost then
	    local move=data:toCardMove()
		if move.to_place==sgs.Player_DiscardedPile and room:getCardPlace(move.card_id) == sgs.Player_DiscardedPile then
		    local card = sgs.Sanguosha:getCard(move.card_id)
            local value = sgs.QVariant()
            value:setValue(card)
            room:setTag("manjuancard", value)
		end
	elseif event==sgs.CardGot then
	    local move=data:toCardMove()
	    if move.to:hasSkill("manjuan") and move.to_place==sgs.Player_Hand and move.to:getMark("really")==0 then
		    local log= sgs.LogMessage()
            log.type = "#zuixiangthrow"
            log.from = player
		    log.arg  = card:objectName()
            room:sendLog(log)
		    room:throwCard(move.card_id)
			if move.to:getPhase()==sgs.Player_NotActive then return true end
			local num=sgs.Sanguosha:getCard(move.card_id):getNumber()
			local samenum = sgs.IntList()
			for _,id in sgs.qlist(cdids) do
			    if sgs.Sanguosha:getCard(id):getNumber()==num then 
				    samenum:append(id)
				end
			end
			room:fillAG(samenum, move.to)
		    local choice=room:askForAG(move.to, samenum, false,"manjuan")
			move.to:invoke("clearAG")
			if choice then
			    samenum:removeOne(choice)
				cdids:removeOne(choice)
			    move.to:addMark("really")
                move.to:obtainCard(sgs.Sanguosha:getCard(choice)) 
			    room:setPlayerMark(move.to,"really",0)
			end
			return true
		end
	elseif event==sgs.CardDrawnDone then
	    if player:hasSkill("manjuan") and player:getMark("really")==0 then
	        local n=data:toInt()
		    local hnum=player:getHandcardNum() 
			local i=0
		while i<n do
		    local card=sgs.Sanguosha:getCard(player:handCards():at(hnum-n))
			local log= sgs.LogMessage()
            log.type = "#zuixiangthrow"
            log.from = player
		    log.arg  = card:objectName()
            room:sendLog(log)
            room:throwCard(card)
			if player:getPhase()==sgs.Player_NotActive then return true end
			local num=card:getNumber()
			local samenum = sgs.IntList()
			for _,id in sgs.qlist(cdids) do
			    if sgs.Sanguosha:getCard(id):getNumber()==num then 
				    samenum:append(id)
				end
			end
			room:fillAG(samenum, player)
		    local choice=room:askForAG(player, samenum, false,"manjuan")
			player:invoke("clearAG")
			if choice then
			    samenum:removeOne(choice)
				cdids:removeOne(choice)
			    player:addMark("really")
                player:obtainCard(sgs.Sanguosha:getCard(choice)) 
			    room:setPlayerMark(player,"really",0)
			end
			i=i+1
		end
			return true
		end
	elseif event==sgs.GameStart then
	    if player:hasSkill("manjuan") then 
		    player:gainMark("@zuixiang",1) 
		    player:addMark("really") 
			player:drawCards(4)
			room:setPlayerMark(player,"really",0)
			return true
		end
	elseif event == sgs.CardLostDone then
        local card = room:getTag("manjuancard"):toCard()
		if not card then return false end
		if room:getCardPlace(card:getId()) == sgs.Player_DiscardedPile then
		    
		    cdids:append(card:getEffectiveId())
			room:removeTag("manjuancard")
        end
	end
end
}
zuixiang=sgs.CreateTriggerSkill{
name="zuixiang",
frequency=sgs.Skill_Limited,
events={sgs.TurnStart,sgs.CardEffected,sgs.CardUsed},
on_trigger=function(self,event,player,data)
	local room=player:getRoom()
	if event==sgs.TurnStart then 
	    if player:getMark("@zuixiang")==1 or player:getMark("startzuixiang")>0 then
		    if player:getMark("@zuixiang")==1 then 
	            if not room:askForSkillInvoke(player,"zuixiang") then return false end
			    player:loseMark("@zuixiang")
				player:addMark("startzuixiang")
			end
			player:addMark("really")
			for i=1,3 do
			    player:addToPile("zuixiangpile", room:drawCard(), true)
		    end
			room:setPlayerMark(player,"really",0)
			local samenum = sgs.IntList()
			local num = sgs.IntList()
            for _,id in sgs.qlist(player:getPile("zuixiangpile")) do
			    local n=sgs.Sanguosha:getCard(id):getNumber()
                if num:contains(n) then 
				    samenum:append(n)
				else
				    num:append(n)
				end
			end
			if not samenum:isEmpty() then 
				player:addMark("really")
				for _,id in sgs.qlist(player:getPile("zuixiangpile")) do
					player:obtainCard(sgs.Sanguosha:getCard(id)) 
			    end
			    room:setPlayerMark(player,"really",0)
				room:setPlayerMark(player,"startzuixiang",0)
				room:setPlayerMark(player,"zuixiangbasic",0)
				room:setPlayerMark(player,"zuixiangtrick",0)
				room:setPlayerMark(player,"zuixiangequip",0)
			else 
				for _,id in sgs.qlist(player:getPile("zuixiangpile")) do
                    local card = sgs.Sanguosha:getCard(id) 
                	if card:inherits("BasicCard") then
                        player:addMark("zuixiangbasic")
		            elseif card:inherits("TrickCard") then
		                player:addMark("zuixiangtrick")						
                    else
		                player:addMark("zuixiangequip")					
                    end
                end
			end
		end
	elseif event==sgs.CardEffected then
        local effect=data:toCardEffect()
	    if effect.to:getMark("zuixiangtrick")>0 and effect.card:inherits("TrickCard") then
            local log= sgs.LogMessage()
            log.type = "#zuixiangavoid"
            log.from = effect.to
		    log.arg  = effect.card:objectName()
            room:sendLog(log)
            return true
	    elseif effect.to:getMark("zuixiangbasic")>0 and effect.card:inherits("BasicCard") then
            local log= sgs.LogMessage()
            log.type = "#zuixiangavoid"
            log.from = effect.to
		    log.arg  = effect.card:objectName()
            room:sendLog(log)
            return true
	    end
	elseif event==sgs.CardUsed then 
	    local use=data:toCardUse()
		if player:getMark("zuixiangtrick")>0 and use.card:inherits("TrickCard") 
		or player:getMark("zuixiangbasic")>0 and use.card:inherits("BasicCard") 
		or player:getMark("zuixiangequip")>0 and use.card:inherits("EquipCard") then
			return true
		end
	end
end
}
pangtongsp=sgs.General(extension, "pangtongsp", "qun",3)
pangtongsp:addSkill(manjuan)		
pangtongsp:addSkill(zuixiang)
--[[sgs.LoadTranslationTable{
    ["sbpangtong"] = "SB庞统",
	["pangtongsp"] = "庞统",
	["manjuan"] = "漫卷",
	[":manjuan"] = "每当你将获得任何一张牌，将之置于弃牌堆。若此情况处于你的回合中，你可依次将与该牌点数相同的一张牌从弃牌堆置于你手上。",
	["zuixiang"] = "醉乡",
	["@zuixiang"] = "醉乡",
	[":zuixiang"] = "<b>限定技，</b>回合开始阶段开始时，你可以展示牌库顶的3张牌置于你的武将牌上，你不可以使用或打出与该些牌同类的牌，所有同类牌对你无效。之后每个你的回合开始阶段，你须重复展示一次，直至该些牌中任意两张点数相同时，将你武将牌上的全部牌置于你的手上。",
	["#zuixiangavoid"] = "%from 的技能 【<font color='yellow'><b>醉乡</b></font>】 被触发，这张 %arg 对他无效",
	["#zuixiangthrow"] = "%from 的技能 【<font color='yellow'><b>漫卷</b></font>】 被触发，将这张 %arg 置于弃牌堆",
} 	]]

-- ☆sp张飞 by佚名
luaspzf = sgs.General(extension, "luaspzf", "shu", 4, true,false)
luajie = sgs.CreateTriggerSkill
{
	name = "luajie",
	events = {sgs.Predamage,sgs.SlashProceed,sgs.PhaseChange},
	frequency = sgs.Skill_Compulsory,
can_trigger=function(self,player)
    return true
 end,
on_trigger = function(self, event, player, data)
		 local room=player:getRoom()
		local damage = data:toDamage()
		local card = damage.card
		if(event == sgs.Predamage and card:inherits("Slash")) and card:isRed() then
		  if not player:hasSkill("luajie") then return false end
		   damage.damage = damage.damage+1
				data:setValue(damage)
				return false
		end
	if(event == sgs.SlashProceed) then
	  local effect = data:toSlashEffect()
	  if not effect.to:hasFlag("dht") then return false end
	  local jinkh = room:askForCard(effect.to, "jink", "@luadahe:")
	  if jinkh ~= nil and jinkh:getSuit()==sgs.Card_Heart then
	      room:slashResult(effect, jinkh)
				return true
	  else
			room:slashResult(effect, nil)
			return true
	  end
    end	  
	if (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Finish) then
	for _,p in sgs.qlist(room:getOtherPlayers(player)) do
		    room:setPlayerFlag(p, "-dht")
	 end
    end
end,
}
luadahecard = sgs.CreateSkillCard
{--技能卡
        name="luadahecard",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if  #targets > 0  then return false end              				 
				if to_select:objectName() == player:objectName() then return false end
				if to_select:isKongcheng() then return false end
                return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local target = targets[1]
		local success = source:pindian(target, "luadahe", nil)
		if (success) then
		room:setPlayerFlag(source, "dh")
		room:setPlayerFlag(target, "dht")
		end
		end,
		}
luadahev=sgs.CreateViewAsSkill{
name="luadahev",
n=1,
view_filter=function(self,selected,to_select)
return false
end,
view_as = function(self, cards)
		return luadahecard:clone()
end,

enabled_at_play = function()
		return not sgs.Self:hasFlag("dh")
end,
enabled_at_response=function()
        return false
end,
}

luadahe = sgs.CreateTriggerSkill
{
	name = "luadahe",
	view_as_skill = luadahev,
	events = {sgs.Pindian},
	frequency = sgs.Skill_NotFrequent,
    priority=-1, 
on_trigger = function(self, event, player, data)
		 local room=player:getRoom() 
	if event == sgs.Pindian then
	   local pd=data:toPindian()
	   if pd.reason~="luadahe" then return false end
	   if pd.from_card:getNumber()>pd.to_card:getNumber() then
	  player:obtainCard(pd.to_card)
	  local zfhp = player:getHp()
	  local targets = sgs.SPlayerList()
                 for _, aplayer in sgs.qlist(room:getAlivePlayers()) do
                 if aplayer:getHp() <= zfhp then targets:append(aplayer) end
                 end
				local target = room:askForPlayerChosen(player, targets, "@luadahets")
				if target == nil then return false end
				room:moveCardTo(pd.to_card, target, sgs.Player_Hand, false)
	  else
	     room:showAllCards(player,nil)
	     if player:isKongcheng() then return false end                               
	     room:askForDiscard(player, "luadahe", 1, false,false)
	  end
	end
end
}	   
luaspzf:addSkill(luadahe)
luaspzf:addSkill(luajie)
sgs.LoadTranslationTable{
    ["spzf"] = "sp张飞",
    ["luaspzf"] = "sp张飞",
	["luadahe"] = "大喝",
	["luajie"] = "嫉恶",
    ["luadahev"] = "大喝",
    ["luadahecard"] = "大喝",
	[":luajie"] = "锁定技：你使用的红色【杀】造成的伤害+1。",
	[":luadahe"] = "出牌阶段你可以与一名其他角色拼点；若你赢，该角色的非红桃【闪】无效直到回合结束，你可将该角色拼点的牌交给场上一名体力不多于你的角色。若没赢，你需展示手牌并选择一张弃置，每阶段限一次",
	["@luadahe"] = "请打出一张红桃【闪】，否则闪避无效。",
	["@luadahets"] = "出牌阶段你可以与一名其他角色拼点；若你赢，该角色的非红桃【闪】无效直到回合结束，你可将该角色拼点的牌交给场上一名体力不多于你的角色。若没赢，你需展示手牌并选择一张弃置，每阶段限一次",
}	 
--☆SP刘备 by Slob
sbliubei = sgs.General(extension, "sbliubei$", "shu") 

--昭烈
sbzhaolie=sgs.CreateTriggerSkill{
	name="sbzhaolie",
	frequency=sgs.Skill_NotFrequent,
	events={sgs.DrawNCards},
	on_trigger=function(self,event,player,data)
		if not player:askForSkillInvoke(self:objectName()) then return end
		local room = player:getRoom()
		local x = data:toInt()
		local targets=sgs.SPlayerList()
		for _,p in sgs.qlist(room:getAllPlayers()) do
			if player:inMyAttackRange(p) then
				targets:append(p)
			end
		end
		local target=room:askForPlayerChosen(player,targets,self:objectName())
		local card_ids = room:getNCards(3)
		local notbasic=0
		local card
		local acard_ids=card_ids
		room:fillAG(acard_ids,nil)
		room:getThread():delay(500)
		for _,id in sgs.qlist(card_ids) do
			card=sgs.Sanguosha:getCard(id)
			if not card:inherits("BasicCard") then
				acard_ids:removeOne(id)
				room:takeAG(nil,id)
				notbasic=notbasic+1
			end
			if card:inherits("Peach") then
				room:getThread():delay()
				acard_ids:removeOne(id)
				room:takeAG(nil,id)
			end
		end
		room:getThread():delay(2000)
		for _,p in sgs.qlist(room:getPlayers()) do
			p:invoke("clearAG")
		end
		local choice="zhaolhurt"
		if target:getCardCount(true) >= notbasic then
			choice=room:askForChoice(target,self:objectName(),"zhaolhurt+zhaoldis")
		end
		if choice=="zhaolhurt" then
			if notbasic~= 0 then
				local damage=sgs.DamageStruct()
					damage.damage=notbasic
					damage.from=player
					damage.to=target
				room:damage(damage)
			end
			if target:isAlive() then
				for _,id in sgs.qlist(acard_ids) do
					target:obtainCard(sgs.Sanguosha:getCard(id))
				end
			else
				for _,id in sgs.qlist(acard_ids) do
					room:throwCard(sgs.Sanguosha:getCard(id))
				end
			end
		else
			if notbasic~= 0 then
				for i=1,notbasic,1 do
					room:askForDiscard(target,self:objectName(),1,false,true)
				end
			end
			for _,id in sgs.qlist(acard_ids) do
				player:obtainCard(sgs.Sanguosha:getCard(id))
			end
		end
		data:setValue(x-1)
	end,
}

--誓仇
sbshichoucard=sgs.CreateSkillCard{
	name="sbshichoucard",
	filter = function(self, targets, to_select, player)
		return to_select:getKingdom()=="shu" and #targets==0
	end,	
	on_use = function(self, room, source, targets)
		source:loseMark("@shichou")
		targets[1]:obtainCard(self)
		targets[1]:gainMark("@shichoutarget")
		source:addMark("sbshichou")
	end,
}

sbshichouvs=sgs.CreateViewAsSkill{
	name="sbshichouvs",
	n=2,
	view_filter = function(self, selected, to_select)
		return true
	end,
	view_as = function(self, cards)
		if #cards~=2 then return end
		local card=sbshichoucard:clone()
		card:addSubcard(cards[1])
		card:addSubcard(cards[2])
		card:setSkillName("sbshichou")
		return card
	end,
	enabled_at_play=function(self, player)
		return false
	end,
	enabled_at_response=function(self,player,pattern) 
		return pattern=="@@sbshichou"
	end,
}

sbshichou=sgs.CreateTriggerSkill{
	name="sbshichou$",
	frequency=sgs.Skill_Limited,
	events={sgs.GameStart,sgs.PhaseChange},
	priority=3,
	view_as_skill=sbshichouvs,
	on_trigger=function(self,event,player,data)
		if not player:hasLordSkill(self:objectName()) then return end
		local room=player:getRoom()
		if event==sgs.GameStart then
			player:gainMark("@shichou")
			return
		end
		if player:getPhase() ~= sgs.Player_Start then return end
		if player:getMark("@shichou")<=0 then return end
		room:askForUseCard(player,"@@sbshichou","@sbshichou")
	end,
}

sbshichoutr=sgs.CreateTriggerSkill{
	name="#sbshichoutr",
	frequency=sgs.Skill_Compulsory,
	events={sgs.Predamaged},	
	on_trigger=function(self,event,player,data)
		if player:getMark("sbshichou")<=0 then return end
		if player:getMark("@shichoutarget")>0 then player:drawCards(damage.damage) return end
		local room=player:getRoom()
		local damage=data:toDamage()
		local target
		for _,p in sgs.qlist(room:getOtherPlayers(player)) do
			if p:getMark("@shichoutarget")>0 then
				target=p
				break
			end
		end
		if not target then return end
		local log=sgs.LogMessage()
			log.type="#shichoutrans"
			log.from=player
			log.to:append(target)
			log.arg =damage.damage
		room:sendLog(log)
		local newdamage=sgs.DamageStruct()
			newdamage.damage=damage.damage
			newdamage.chain=damage.chain
			newdamage.card=damage.card
			newdamage.from=damage.from
			newdamage.to=target
		room:damage(newdamage)
		if target:isAlive() then
			target:drawCards(damage.damage)
		end
		return true
	end,
}

sbshichoucancel=sgs.CreateTriggerSkill{
	name="#sbshichoucancel",
	frequency=sgs.Skill_Compulsory,
	events={sgs.Dying},
	priority=4,	
	on_trigger=function(self,event,player,data)
		if player:getMark("@shichoutarget")<=0 then return end
		player:loseAllMarks("@shichoutarget")
		local liubei=room:getLord()
		liubei:removeMark("sbshichou")
	end,
	can_trigger=function(self,target)
		return true
	end,
}

sbliubei:addSkill(sbzhaolie)
sbliubei:addSkill(sbshichou)
sbliubei:addSkill(sbshichoutr)
sbliubei:addSkill(sbshichoucancel)

sgs.LoadTranslationTable{
	["sbliubei"]="☆SP刘备",
	
	["#sbliubei"] = "汉昭烈帝",
	["designer:sbliubei"] = "桌游志|codeby:Slob",
	["illustrator:sbliubei"] = "暂无",
	["cv:sbliubei"] = "暂无",	
	["sbzhaolie"]="昭烈",
	[":sbzhaolie"]="摸牌阶段摸牌时，你可以少摸一张牌，指定你攻击范围内的一名角色亮出牌堆顶上3张牌，将其中全部的非基本牌和【桃】置于弃牌堆，该角色进行二选一：你对其造成X点伤害，然后他获得这些基本牌；或他依次弃置X张牌，然后你获得这些基本牌。（X为其中非基本牌的数量）",
	["zhaolhurt"]="掉血拿牌",
	["zhaoldis"]="弃牌",
	
	["sbshichou"]="誓仇",
	[":sbshichou"]="<b>主公技，限定技，</b>回合开始时，你可指定一名蜀国角色并交给其两张牌。本盘游戏中，每当你受到伤害时，改为该角色替你受到等量的伤害，然后摸等量的牌，直至该角色第一次进入濒死状态。",
	["@shichou"]="誓仇",
	["@shichoutarget"]="誓仇对象",
	["@sbshichou"]="是否发动技能【誓仇】",
	["#shichoutrans"]="%from 的技能【誓仇】的后续效果被触发，%to 替 %from 承受 %arg 点伤害"
}
--☆SP大乔 by Slob
sbdaqiao=sgs.General(extension, "sbdaqiao", "wu", 3, false) 

sbyanxiaocard=sgs.CreateSkillCard{
	name="sbyanxiaocard",
	target_fixed=false,
	will_throw=true,
	filter = function(self, targets, to_select, player)
		return #targets==0 and to_select:getPile("yanxiaopile"):isEmpty()
	end,	
	on_use = function(self, room, source, targets)
		targets[1]:addToPile("yanxiaopile",self:getEffectiveId(),true)
	end,
}

sbyanxiaovs=sgs.CreateViewAsSkill{
	name="sbyanxiaovs",
	n=1,
	view_filter = function(self, selected, to_select)
		return to_select:getSuit()==sgs.Card_Diamond
	end,
	view_as = function(self, cards)
		if #cards~=1 then return end
		local card=sbyanxiaocard:clone()
		card:addSubcard(cards[1])
		card:setSkillName("sbyanxiao")
		return card
	end,
	enabled_at_play=function(self, player)
		return true
	end,
}

sbyanxiao=sgs.CreateTriggerSkill{
	name="sbyanxiao",
	frequency=sgs.Skill_NotFrequent,
	events={sgs.PhaseChange},
	view_as_skill=sbyanxiaovs,
	on_trigger=function(self,event,player,data)
		if player:getPhase()~=sgs.Player_Judge then return end
		if player:getPile("yanxiaopile"):isEmpty() then return end
		local cards=player:getJudgingArea()
		cards:append(sgs.Sanguosha:getCard(player:getPile("yanxiaopile"):first()))
		for _,cd in sgs.qlist(cards) do
			player:obtainCard(cd)
		end
	end,
	can_trigger=function(self,target)
		return true
	end,
}

sbyanxiaodis=sgs.CreateTriggerSkill{
	name="#sbyanxiaodis",
	frequency=sgs.Skill_Compulsory,
	events={sgs.CardEffect},
	priority=-2,
	on_trigger=function(self,event,player,data)
		local effect=data:toCardEffect()
		if effect.to:getPile("yanxiaopile"):isEmpty() then return end
		if not (effect.card:inherits("Snatch") or effect.card:inherits("Dismantlement")) then return false end
		local room=player:getRoom()
		local thread=room:getThread()
		local new_data = sgs.QVariant()
		new_data:setValue(effect)
		room:setTag("SkipGameRule", sgs.QVariant(true))
		local avoid = thread:trigger(sgs.CardEffected, --[[room,]] effect.to, new_data) -- remove the argument "room",if you're using old version.
		if avoid then return true end
		local canceled=room:isCanceled(effect)
		if not canceled then
			local card_id
			if room:askForChoice(effect.from,"sbyanxiao","yxcard+yxcancel")=="yxcancel" then
				card_id=room:askForCardChosen(effect.from,effect.to,"hej",effect.card:objectName())
			else
				card_id=effect.to:getPile("yanxiaopile"):first()
			end
			local card=sgs.Sanguosha:getCard(card_id)
			if effect.card:inherits("Snatch") then
				effect.from:obtainCard(card)
			else
				room:throwCard(card)
			end
			return true
		end
		return true
	end,
	can_trigger=function(self,target)
		return true
	end,
}

sbanxian=sgs.CreateTriggerSkill{
	name="sbanxian",
	frequency=sgs.Skill_NotFrequent,
	events={sgs.SlashEffected,sgs.Predamage},
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		if event==sgs.Predamage then
			local damage=data:toDamage()
			if not damage.card:inherits("Slash") then return end
			if not player:askForSkillInvoke(self:objectName()) then return end
			if not damage.to:isKongcheng() then
				room:askForDiscard(damage.to,self:objectName(),1,false,false)
			end
			player:drawCards(1)
			return true
		end
		local effect=data:toSlashEffect()
		if player:isKongcheng() then return end
		if not player:askForSkillInvoke(self:objectName()) then return end
		if not room:askForDiscard(player,self:objectName(),1,true,false) then return end
		effect.from:drawCards(1)
		return true
	end,
}

sbdaqiao:addSkill(sbyanxiao)
sbdaqiao:addSkill(sbyanxiaodis)
sbdaqiao:addSkill(sbanxian)

sgs.LoadTranslationTable{
	["sbdaqiao"]="☆SP大乔",
	
	["#sbdaqiao"] = "韶光易逝",
	["designer:sbdaqiao"] = "桌游志|codeby:Slob",
	["illustrator:sbdaqiao"] = "暂无",
	["cv:sbdaqiao"] = "暂无",
	["sbyanxiao"]="言笑",
	[":sbyanxiao"]="出牌阶段，你可以将一张方片牌置于一名角色的武将牌上，武将牌上有“言笑”牌的角色下个判定阶段开始时，获得其判定区里的所有牌与这张“言笑”牌。\
★【顺手牵羊】或【过河拆桥】可以选择一名角色的“言笑”牌。",
	["sbyanxiaovs"]="言笑",
	["sbyanxiaocard"]="言笑",
	["yanxiaopile"]="言笑牌",
	["yxcard"]="我选言笑牌",
	["yxcancel"]="我不选言笑牌",
	
	["sbanxian"]="安娴",
	[":sbanxian"]="每当你使用【杀】对目标角色造成伤害时，你可以防止此次伤害，令其弃置一张手牌，让后你摸一张牌；当你成为【杀】的目标时，你可以弃置一张手牌使之无效，然后该【杀】的使用者摸一张牌。",
}		
     
--☆SP吕蒙 by 切西瓜的RZ
splvmeng = sgs.General(extension,"splvmeng", "wu", 3)


tanhucard=sgs.CreateSkillCard{ --吞狼技能卡
name="tanhu",
will_throw = false,
filter=function(self,targets,to_select,player)
if (#targets>=1) then return false end
return not to_select:isKongcheng()
end,
on_effect=function(self,effect)          
     local room=effect.from:getRoom()                
         local tiger =effect.to                --老虎
     room:playSkillEffect("xianzhen",1)
     if (effect.from:pindian(tiger,"tanhu",self)) then --拼点成功则
                 room:playSkillEffect("xianzhen",2)       
         room:setPlayerFlag(effect.to,"tanhutarget")                 
                  room:setPlayerFlag(effect.from,"tanhu_success")                 
else                   room:setPlayerFlag(effect.from,"tanhu_failed")                 
        end                
end,
}

tanhuvs=sgs.CreateViewAsSkill{ --吞狼视为
name="tanhuvs",
n=1,
view_filter=function(self, selected, to_select)
        return not to_select:isEquipped()
end,
view_as=function(self, cards)
        if #cards==1 then 
        local acard=tanhucard:clone()
        acard:addSubcard(cards[1])                
        acard:setSkillName("tanhu")
        return acard end
end,
enabled_at_play=function()   
return not sgs.Self:hasFlag("tanhu_success") and not sgs.Self:hasFlag("tanhu_failed")
end,
enabled_at_response=function(self,player,pattern) 
        return false 
end
}



tanhu=sgs.CreateTriggerSkill{
        name="tanhu",
        events={sgs.CardEffect,sgs.PhaseChange},
        view_as_skill=tanhuvs,
        priority=0,
        
        on_trigger=function(self,event,player,data)
                local room=player:getRoom()
                 if event==sgs.CardEffect then 

                local effect=data:toCardEffect()
                local card=effect.card--获取卡片
                if not card:inherits("TrickCard") then return false end--是否非延时锦囊
                if effect.from:hasFlag("tanhu_success") and effect.to:hasFlag("tanhutarget") then
                        for _,p in sgs.qlist(room:getOtherPlayers(player)) do
                    room:attachSkillToPlayer(p,"kuanhp")
         end
                         elseif (not effect.from:hasFlag("tanhu_success")) or (not effect.to:hasFlag("tanhutarget")) then
                        for _,p in sgs.qlist(room:getOtherPlayers(player)) do
                    room:detachSkillFromPlayer(p,"kuanhp")
         end end
                 elseif event==sgs.PhaseChange then 
                 if player:getPhase() == sgs.Player_Finish then 

                        for _,p in sgs.qlist(room:getOtherPlayers(player)) do
                    room:detachSkillFromPlayer(p,"kuanhp")
        end end end
end,
}

tanhudis=sgs.CreateDistanceSkill{
name= "#tanhudis",
correct_func=function(self,from,to)
        if from:hasFlag("tanhu_success") and  to:hasFlag("tanhutarget")
        then return -99
        else return 0
        end
end
}

kuanhp=sgs.CreateFilterSkill{
name="kuanhp",
view_filter=function(self,to_select)
return to_select:inherits("Nullification")
end,
view_as=function(self,card)
local filtered=sgs.Sanguosha:cloneCard("shit", card:getSuit(), card:getNumber()) 

filtered:addSubcard(card)
filtered:setSkillName(self:objectName())
return filtered
end
}

local skill=sgs.Sanguosha:getSkill("kuanhp")
if not skill then
        local skillList=sgs.SkillList()
        skillList:append(kuanhp)
        sgs.Sanguosha:addSkills(skillList)
end

mouduan=sgs.CreateTriggerSkill{
name="mouduan",
events={sgs.GameStart,sgs.TurnStart},
on_trigger=function(self,event,player,data)
local room=player:getRoom()
local selfplayer=room:findPlayerBySkillName(self:objectName())
local otherplayers=room:getOtherPlayers(selfplayer)
if event==sgs.GameStart then 
if player:hasSkill("mouduan") then
room:acquireSkill(selfplayer,"jiang")
room:acquireSkill(selfplayer,"qianxun")
  player:gainMark("@wu",1)
  end
elseif event==sgs.TurnStart then 
if not player:hasSkill("jiang") then return false end
if room:askForSkillInvoke(selfplayer,"mouduan") then 
if(room:askForDiscard(selfplayer,self:objectName(),1,false,false)) then if selfplayer:hasSkill("jiang") then 
room:acquireSkill(selfplayer,"yingzi")
room:acquireSkill(selfplayer,"keji")
room:detachSkillFromPlayer(selfplayer,"jiang")
room:detachSkillFromPlayer(selfplayer,"qianxun") 
selfplayer:gainMark("@wen")
selfplayer:loseMark("@wu")
elseif not selfplayer:hasSkill("jiang") then
room:acquireSkill(selfplayer,"jiang")
room:acquireSkill(selfplayer,"qianxun")
room:detachSkillFromPlayer(selfplayer,"yingzi")
room:detachSkillFromPlayer(selfplayer,"keji")
selfplayer:gainMark("@wu")
selfplayer:loseMark("@wen")
end
end
end

if selfplayer:getHandcardNum()<3 then
room:acquireSkill(selfplayer,"yingzi")
room:acquireSkill(selfplayer,"keji")
room:detachSkillFromPlayer(selfplayer,"jiang")
room:detachSkillFromPlayer(selfplayer,"qianxun")
selfplayer:gainMark("@wen")
selfplayer:loseMark("@wu")
end
end
end,
can_trigger=function(self,player)
local room=player:getRoom()
local selfplayer=room:findPlayerBySkillName(self:objectName())
if selfplayer==nil then return false end
return selfplayer:isAlive()

end,
}


splvmeng:addSkill(mouduan)
splvmeng:addSkill(tanhu)
splvmeng:addSkill(tanhudis)



sgs.LoadTranslationTable{
        ["splvmeng"]="SP吕蒙",
[":mouduan"]="<b>转化技</b>，通常状态下，你拥有标记“武”并拥有技能“激昂”和“谦逊”。当你的手牌数为2张或以下时，你须将你的标记翻面为“文”，将该两项技能转化为“英姿”和“克己”。任一角色的回合开始前，你可弃一张牌将标记翻回。",
["mouduan"]="谋断",
["tanhu"]="探虎",
[":tanhu"]="出牌阶段，你可以与一名角色拼点，若你赢，你获得以下技能直到回合结束：无视与该角色的距离,对该角色使用的锦囊不可被【无懈可击】。每阶段限一次。 ",
["#splvmeng"]="国士之风",
        ["designer:splvmeng"] = "桌游志",
        ["illustrator:splvmeng"] = "暂无",
        ["cv:splvmeng"] = "暂无",        
} 