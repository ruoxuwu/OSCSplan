module("extensions.luaimmortal", package.seeall)
extension = sgs.Package("immortal")
luaxzc = sgs.General(extension, "luaxzc", "god", 3, true,false)
lualunhui = sgs.CreateTriggerSkill{
 name="lualunhui",
 events={sgs.PhaseChange},
 frequency = sgs.Skill_Frequency,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  if (event == sgs.PhaseChange) and (player:getPhase() == sgs.Player_Start) then
    if (player:getMark("luused")) > 0 then
	   room:setPlayerFlag(player, "fsused")
	   room:setPlayerFlag(player, "fsslash")
	   room:askForUseCard(player, "","@lhcg:")	
	 end
    if (player:getMark("jshh")) == 0 and (player:getMark("oshh")) == 0 then
	    player:addMark("jshh")
		room:askForUseCard(player, "","@fscan:")
    elseif (player:getMark("jshh")) > 0 and (player:getMark("luused")) == 0 then
	  player:addMark("oshh")
	  player:setMark("jshh",0)
	  room:setPlayerFlag(player, "oshh")
	  room:askForUseCard(player, "","@fjcan:")
	elseif (player:getMark("oshh")) > 0 and (player:getMark("luused")) == 0 then
	   player:addMark("jshh")
	   player:setMark("oshh",0)
	   room:askForUseCard(player, "","@fscan:")
	end
   end
  if (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Finish) and (player:getMark("luused")) == 0 then
     if not room:askForSkillInvoke( player,"lualunhui") then return false end
     local judge = sgs.JudgeStruct()
				judge.pattern = sgs.QRegExp("(.*):(spade|club):(.*)")
				judge.good = true
				judge.reason = "lualuoshen"
				judge.who = player
				room:judge(judge)
				if(judge:isGood()) then
				 player:addMark("luused")
				  player:addMark("realturn")
				 player:gainAnExtraTurn()
				end 
  elseif  (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Finish) and (player:getMark("luused")) > 0 then
          player:setMark("luused",0)
 end
 end,
 }
 
 fsgpcard = sgs.CreateSkillCard
{
	name = "fsgpcard",	
	target_fixed = true,	
	will_throw = false,
on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local cdid = self:getEffectiveId()
		source:addToPile("fenshenx", cdid, true)
		room:setPlayerFlag(source, "fsused")
end,
}

fsgp=sgs.CreateViewAsSkill{
name="fsgp",
n=1,
view_filter=function(self, selected, to_select)
	return not to_select:isEquipped()
end,
view_as = function(self, cards)
	if #cards==1 then
		acard=fsgpcard:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
	end
end,
enabled_at_play = function()
	return not sgs.Self:hasFlag("oshh") and not sgs.Self:hasFlag("fsused")
end,
enabled_at_response = function()
	return false
end,
}

luafenshen=sgs.CreateTriggerSkill{
 name = "luafenshen",
 frequency = sgs.Skill_Frequency,
 events = {sgs.Predamaged},
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local damage = data:toDamage()
  if event == sgs.Predamaged then
        local fields = sgs.IntList()
		fields = player:getPile("fenshenx")
		if fields:isEmpty() then return false end
    if not room:askForSkillInvoke( player,"luafenshen") then return false end
	    if fields:length() == 1 then
			card_id = fields:first()
			local card = sgs.Sanguosha:getCard(card_id)
		    room:moveCardTo(card,nil,sgs.Player_DiscardedPile,true)
			player:addMark("fs")
		else
		    while true do
			room:fillAG(fields, player)
			card_id = room:askForAG(player,fields,true,"fenshents")
			player:invoke("clearAG")
			 if card_id == -1 then break end
			fields:removeOne(card_id)
			  local card = sgs.Sanguosha:getCard(card_id)			 
			  room:moveCardTo(card,nil,sgs.Player_DiscardedPile,true)		  
			  player:addMark("fs")
			  
		    end
		end
		         local x = player:getMark("fs")
		       damage.damage = damage.damage-x
		       if damage.damage <= 0 then
			     damage.damage = 0
			   end
				data:setValue(damage)
				player:setMark("fs",0)
				
end
end,
}   
 
luafeijianx=sgs.CreateViewAsSkill{

name="luafeijianx",

n=1,
view_filter=function(self,selected,to_select)

if (not to_select:isEquipped()) and (to_select:inherits("Slash")) then return true end

end,

view_as=function(self, cards)

if #cards==1 then

local card = cards[1]

if card:inherits("FireSlash") then
local px_card = sgs.Sanguosha:cloneCard("fire_slash",card:getSuit(),card:getNumber())
px_card:addSubcard(card:getId())

px_card:setSkillName(self:objectName())

return px_card
elseif card:inherits("ThunderSlash") then
local px_card = sgs.Sanguosha:cloneCard("thunder_slash",card:getSuit(),card:getNumber())
px_card:addSubcard(card:getId())

px_card:setSkillName(self:objectName())

return px_card
else
local px_card = sgs.Sanguosha:cloneCard("slash",card:getSuit(),card:getNumber())
px_card:addSubcard(card:getId())

px_card:setSkillName(self:objectName())

return px_card
end

end

end,

enabled_at_play = function()
		return not sgs.Self:hasFlag("fsslash") and sgs.Self:hasFlag("oshh")  
	end,

enabled_at_response=function()

return false

end,

}

luafeijian = sgs.CreateTriggerSkill{

	name = "luafeijian",
	view_as_skill = luafeijianx,
	events = {sgs.PhaseChange,sgs.CardFinished,sgs.CardUsed},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		 local card=data:toCardUse().card
		 local fsfields = sgs.IntList()
		 fsfields = player:getPile("fenshenx")
		 if event == sgs.CardUsed and card:inherits("Slash") then
		    player:addMark("fsx")
	    end
		if (event == sgs.CardFinished) and not player:hasFlag("sm") then 
            if (player:getMark("fsx")) >= (fsfields:length()+1) then 		
            room:setPlayerFlag(player, "fsslash")
            end
            if card:inherits("Slash") and not player:hasFlag("fsslash") and player:hasFlag("oshh") then
			  room:askForUseCard(player, "slash","@fsts:")
			end
        elseif (event == sgs.CardFinished) and player:hasFlag("sm") then
            if (player:getMark("fsx")) >= (fsfields:length()+2) then 		
            room:setPlayerFlag(player, "fsslash")
            end
            if card:inherits("Slash") and not player:hasFlag("fsslash") and player:hasFlag("oshh") then
			  room:askForUseCard(player, "slash","@fsts:")
			end   		
		end
		if  (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Finish) then
		    player:setMark("fsx",0)
		end
	end,
	}
	
 luaxzc:addSkill(lualunhui)
 luaxzc:addSkill(fsgp)
 luaxzc:addSkill(luafenshen)
 luaxzc:addSkill(luafeijian)
 sgs.LoadTranslationTable{
    ["immortal"] = "仙包",
    ["luaxzc"] = "仙左慈",
	["fenshenx"] = "分身数",
	["lualunhui"] = "轮回",
	["fsgp"] = "盖放分身",
	["luafenshen"] = "分身",
	["luafeijian"] = "飞剑",
	[":lualunhui"] = "回合结束阶段你可以判定，若结果为黑色花色，则你可以立即得到一个额外的回合(额外回合结束时不能发动轮回)。",
	[":fsgp"] = "出牌阶段你可以盖放一张手牌在你的武将牌上作为一个分身(轮回回合和偶数回合不能盖放分身)。",
	[":luafenshen"] = "你每弃掉一个分身可抵消一点伤害。",
	[":luafeijian"] = "偶数回合你可以使用X+1张【杀】，X为你的分身数（轮回回合不能发动飞剑，使用额外的【杀】需按下本技能按钮发动)。",
	["@lhcg"] = "你现在开始轮回回合。将不能发动【飞剑】和盖放【分身】。",
	["@fjcan"] = "你现在处于【偶数】回合。本回合可以发动【飞剑】不能盖放【分身】。",
	["@fscan"] = "你现在处于【奇数】回合。本回合可以盖放【分身】不能发动【飞剑】。",
	["@fsts"] = "你可以再出一张【杀】。",
	["designer:luaxzc"] = "杀神附体"
}
				
luaxzh = sgs.General(extension, "luaxzh", "wei", 4, true,false)
luabenxicard = sgs.CreateSkillCard
luabenxicardf = sgs.CreateSkillCard
{--技能卡
        name="luabenxicardf",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if  #targets > 2  then return false end              				 
				if to_select:objectName() == player:objectName() then return false end
				if to_select:isKongcheng() and to_select:hasSkill("kongcheng") then return false end
                return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local target = targets[1]
		local targett = targets[2]
		local targetr = targets[3]
		for _,card in sgs.qlist(self:getSubcards()) do
             cdid = self:getEffectiveId()
		     cardx = sgs.Sanguosha:getCard(cdid)
        end
		
		if self:subcardsLength() == 1 then				
		local slash = cardx
		    slash:setSkillName("luabenxi")
			local use = sgs.CardUseStruct()
			use.from = source
			if target~=nil then
			use.to:append(target)
			end
			if targett~=nil then
			use.to:append(targett)
			end
			if targetr~=nil then
			use.to:append(targetr)
			end
			use.card = slash
			room:useCard(use, true)
	    end
		end,
		}
luabenxicardfw = sgs.CreateSkillCard
{--技能卡
        name="luabenxicardfw",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if  #targets > 2  then return false end              				 
				if to_select:objectName() == player:objectName() then return false end
				if to_select:isKongcheng() and to_select:hasSkill("kongcheng") then return false end
                return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local target = targets[1]
		local targett = targets[2]
		local targetr = targets[3]
		for _,card in sgs.qlist(self:getSubcards()) do
             cdid = self:getEffectiveId()
		     cardx = sgs.Sanguosha:getCard(cdid)
        end
		
		if self:subcardsLength() == 1 then				
		local slash = sgs.Sanguosha:cloneCard("slash", cardx:getSuit(), cardx:getNumber())
		    slash:setSkillName("luabenxi")
			 slash:addSubcard(self)
			local use = sgs.CardUseStruct()
			use.from = source
			if target~=nil then
			use.to:append(target)
			end
			if targett~=nil then
			use.to:append(targett)
			end
			if targetr~=nil then
			use.to:append(targetr)
			end
			use.card = slash
			room:useCard(use, true)
	    end
		end,
		}
luabenxicards = sgs.CreateSkillCard
{--技能卡
        name="luabenxicards",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if #targets > 0  then return false end
                if to_select:objectName() == player:objectName() then return false end
				if to_select:isKongcheng() and to_select:hasSkill("kongcheng") then return false end
                return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local target = targets[1]
		for _,card in sgs.qlist(self:getSubcards()) do
             cdid = self:getEffectiveId()
		     cardx = sgs.Sanguosha:getCard(cdid)
        end		
		if self:subcardsLength() == 2 then
           	local slash = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
            slash:setSkillName("luabenxi")
			for _,card in sgs.qlist(self:getSubcards()) do
              slash:addSubcard(card)
            end
			local use = sgs.CardUseStruct()
			use.from = source
			use.to:append(target)
			use.card = slash
			room:useCard(use, true)			
	    end	
		end,
		}
luabenxicard = sgs.CreateSkillCard
{--技能卡
        name="luabenxicard",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if  #targets > 0  then return false end              				 
				if to_select:objectName() == player:objectName() then return false end
				if to_select:isKongcheng() and to_select:hasSkill("kongcheng") then return false end
                return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local target = targets[1]
		local targett = targets[2]
		local targetr = targets[3]
		for _,card in sgs.qlist(self:getSubcards()) do
             cdid = self:getEffectiveId()
		     cardx = sgs.Sanguosha:getCard(cdid)
        end
		
		if self:subcardsLength() == 1 then				
		local slash = cardx
		    slash:setSkillName("luabenxi")
			local use = sgs.CardUseStruct()
			use.from = source
			if target~=nil then
			use.to:append(target)
			end
			if targett~=nil then
			use.to:append(targett)
			end
			if targetr~=nil then
			use.to:append(targetr)
			end
			use.card = slash
			room:useCard(use, true)
        elseif self:subcardsLength() == 2 then
		    local slash = sgs.Sanguosha:cloneCard("slash", cardx:getSuit(), cardx:getNumber())
            slash:setSkillName("luabenxi")
			for _,card in sgs.qlist(self:getSubcards()) do
              slash:addSubcard(card)
            end
			local use = sgs.CardUseStruct()
			use.from = source
			use.to:append(target)
			use.card = slash
			room:useCard(use, true)
      	end	
		end,
		}
		luabenxicardw = sgs.CreateSkillCard
{--技能卡
        name="luabenxicardw",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if  #targets > 0  then return false end              				 
				if to_select:objectName() == player:objectName() then return false end
				if to_select:isKongcheng() and to_select:hasSkill("kongcheng") then return false end
                return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local target = targets[1]
		local targett = targets[2]
		local targetr = targets[3]
		for _,card in sgs.qlist(self:getSubcards()) do
             cdid = self:getEffectiveId()
		     cardx = sgs.Sanguosha:getCard(cdid)
        end
		
		if self:subcardsLength() == 1 then				
		local slash = sgs.Sanguosha:cloneCard("slash", cardx:getSuit(), cardx:getNumber())
		    slash:setSkillName("luabenxi")
			 slash:addSubcard(self)
			local use = sgs.CardUseStruct()
			use.from = source
			if target~=nil then
			use.to:append(target)
			end
			if targett~=nil then
			use.to:append(targett)
			end
			if targetr~=nil then
			use.to:append(targetr)
			end
			use.card = slash
			room:useCard(use, true)
        elseif self:subcardsLength() == 2 then
		    local slash = sgs.Sanguosha:cloneCard("slash", cardx:getSuit(), cardx:getNumber())
            slash:setSkillName("luabenxi")
			for _,card in sgs.qlist(self:getSubcards()) do
              slash:addSubcard(card)
            end
			local use = sgs.CardUseStruct()
			use.from = source
			use.to:append(target)
			use.card = slash
			room:useCard(use, true)
      	end	
		end,
		}
luabenxix=sgs.CreateViewAsSkill{
name="luabenxix",
n=2,
view_filter=function(self,selected,to_select)
if sgs.Self:hasSkill("wushen") then
   return (to_select:inherits("Slash") or to_select:getSuit() == sgs.Card_Heart) and not to_select:isEquipped()
elseif sgs.Self:hasSkill("wusheng") then
   return to_select:inherits("Slash") or to_select:isRed()
elseif sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Spear" then
   if #selected ==0 then return not to_select:isEquipped() end
   if #selected ==1 then return not to_select:isEquipped()end 
elseif (not to_select:isEquipped()) and (to_select:inherits("Slash")) then 
return true 
end
end,
view_as = function(self, cards)
	if #cards==1 then
	 if cards[1]:inherits("Slash") and not sgs.Self:hasSkill("wushen") then
	  if (sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Halberd") and sgs.Self:getHandcardNum() == 1 then
		acard=luabenxicardf:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
	  else
	    acard=luabenxicard:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
	  end
	 else
	  if (sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Halberd") and sgs.Self:getHandcardNum() == 1 then
		acard=luabenxicardfw:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
	  else
	    acard=luabenxicardw:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
	  end
	 end
	elseif #cards==2 then
	    if cards[1]:sameColorWith(cards[2]) then
	    acard=luabenxicard:clone()
		acard:addSubcard(cards[1])
		acard:addSubcard(cards[2])
		acard:setSkillName(self:objectName())
		return acard
		else
		acard=luabenxicards:clone()
		acard:addSubcard(cards[1])
		acard:addSubcard(cards[2])
		acard:setSkillName(self:objectName())
		return acard
		end
	end
end,

enabled_at_play = function()
		return ((sgs.Self:canSlashWithoutCrossbow()) or (sgs.Self:getWeapon() and sgs.Self:getWeapon():className()=="Crossbow")) or (sgs.Self:hasFlag("sm") and not sgs.Self:hasFlag("jcused")) or (not sgs.Self:hasFlag("fsslash") and sgs.Self:hasFlag("oshh"))
	end,
enabled_at_response=function()
return false
end,
}
				
luabenxi = sgs.CreateTriggerSkill{
 name="luabenxi",
 view_as_skill = luabenxix,
 events={sgs.DrawNCards,sgs.Predamage},
 frequency = sgs.Skill_Frequency,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local damage = data:toDamage()
  local card = damage.card
  if (event == sgs.DrawNCards) then
     if not room:askForSkillInvoke( player,"luabenxi") then return false end
	  room:setPlayerFlag(player, "bx")
	  local targets = room:getOtherPlayers(player)
	  local target = room:askForPlayerChosen(player, targets, "@luabenxi")
	  room:showAllCards(target,player)
	   data:setValue(0)
	  return true
  end
     
  if event == sgs.Predamage and card:inherits("Slash") and player:hasFlag("bx") then
                damage.damage = damage.damage+1
				data:setValue(damage)
				return false
  end
  end,
  }
luaxzh:addSkill(luabenxi)  
sgs.LoadTranslationTable{
    ["luaxzh"] = "张颌",
	["luabenxi"] = "奔袭",
	[":luabenxi"] = "你可以选择跳过摸牌阶段，并观看一次任意一名角色的手牌，若如此做该回合的出牌阶段，你使用【杀】无视距离且造成的伤害+1。",
	["@luabenxi"] = "你可以选择任意一名玩家，观看其手牌。",
	["designer:luaxzh"] = "杀神附体"
}