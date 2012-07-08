--SANGUOSHA YJCM2012 Generals--
--Design: YOKA (2012)
--Code: 
--Version：16.12 (After Taqing 16)
--Last Update：July 5 2012 23:50 UTC+8

module("extensions.yjcm2012x", package.seeall)
extension = sgs.Package("yjcm2012x")
--荀攸				
luaxunyoux = sgs.General(extension, "luaxunyoux", "wei", 3, true,false)
askfornullx=sgs.CreateTriggerSkill{
	name="#askfornullx",
	events=sgs.CardEffected,--卡片对其他角色生效
	priority=0,
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		local effect=data:toCardEffect()
		local card=effect.card--获取卡片
		if not card:inherits("TrickCard") then return false end--是否锦囊
		local log1=sgs.LogMessage()
		log1.type="#NullificationInf";
		log1.from=effect.from
		log1.to:append(player)
		log1.arg=card:objectName()
		room:sendLog(log1)--发送信息，无实际意义
		local num=0--统计无懈可击的数目
		local t=true--上一圈是否有人出过无懈
		while t do
			t=false
			for _,theplayer in sgs.qlist(room:getAllPlayers()) do--循环，逐一检视所有角色
				if (not t and (theplayer:getMark("cannull")==1) or theplayer:hasNullification()) then--手里有无懈或者拥有无懈技能
					local nullcard=nil
					if num%2==0 then
						nullcard=room:askForCard(theplayer,"nullification","askfornullification1",data)--让他出一张无懈
					else
						nullcard=room:askForCard(theplayer,"nullification","askfornullification2",data)
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
luaqicex=sgs.CreateViewAsSkill{

name="luaqicex",

n=999,

view_filter=function(self,selected,to_select)
return not to_select:isEquipped()
end,

view_as=function(self, cards)
local x = sgs.Self:getHandcardNum()
 if #cards < x and not sgs.Self:hasFlag("nullification")then
       return luaqicecard:clone()
   elseif #cards == x and x >0 then
     if (sgs.Self:hasFlag("blackc") and sgs.Self:hasFlag("redc")) then
       if sgs.Self:hasFlag("archeryattack") then
       local d_card = sgs.Sanguosha:cloneCard("archery_attack",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("snatch") then
	   local d_card = sgs.Sanguosha:cloneCard("snatch",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("dismantlement") then
	   local d_card = sgs.Sanguosha:cloneCard("dismantlement",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("collateral") then
	   local d_card = sgs.Sanguosha:cloneCard("collateral",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("ex_nihilo") then
	   local d_card = sgs.Sanguosha:cloneCard("ex_nihilo",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("duel") then
	   local d_card = sgs.Sanguosha:cloneCard("duel",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("fire_attack") then
	   local d_card = sgs.Sanguosha:cloneCard("fire_attack",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("amazing_grace") then
	   local d_card = sgs.Sanguosha:cloneCard("amazing_grace",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("savage_assault") then
	   local d_card = sgs.Sanguosha:cloneCard("savage_assault",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("god_salvation") then
	   local d_card = sgs.Sanguosha:cloneCard("god_salvation",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	    elseif sgs.Self:hasFlag("iron_chain") then
	   local d_card = sgs.Sanguosha:cloneCard("iron_chain",  sgs.Card_NoSuit, 0)
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("nullification") then
	    local d_card=sgs.Sanguosha:cloneCard("nullification",  sgs.Card_NoSuit, 0)
	    local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
       end
	 else
	    if sgs.Self:hasFlag("archeryattack") then
       local d_card = sgs.Sanguosha:cloneCard("archery_attack",  cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("snatch") then
	   local d_card = sgs.Sanguosha:cloneCard("snatch", cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("dismantlement") then
	   local d_card = sgs.Sanguosha:cloneCard("dismantlement",  cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("collateral") then
	   local d_card = sgs.Sanguosha:cloneCard("collateral",  cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("ex_nihilo") then
	   local d_card = sgs.Sanguosha:cloneCard("ex_nihilo",  cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("duel") then
	   local d_card = sgs.Sanguosha:cloneCard("duel",  cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("fire_attack") then
	   local d_card = sgs.Sanguosha:cloneCard("fire_attack",  cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("amazing_grace") then
	   local d_card = sgs.Sanguosha:cloneCard("amazing_grace",  cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("savage_assault") then
	   local d_card = sgs.Sanguosha:cloneCard("savage_assault",  cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("god_salvation") then
	   local d_card = sgs.Sanguosha:cloneCard("god_salvation",  cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	    elseif sgs.Self:hasFlag("iron_chain") then
	   local d_card = sgs.Sanguosha:cloneCard("iron_chain",  cards[1]:getSuit(), cards[1]:getNumber())
	   local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
	   elseif sgs.Self:hasFlag("nullification") then
	    local d_card=sgs.Sanguosha:cloneCard("nullification",  cards[1]:getSuit(), cards[1]:getNumber())
	    local y=0
       for var=1,x,1 do
	   y=y+1
       d_card:addSubcard(cards[y]:getId())
	   end
       d_card:setSkillName(self:objectName())
       return d_card
       end 
  end
end  

end,

enabled_at_play=function(self,player,pattern)

return sgs.Self:hasFlag("qcused") and sgs.Self:getHandcardNum() > 0
end,

enabled_at_response=function(self,player,pattern)

return sgs.Self:hasFlag("qcused") and pattern=="nullification" and sgs.Self:getHandcardNum() > 0

end,

}

luaqicecard = sgs.CreateSkillCard
{--技能卡
        name="luaqicecard",
        target_fixed=true,
        will_throw=true,
		on_use = function(self, room, source, targets)
         local room = source:getRoom()
		 local choice=room:askForChoice(source, self:objectName(), "snatch+dismantlement+collateral+ex_nihilo+duel+fire_attack+amazing_grace+savage_assault+archery_attack+god_salvation+iron_chain")
		 if  choice == "archery_attack" then
            room:setPlayerFlag(source, "archeryattack")
			room:setPlayerFlag(source, "-qcused")	
		    source:addMark("qc")
        elseif choice == "snatch" then
		    room:setPlayerFlag(source, "snatch")
            room:setPlayerFlag(source, "-qcused")			
		    source:addMark("qc")
		elseif choice == "dismantlement" then
		    room:setPlayerFlag(source, "dismantlement")
			room:setPlayerFlag(source, "-qcused")
		    source:addMark("qc")
		elseif  choice == "collateral" then 
		   room:setPlayerFlag(source, "collateral")
		   room:setPlayerFlag(source, "-qcused")			 
		   source:addMark("qc")
        elseif choice == "ex_nihilo" then
		     room:setPlayerFlag(source, "ex_nihilo")
             room:setPlayerFlag(source, "-qcused")			 
		     source:addMark("qc")
        elseif choice == "duel" then
		    room:setPlayerFlag(source, "duel")
			room:setPlayerFlag(source, "-qcused")
		    source:addMark("qc")
        elseif choice == "fire_attack" then
		   room:setPlayerFlag(source, "fire_attack")
		   room:setPlayerFlag(source, "-qcused")
		   source:addMark("qc")
        elseif  choice == "amazing_grace" then 
		   room:setPlayerFlag(source, "amazing_grace")
		   room:setPlayerFlag(source, "-qcused")
		   source:addMark("qc")
		elseif  choice == "savage_assault" then 
		   room:setPlayerFlag(source, "savage_assault")
		   room:setPlayerFlag(source, "-qcused")
		   source:addMark("qc")
        elseif  choice == "god_salvation" then 
		   room:setPlayerFlag(source, "god_salvation")
		   room:setPlayerFlag(source, "-qcused")
		   source:addMark("qc")
		elseif choice == "iron_chain" then
		   room:setPlayerFlag(source, "iron_chain")
		   room:setPlayerFlag(source, "-qcused")
		   source:addMark("qc")	
        end			
		end,
		}
						
luaqice = sgs.CreateTriggerSkill{
 name="luaqice",
 view_as_skill = luaqicex,
 events={sgs.PhaseChange,sgs.CardUsed,sgs.CardFinished,sgs.CardResponsed},
 frequency = sgs.Skill_Frequency,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local cardu=data:toCardUse().card
   if  (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Play) then
		    room:setPlayerFlag(player, "qcused")
			player:addMark("cannull")
  end
  if event == sgs.CardFinished then
  if (player:getMark("qc")) > 0 then
     local idlist = player:handCards()
	 for _,id in sgs.qlist(idlist) do
	   if not player:hasSkill("hongyan") and (sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Spade or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Club) then 
		  room:setPlayerFlag(player, "blackc")
       elseif not player:hasSkill("hongyan") and (sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Heart or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Diamond) then
          room:setPlayerFlag(player, "redc")
       end		  
	  if player:hasSkill("hongyan") and sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Club then
       room:setPlayerFlag(player, "blackc")
	  elseif player:hasSkill("hongyan") and (sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Heart or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Diamond or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Spade) then
       room:setPlayerFlag(player, "redc")
      end  
	 end
     if player:hasFlag("archeryattack") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@archeryattack:")
	 elseif player:hasFlag("snatch") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@snatch:")
     elseif player:hasFlag("dismantlement") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@dismantlement:")
     elseif player:hasFlag("collateral") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@collateral:")
     elseif player:hasFlag("ex_nihilo") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@ex_nihilo:")
     elseif player:hasFlag("duel") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@duel:")
     elseif player:hasFlag("fire_attack") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@fire_attack:")
     elseif player:hasFlag("amazing_grace") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@amazing_grace:")
     elseif player:hasFlag("savage_assault") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@savage_assault:")
	elseif player:hasFlag("god_salvation") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@god_salvation:")
	elseif player:hasFlag("iron_chain") then
        qcuse = room:askForUseCard(player, "@@luaqice", "@iron_chain:")
    end	
        room:setPlayerFlag(player, "-blackc")
        room:setPlayerFlag(player, "-redc")		
	       if qcuse then return false end
		   room:setPlayerFlag(player, "qcused")
		   room:setPlayerFlag(player, "-archeryattack")
		   room:setPlayerFlag(player, "-snatch")
		   room:setPlayerFlag(player, "-dismantlement")
		   room:setPlayerFlag(player, "-collateral")
		   room:setPlayerFlag(player, "-ex_nihilo")
		   room:setPlayerFlag(player, "-duel")
		   room:setPlayerFlag(player, "-fire_attack")
		   room:setPlayerFlag(player, "-amazing_grace")
		   room:setPlayerFlag(player, "-savage_assault")
		   room:setPlayerFlag(player, "-god_salvation")
		   room:setPlayerFlag(player, "-iron_chain")
           player:setMark("qc",0)		   		   
  end
  end
  if event == sgs.CardUsed and cardu:isNDTrick() then
     if cardu:inherits("Nullification") then return false end
     room:setPlayerFlag(player, "nullification")
	 if cardu:getSkillName() == "luaqicex" then
	     player:setMark("cannull",0)
	 end	   
  end
	if event == sgs.CardResponsed then
			local card = data:toCard()
			if card:inherits("Nullification") then
			  if card:getSkillName() == "luaqicex" then
	          room:setPlayerFlag(player, "-qcused")
			  player:setMark("cannull",0)
              end
            end			  
    end
  if event == sgs.CardUsed and (player:getMark("qc")) > 0 then
     player:setMark("qc",0)
  end
  if (event == sgs.CardFinished) and player:hasFlag("nullification") then
     room:setPlayerFlag(player, "-nullification")
  end
   
  if  (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Finish) then
		    player:setMark("qc",0)
			player:setMark("cannull",0)
  end
 end,
 }
 
 luazhiyux = sgs.CreateTriggerSkill{
 name="luazhiyux",
 events={sgs.Damaged},
 frequency = sgs.Skill_Frequency,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local damage = data:toDamage()
  local card = damage.card
  local to = damage.to
  if event == sgs.Damaged then
      if not room:askForSkillInvoke(player,"luazhiyux") then return false end
     player:drawCards(1)
	 local idlist = to:handCards()
                    room:fillAG(idlist,nil)				
                    while true do
                            local cd_id=room:askForAG(to,idlist,true,self:objectName())
							if cd_id==-1 then break end   					
                    end
	 for _,id in sgs.qlist(idlist) do
	   if not to:hasSkill("hongyan") and (sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Spade or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Club) then 
		  room:setPlayerFlag(to, "black")
       elseif not to:hasSkill("hongyan") and (sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Heart or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Diamond) then
          room:setPlayerFlag(to, "red")
       end		  
	  if to:hasSkill("hongyan") and sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Club then
       room:setPlayerFlag(to, "black")
	  elseif to:hasSkill("hongyan") and (sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Heart or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Diamond or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Spade) then
       room:setPlayerFlag(to, "red")
      end  
	 end
	 for _,id in sgs.qlist(idlist) do
		 idlist:removeOne(id)
	 end
	 for _,p in sgs.qlist(room:getAllPlayers()) do
		p:invoke("clearAG")
	 end
	 if (to:hasFlag("black") and to:hasFlag("red")) then return false end
	 if damage.from:isKongcheng() then return false end                               
	 room:askForDiscard(damage.from, "luazhiyux", 1, false,false)
	  room:setPlayerFlag(to, "-red")
	   room:setPlayerFlag(to, "-black")
end	 
end,
}
luaxunyoux:addSkill(luaqice)
luaxunyoux:addSkill(luazhiyux)
luaxunyoux:addSkill(askfornullx)	
sgs.LoadTranslationTable{  
	["yjcm2012x"] = "一将成名2012",
    ["luaxunyoux"] = "荀攸",
	["cannull"]="lua无懈可击",
	["askfornullx"]="lua无懈可击",
	["#NullificationInf"]="询问【无懈可击】：%from对%to的锦囊%arg",
	["askfornullification1"]="你可以使用【无懈可击】使此次结算无效",
	["askfornullification2"]="你可以使用【无懈可击】使此次结算有效",
	["luaqicex"] = "奇策",
	["luaqice"] = "奇策",
	["luaqicecard"] = "奇策",	
	["luazhiyux"] = "智愚",
	["snatch+dismantlement+collateral+ex_nihilo+duel+fire_attack+amazing_grace+savage_assault+archery_attack+god_salvation+iron_chain"] = "顺手牵羊+过河拆桥+借刀杀人+无中生有+决斗+火攻+五谷丰登+南蛮入侵+万箭齐发+桃园结义+铁索连环",
	[":luaqice"] = "出牌阶段，你可以将所有的手牌（至少一张）当做任意一张非延时锦囊牌使用。每阶段限一次。",
	[":luazhiyux"] = "每当你受到一次伤害后，可以摸一张牌，然后展示所有手牌，若均为同一颜色，则伤害来源弃一张手牌。",
	["@archeryattack"] = "你选择了把所有手牌当【万剑齐发】使用，请选择你的所有手牌",
	["@snatch"] = "你选择了把所有手牌当【顺手牵羊】使用，请选择你的所有手牌",
	["@dismantlement"] = "你选择了把所有手牌当【过河拆桥】使用，请选择你的所有手牌",
	["@collateral"] = "你选择了把所有手牌当【借刀杀人】使用，请选择你的所有手牌",
	["@ex_nihilo"] = "你选择了把所有手牌当【无中生有】使用，请选择你的所有手牌",
	["@duel"] = "你选择了把所有手牌当【决斗】使用，请选择你的所有手牌",
	["@fire_attack"] = "你选择了把所有手牌当【火攻】使用，请选择你的所有手牌",
	["@amazing_grace"] = "你选择了把所有手牌当【五谷丰登】使用，请选择你的所有手牌",
	["@savage_assault"] = "你选择了把所有手牌当【南蛮入侵】使用，请选择你的所有手牌",
	["@god_salvation"] = "你选择了把所有手牌当【桃园结义】使用，请选择你的所有手牌",
	["@iron_chain"] = "你选择了把所有手牌当【铁索连环】使用，请选择你的所有手牌",
	["designer:luaxunyoux"] = "一将成名2012;程序：寒秋"
}
--王异
luawangyix = sgs.General(extension, "luawangyix", "wei", 3, false,false)

luazhenliex=sgs.CreateTriggerSkill{
        name="luazhenliex",
        events={sgs.AskForRetrial,sgs.FinishJudge},--听说这个事件不需要cantrigger
        frequency = sgs.Skill_Frequency,
        on_trigger=function(self,event,player,data)
                local room=player:getRoom()
                local wyx=room:findPlayerBySkillName(self:objectName())
				if event == sgs.AskForRetrial then
                local judge=data:toJudge()                --获取判定结构体
                      room:setPlayerFlag(judge.who, "zlx")				
                      wyx:setTag("Judge",data)                --SET技能拥有者TAG
			    if not wyx:hasFlag("zlx") then return false end
                if (room:askForSkillInvoke(wyx,self:objectName())~=true) then return false end        --询问发动 可以去掉
                local idlist=room:getNCards(1)
				for _,id in sgs.qlist(idlist) do
				    card = sgs.Sanguosha:getCard(id)
			      end          
                room:throwCard(judge.card)
                judge.card = sgs.Sanguosha:getCard(card:getEffectiveId()) --判定牌更改
                room:moveCardTo(judge.card, nil, sgs.Player_Special) --移动到判定区
                local log=sgs.LogMessage()  --LOG 以下是改判定专用的TYPE
               log.type = "$ChangedJudge"
               log.from = player
               log.to:append(judge.who)
               log.card_str = card:getEffectIdString()
               room:sendLog(log)
               room:sendJudgeResult(judge)
                room:setPlayerFlag(judge.who, "-zlx")		   
			   end
			   if(event == sgs.FinishJudge) then
			    judge = data:toJudge()
				room:setPlayerFlag(judge.who, "-zlx")
				end
                return false --要FALSE~~
        end,        
} 

luamijix=sgs.CreateTriggerSkill{
        name="luamijix",
        events={sgs.PhaseChange},
        frequency = sgs.Skill_Frequency,
        on_trigger=function(self,event,player,data)
                local room=player:getRoom()
        if (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Start)	then
           if not player:isWounded() then return false end
		   if not room:askForSkillInvoke(player,"luamijix") then return false end
		   local judge = sgs.JudgeStruct()
				judge.pattern = sgs.QRegExp("(.*):(spade|club):(.*)")
				judge.good = true
				judge.reason = "luaqxx"
				judge.who = player
				room:judge(judge)
				if (judge:isBad()) then return false end
           local x = player:getLostHp()
           local idlist=room:getNCards(x)
                    room:fillAG(idlist,player)				
                    while true do
                            local cd_id=room:askForAG(player,idlist,true,self:objectName())
                            if cd_id==-1 then break end				
                    end
					local targets = room:getAlivePlayers()
				    local target = room:askForPlayerChosen(player, targets, "@luamijix")
			       for _,id in sgs.qlist(idlist) do
				    card = sgs.Sanguosha:getCard(id)
					target:obtainCard(card)
			      end
				   for _,id in sgs.qlist(idlist) do
				   idlist:removeOne(id)
			       end
			        player:invoke("clearAG")
        end
		if (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Finish)	then
           if not player:isWounded() then return false end
		   if not room:askForSkillInvoke(player,"luamijix") then return false end
		   local judge = sgs.JudgeStruct()
				judge.pattern = sgs.QRegExp("(.*):(spade|club):(.*)")
				judge.good = true
				judge.reason = "luaqxx"
				judge.who = player
				room:judge(judge)
				if (judge:isBad()) then return false end
           local x = player:getLostHp()
           local idlist=room:getNCards(x)
                    room:fillAG(idlist,player)				
                    while true do
                            local cd_id=room:askForAG(player,idlist,true,self:objectName())
                            if cd_id==-1 then break end				
                    end
					local targets = room:getAlivePlayers()
				    local target = room:askForPlayerChosen(player, targets, "@luamijix")
			       for _,id in sgs.qlist(idlist) do
				    card = sgs.Sanguosha:getCard(id)
					target:obtainCard(card)
			      end
				   for _,id in sgs.qlist(idlist) do
				   idlist:removeOne(id)
			       end
			        player:invoke("clearAG")
        end
        end,
}		
		
luawangyix:addSkill(luazhenliex)
luawangyix:addSkill(luamijix)
sgs.LoadTranslationTable{
	["luawangyix"] = "王异",
	["luazhenliex"] = "贞烈",
	["luamijix"] = "秘技",
	[":luazhenliex"] = "在你的判定牌生效前，你可以亮出牌堆顶的一张牌代替之。",
	[":luamijix"] = "回合开始/结束阶段开始时，若你已受伤，你可以进行一次判定，若判定结果为黑色，你观看牌堆顶的X张牌（X为你已损失的体力值），然后将这些牌交给一名角色。",	
	["@luamijix"] = "请选择一名玩家将这些牌交给他。",
}
--曹彰
luaczx = sgs.General(extension, "luaczx", "wei", 4, true,false)
luajcflcard = sgs.CreateSkillCard
{--技能卡
        name="luajcflcard",
        target_fixed=true,
        will_throw=false,
		on_use = function(self, room, source, targets)
        return true
		end,
		}
luajcfl=sgs.CreateFilterSkill{
name="#luajcfl",
view_filter=function(self,to_select)
return not to_select:isEquipped() and to_select:inherits("Slash")
end,
view_as=function(self,card)
if sgs.Self:hasFlag("dm") then
local filtered=luajcflcard:clone()
filtered:addSubcard(card)
filtered:setSkillName(self:objectName())
return filtered
else
local filtered=sgs.Sanguosha:cloneCard("slash", card:getSuit(), card:getNumber())
filtered:addSubcard(card)
filtered:setSkillName(self:objectName())
return filtered 
end
end
}
luajccardf = sgs.CreateSkillCard
{--技能卡
        name="luajccardf",
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
		    slash:setSkillName("luajiangcix")
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
luajccardfw = sgs.CreateSkillCard
{--技能卡
        name="luajccardfw",
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
		    slash:setSkillName("luajiangcix")
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
luajccards = sgs.CreateSkillCard
{--技能卡
        name="luajccards",
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
            slash:setSkillName("luajiangcix")
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
luajccard = sgs.CreateSkillCard
{--技能卡
        name="luajccard",
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
		    slash:setSkillName("luajiangcix")
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
            slash:setSkillName("luajiangcix")
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
		luajccardw = sgs.CreateSkillCard
{--技能卡
        name="luajccardw",
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
		    slash:setSkillName("luajiangcix")
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
            slash:setSkillName("luajiangcix")
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
luajcx=sgs.CreateViewAsSkill{
name="luajcx",
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
		acard=luajccardf:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
	  else
	    acard=luajccard:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
	  end
	 else
	  if (sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Halberd") and sgs.Self:getHandcardNum() == 1 then
		acard=luajccardfw:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
	  else
	    acard=luajccardw:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
	  end
	 end
	elseif #cards==2 then
	    if cards[1]:sameColorWith(cards[2]) then
	    acard=luajccard:clone()
		acard:addSubcard(cards[1])
		acard:addSubcard(cards[2])
		acard:setSkillName(self:objectName())
		return acard
		else
		acard=luajccards:clone()
		acard:addSubcard(cards[1])
		acard:addSubcard(cards[2])
		acard:setSkillName(self:objectName())
		return acard
		end
	end
end,

enabled_at_play = function()
		return (sgs.Self:hasFlag("sm") and not sgs.Self:hasFlag("jcused")) or (sgs.Self:hasSkill("paoxiao") and sgs.Self:hasFlag("sm")) or (not sgs.Self:hasFlag("fsslash") and sgs.Self:hasFlag("oshh"))
	end,
enabled_at_response=function()
return false
end,
}

luajiangcix = sgs.CreateTriggerSkill{
 name="luajiangcix",
 view_as_skill = luajcx,
 events={sgs.DrawNCards,sgs.CardUsed,sgs.PhaseChange,sgs.CardFinished,sgs.CardLost},
 frequency = sgs.Skill_Frequency,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local card=data:toCardUse().card
   if  (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Start) then
		    room:setPlayerFlag(player, "-jcused")
			player:setMark("ewslash",0)
  end
  if event == sgs.DrawNCards then
    if not room:askForSkillInvoke( player,"luajiangcix") then return false end
	 local choice=room:askForChoice(player, self:objectName(), "sm+dm")
       	  if choice == "sm" then
		    room:setPlayerFlag(player, "sm")
			data:setValue(data:toInt()-1)
			return true
		  elseif choice == "dm" then
            room:setPlayerFlag(player, "dm")
			data:setValue(data:toInt()+1)
            return true			
          end
 end
 if  (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Play) and player:hasFlag("sm") then
		    room:detachSkillFromPlayer(player,"#luajcfl")
  elseif (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Play) and player:hasFlag("dm") then
		    room:attachSkillToPlayer(player,"#luajcfl")
 elseif (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Play) then
    room:detachSkillFromPlayer(player,"#luajcfl")
  end
 if event == sgs.CardUsed and card:inherits("Slash") and player:hasFlag("dm") then
    room:askForCard(player, "","@jc_ts1:")
	return true
 end
 
 if event == sgs.CardUsed and card:inherits("Slash") and (player:getMark("ewslash")) < 2 then
             player:addMark("ewslash")
			if (player:getMark("ewslash")) == 2 then
            if not player:getWeapon() then
            room:setPlayerFlag(player, "jcused")
			elseif  player:getWeapon() and player:getWeapon():className() ~= "Crossbow" then
			 room:setPlayerFlag(player, "jcused")
			end 
			end
  end 
  if event == sgs.CardLost and (player:getMark("ewslash")) >=2 then
      local move = data:toCardMove()
      local cardm = sgs.Sanguosha:getCard(move.card_id)
     if cardm:className() == "Crossbow" then
        room:setPlayerFlag(player, "jcused")
     end
  end	 
  if (event == sgs.CardFinished) then
     if   player:getWeapon() then
       if  player:getWeapon():className() == "Crossbow" then
	    room:setPlayerFlag(player, "-jcused")
	   end
	 end
  end
  if  (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Finish) then
		    player:setMark("ewslash",0)
  end
   if  (event == sgs.PhaseChange and player:getPhase() == sgs.Player_Finish) and player:hasSkill("#luajcfl") then
		   room:detachSkillFromPlayer(player,"#luajcfl")
	end
  end,
  }
  luaczx:addSkill(luajiangcix)
  luaczx:addSkill(luajcfl)
  sgs.LoadTranslationTable{
	["luaczx"] = "曹彰",
	["luajiangcix"] = "将驰",
	["luajccard"] = "将驰",
	["luajccards"] = "将驰",
    ["#luajcfl"] = "禁杀",
	[":#luajcfl"] = "本回合你不能使用杀",
	["sm"] = "少摸一张牌",
	["dm"] = "多摸一张牌",
	["@jc_ts1"] = "本回合你不能使用【杀】",
	[":luajiangcix"] = "摸牌阶段摸牌时，你可以选择一项：1.额外摸一张牌，若如此做，你不能使用或打出【杀】直到回合结束。 2.少摸一张牌，若如此做，出牌阶段你使用【杀】时无距离限制且你可以额外使用一张【杀】，直到回合结束(你需要通过点击本技能按钮使用杀来获得无视距离和额外出杀的效果)。",
}
--关兴&张苞
luagxzb=sgs.General(extension, "luagxzb", "shu")
luafuhunx = sgs.CreateTriggerSkill{
name = "luafuhunx",
events = {sgs.PhaseChange,sgs.DrawNCards},
on_trigger = function (self, event, player, data)
	local room = player:getRoom()
if event == sgs.DrawNCards then
	    if not room:askForSkillInvoke( player,"luafuhunx") then return false end
         local idlist=room:getNCards(2)
                    room:fillAG(idlist,nil)				
                    while true do
                            local cd_id=room:askForAG(player,idlist,true,self:objectName())
							if cd_id==-1 then break end   					
                    end
	 for _,id in sgs.qlist(idlist) do
	    if not player:hasSkill("hongyan") and (sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Spade or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Club) then 
		  room:setPlayerFlag(player, "black")
        elseif not player:hasSkill("hongyan") and (sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Heart or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Diamond) then
          room:setPlayerFlag(player, "red")
       end		  
	   if player:hasSkill("hongyan") and sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Club then
       room:setPlayerFlag(player, "black")
	   elseif player:hasSkill("hongyan") and (sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Heart or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Diamond or sgs.Sanguosha:getCard(id):getSuit() == sgs.Card_Spade) then
       room:setPlayerFlag(player, "red")
       end
       card = sgs.Sanguosha:getCard(id)
	   room:takeAG(player, card:getId())	  
	 end
	 for _,id in sgs.qlist(idlist) do
		 idlist:removeOne(id)
	 end
	 for _,p in sgs.qlist(room:getAllPlayers()) do
		p:invoke("clearAG")
	 end
	 if (player:hasFlag("black") and player:hasFlag("red")) then
		    room:acquireSkill(player,"wusheng")
			room:acquireSkill(player,sgs.Skill("paoxiao"))
        end
  data:setValue(0)
  return true
end		
    if player:getPhase()==sgs.Player_Finish then
	        room:detachSkillFromPlayer(player,"wusheng")	
			room:detachSkillFromPlayer(player,"paoxiao")
	end

end
}
luagxzb:addSkill(luafuhunx)
sgs.LoadTranslationTable{
	["luagxzb"] = "关兴&张苞",
	["luafuhunx"] = "父魂",
	[":luafuhunx"] = "摸牌阶段，你可以放弃摸牌，改为亮出牌堆顶的两张牌并获得之，若亮出的牌不为同一颜色，则你获得技能“武圣”和“咆哮”直到回合结束。",
}
--廖化
lualiaohuax=sgs.General(extension, "lualiaohuax", "shu")
luadangxianx = sgs.CreateTriggerSkill
{
name = "luadangxianx",
events = {sgs.PhaseChange},
frequency=sgs.Skill_Compulsory,
on_trigger = function(self, event, player, data)
    local room = player:getRoom()   
    if player:getPhase()==sgs.Player_Start and player:getMark("realturn")==0 then
	    return true
	elseif player:getPhase()==sgs.Player_Judge and player:getMark("realturn")==0 then
	    return true
	elseif player:getPhase()==sgs.Player_Draw and player:getMark("realturn")==0 then
	    local log=sgs.LogMessage()
		log.type = "#luadangxianx"
		log.from  = player
	    log.arg = "luadangxianx"
		room:sendLog(log)
		room:playSkillEffect("luadangxianx")
	    return true
	elseif player:getPhase()==sgs.Player_Discard and player:getMark("realturn")==0 then
	    room:setPlayerFlag(player, "-fsused")
	    player:addMark("realturn")
		room:setPlayerMark(player,"fsx",0)
	    player:gainAnExtraTurn()
	    return true
	elseif player:getPhase()==sgs.Player_Finish and player:getMark("realturn")==1 then
	    room:setPlayerMark(player,"realturn",0)
	end
	if player:getPhase()==sgs.Player_Play and player:getMark("realturn")==0 then
	   room:setPlayerFlag(player, "fsused")
	   room:askForUseCard(player, "","@ewcp:")
	end
	return false
end
}
luafulix=sgs.CreateTriggerSkill{
name="luafulix",
events={sgs.GameStart,sgs.AskForPeaches}, 
frequency=sgs.Skill_Limited, --限定
 can_trigger=function(self,player)
    return player:hasSkill("luafulix")
 end,
on_trigger=function(self,event,player,data)
	local room=player:getRoom()
	local getKingdoms=function() --可以在函数中定义函数
			local kingdoms={}
			local kingdom_number=0
			local players=room:getAlivePlayers()
			for _,aplayer in sgs.qlist(players) do
				if not kingdoms[aplayer:getKingdom()] then
					kingdoms[aplayer:getKingdom()]=true
					kingdom_number=kingdom_number+1
				end
			end
			return kingdom_number
		end
if event==sgs.GameStart then
    player:gainMark("@fulix",1) --给个标记
elseif event==sgs.AskForPeaches then
    local dying=data:toDying()
	local getKingdoms=function() --可以在函数中定义函数
			local kingdoms={}
			local kingdom_number=0
			local players=room:getAlivePlayers()
			for _,aplayer in sgs.qlist(players) do
				if not kingdoms[aplayer:getKingdom()] then
					kingdoms[aplayer:getKingdom()]=true
					kingdom_number=kingdom_number+1
				end
			end
			return kingdom_number
		 end
	if not dying.who:hasSkill("luafulix") then return false end
	if player:getMark("@fulix")==1 and room:askForSkillInvoke(player,"luafulix") then
	    room:playSkillEffect("fulix")
	    player:loseMark("@fulix")		
       local x = getKingdoms()
	   local y = player:getHp()
	   if x>5 then
	      x=5
		end
       local z=(x-y)		
		local recov = sgs.RecoverStruct()
		recov.who = player
		recov.recover = z
		room:recover(player, recov)
		player:turnOver()	
	end
end
end,
}

lualiaohuax:addSkill(luadangxianx)
lualiaohuax:addSkill(luafulix)
sgs.LoadTranslationTable{
	["lualiaohuax"] = "廖化",
	["luadangxianx"] = "当先",
	["luafulix"] = "伏枥",
	["#luadangxianx"] = "%from 的锁定技 【<font color='red'><b>当先</b></font>】 被触发，获得了一个额外的出牌阶段",
	[":luadangxianx"] = "<b>锁定技，</b>回合开始时，你先执行一个额外的出牌阶段。",
	["fulix"] = "伏枥",
	["@fulix"] = "伏枥",
	["@ewcp"] = "你获得了一个额外出牌阶段。",
	[":luafulix"] = "<b>限定技，</b>当你处于濒死状态时，你可以将体力回复至X点（X为现存势力数），然后将你的武将牌翻面。",
}
--马岱 		
luamadaix=sgs.General(extension, "luamadaix", "shu")
luaqxx=sgs.CreateTriggerSkill{
	name="luaqxx",
	events={sgs.Predamage},
	frequency = sgs.Skill_Frequency,
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		local damage=data:toDamage()
		local card = damage.card
		if event == sgs.Predamage and card:inherits("Slash") then
		   if player:distanceTo(damage.to)>1 then return false end
		   if not room:askForSkillInvoke( player,"luaqxx") then return false end
		        local judge = sgs.JudgeStruct()
				judge.pattern = sgs.QRegExp("(.*):(heart):(.*)")
				judge.good = true
				judge.reason = "luaqxx"
				judge.who = player
				room:judge(judge)
				if (judge:isBad()) then
			    local log=sgs.LogMessage()
		        log.type = "#TriggerSkill"
		        log.from  = player
	    	    log.arg = "luaqxx"
		        room:sendLog(log)
		        room:playSkillEffect("luaqxx")
				room:getThread():delay()          
				room:loseMaxHp(damage.to,1)
				return true		    
				else
				return false
				end
		end 
	end,
}

luamashux=sgs.CreateDistanceSkill{
 name = "luamashux",
 correct_func=function(self,from,to)
  if from:hasSkill("luamashux") then
   return -1
  end
 end,
}

luamadaix:addSkill(luaqxx)
luamadaix:addSkill(luamashux)
sgs.LoadTranslationTable{
	["luamadaix"] = "马岱",
	["luaqxx"] = "潜袭",
	["luamashux"] = "马术",
	[":luaqxx"] = "<b>锁定技，</b>每当你使用【杀】对距离为1的目标角色造成伤害时，你可以进行一次判定，若判定结果不为红桃，你防止此伤害，改为令其减1点体力上限。",
	[":luamashux"] = "你计算与其他角色的距离时，始终-1。",
} 		  
--步练师
luablsx=sgs.General(extension, "luablsx", "wu",3,false)
luaanxuxcard=sgs.CreateSkillCard{ 
name="luaanxuxcard",
target_fixed=false,
filter=function(self,targets,to_select)
    if #targets==0 then 
	    return not to_select:hasSkill("luaanxux")
    elseif #targets==1 then
		return to_select:getHandcardNum()~=targets[1]:getHandcardNum() and not to_select:hasSkill("luaanxux") end
	return #targets < 2
end,
on_use=function(self,room,source,targets)		
	room:throwCard(self)
	local lose,gain
	if targets[1]:getHandcardNum()<targets[2]:getHandcardNum() then 
	    lose=targets[2]
		gain=targets[1]
	else
	    lose=targets[1]
		gain=targets[2]
	end
	local card_id=room:askForCardChosen(gain,lose,"h","luaanxux")
	local card=sgs.Sanguosha:getCard(card_id)
	room:moveCardTo(sgs.Sanguosha:getCard(card_id),gain, sgs.Player_Hand, false)
	room:showCard(gain,card:getEffectiveId(),nil)
	room:getThread():delay()          
	if card:getSuit() ~= sgs.Card_Spade then 
        source:drawCards(1)
	end
	room:setPlayerFlag(source,"luaanxuxused")	
end
}
luaanxux=sgs.CreateViewAsSkill{
name="luaanxux",
n=0,
view_as=function(self, cards)
	if #cards==0 then 
	local acard=luaanxuxcard:clone()	
	acard:setSkillName("luaanxux")
	return acard 
	end
end,
enabled_at_play=function(self,player)
	return not player:hasFlag("luaanxuxused")
end,
}
luazhuiyix=sgs.CreateTriggerSkill{
frequency = sgs.Skill_Frequency,
name = "luazhuiyix",
events={sgs.Death,sgs.PhaseChange}, 
can_trigger=function(self,player)
	return player:hasSkill("luazhuiyix") end,
on_trigger=function(self,event,player,data)
	local room = player:getRoom()
    local damage = data:toDamageStar()
	if(event == sgs.PhaseChange and player:getPhase() == sgs.Player_Start) then
	   room:setPlayerFlag(player,"-luaanxuxused")
	end
	if event == sgs.Death then
	if room:askForSkillInvoke(player,"luazhuiyix") then
	    local target=room:askForPlayerChosen(player,room:getOtherPlayers(damage.from),"luazhuiyix")
	    target:drawCards(3)
		local recov = sgs.RecoverStruct()
		recov.who = target
		recov.recover = 1
		room:recover(target, recov)	
    end
	end
end
}	

luablsx:addSkill(luaanxux)
luablsx:addSkill(luazhuiyix)
sgs.LoadTranslationTable{
	["luablsx"] = "步练师",
	["luaanxux"] = "安恤",
	["luaanxuxcard"] = "安恤",
	[":luaanxux"] = "出牌阶段，你可以指定其他两名手牌数不同的角色，其中手牌较少的角色获得手牌较多的角色一张手牌并展示之。若此牌非黑桃，则你摸一张牌。每阶段限一次。" ,
    ["luazhuiyix"] = "追忆",
	[":luazhuiyix"] = "你死亡时，可指定一名杀死你之外的角色，该角色摸三张牌并回复1点体力。",
}
--韩当
luahandangx = sgs.General(extension, "luahandangx", "wu", 4, true,false)
luagqcardf = sgs.CreateSkillCard
{--技能卡
        name="luagqcardf",
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
		    slash:setSkillName("luagqx")
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
luagqcard = sgs.CreateSkillCard
{--技能卡
        name="luagqcard",
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
		local cdid = self:getEffectiveId()
		local cardx = sgs.Sanguosha:getCard(cdid)
		local target = targets[1]				
		local slash = sgs.Sanguosha:cloneCard("slash", cardx:getSuit(), cardx:getNumber())
		    slash:setSkillName("luagqx")
			slash:addSubcard(self)
			local use = sgs.CardUseStruct()
			use.from = source
			use.to:append(target)
			use.card = slash
			room:useCard(use, true)			
		end,
		}
luagqx=sgs.CreateViewAsSkill{
name="luagqx",
n=1,
view_filter=function(self,selected,to_select)
   return to_select:inherits("EquipCard")
end,
view_as = function(self, cards)
	if #cards==1 then
	    if (sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Halberd") and sgs.Self:getHandcardNum() == 1 then
		acard=luagqcardf:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
		else
		acard=luagqcard:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
		end
	end
end,

enabled_at_play = function()
		return ((sgs.Self:canSlashWithoutCrossbow()) or (sgs.Self:getWeapon() and sgs.Self:getWeapon():className()=="Crossbow")) or (sgs.Self:hasFlag("sm") and not sgs.Self:hasFlag("jcused")) or (not sgs.Self:hasFlag("fsslash") and sgs.Self:hasFlag("oshh"))
	end,
enabled_at_response=function(self,player,pattern)
 return pattern=="slash"
end,
}

  
luajiefanx = sgs.CreateTriggerSkill
{
name = "luajiefanx",
frequency = sgs.Skill_NotFrequent,
events = {sgs.Dying,sgs.Predamage,sgs.CardFinished},
can_trigger= function()
	return true 
end,
on_trigger = function(self, event, player, data)
	local room = player:getRoom()
	local hdx=room:findPlayerBySkillName(self:objectName())
	if hdx == nil then return false end
if event==sgs.Dying then
	local dying=data:toDying()
	room:setPlayerFlag(dying.damage.to, "dying")
	local target = room:getCurrent()
	if target:isKongcheng() and target:hasSkill("kongcheng") then return false end
	if dying.damage.to:getHp()>0 then return false end
	   if not room:askForSkillInvoke(hdx,"luajiefanx") then return false end
	    room:setPlayerFlag(hdx,"jiefanxx")
	    local slash = room:askForCard(hdx, "slash", "@luajiefanx-slash:")
		if slash ~= nil then
		    local use=sgs.CardUseStruct()
		    local card=slash
			card:addSubcard(slash:getId())
            card:setSkillName("luajiefanx")
            use.card = card
            use.from = hdx
            use.to:append(target)
            room:useCard(use)
		end
elseif event==sgs.Predamage and player:hasFlag("jiefanxx") then
    room:setPlayerFlag(hdx,"-jiefanxx")
    local damage=data:toDamage()
	    local use=sgs.CardUseStruct()
		local peach=sgs.Sanguosha:cloneCard("peach",sgs.Card_NoSuit,0) 
		use.card = peach
        use.from = hdx
		for _,p in sgs.qlist(room:getAlivePlayers()) do
		    if p:hasFlag("dying") then
		        use.to:append(p)
			end
		end
        room:useCard(use)
		return true
end
if (event == sgs.CardFinished) and player:hasFlag("jiefanxx") then
     for _,p in sgs.qlist(room:getAlivePlayers()) do
		    if p:hasFlag("dying") then
		        room:setPlayerFlag(p, "-dying")
			end
		end
     room:setPlayerFlag(player, "-jiefanxx")
  end
if event==sgs.Dying then
   local dying=data:toDying()
   if dying.damage.to:getHp()>0 then return true end
 end
end
}

	     
luahandangx:addSkill(luagqx)
luahandangx:addSkill(luajiefanx)
sgs.LoadTranslationTable{
	["luahandangx"] = "韩当",
	["luagongqix"] = "弓骑",	
	["luagqx"] = "弓骑",
	["luagqcard"] = "弓骑",
	["luagqcardf"] = "弓骑",
	["luajiefanx"] = "解烦",
	[":luagqx"] = "你可以将一张装备牌当【杀】使用或打出，你以此法使用的【杀】无距离限制。",
	[":luajiefanx"] ="当有角色进入濒死状态时，你可对当前回合角色使用一张【杀】，此【杀】造成伤害时，你防止此伤害，视为对该濒死角色使用了一张【桃】。",
	["@luajiefanx-slash"] ="请对当前回合玩家使用一张杀。"
} 
--程普
luachenpux=sgs.General(extension, "luachenpux", "wu")
lualhcardft = sgs.CreateSkillCard
{--技能卡
        name="lualhcardft",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if  #targets > 3  then return false end
                if to_select:isKongcheng() and to_select:hasSkill("kongcheng") then return false end				
				if to_select:objectName() == player:objectName() then return false end
                if not sgs.Self:hasFlag("sm") then
                return sgs.Self:canSlash(to_select,true)
				end
				return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local target = targets[1]
		local targett = targets[2]
		local targetr = targets[3]
		local targetf = targets[4]
		for _,card in sgs.qlist(self:getSubcards()) do
             cdid = self:getEffectiveId()
		     cardx = sgs.Sanguosha:getCard(cdid)
        end
		
		if self:subcardsLength() == 1 then				
		local slash = cardx
		    slash:setSkillName("luagqx")
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
			if targetf~=nil then
			use.to:append(targetf)
			end
			use.card = slash
			room:useCard(use, true)
	    end
		end,
		}
lualhcardff = sgs.CreateSkillCard
{--技能卡
        name="lualhcardff",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if  #targets > 3  then return false end 
                if to_select:isKongcheng() and to_select:hasSkill("kongcheng") then return false end				
				if to_select:objectName() == player:objectName() then return false end
                if not sgs.Self:hasFlag("sm") then
                return sgs.Self:canSlash(to_select,true)
				end
				return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		room:setPlayerFlag(source, "fslash")
		local target = targets[1]
		local targett = targets[2]
		local targetr = targets[3]
		local targetf = targets[4]
		for _,card in sgs.qlist(self:getSubcards()) do
             cdid = self:getEffectiveId()
		     cardx = sgs.Sanguosha:getCard(cdid)
        end
		
		if self:subcardsLength() == 1 then				
		local slash = cardx
		    slash:setSkillName("luagqx")
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
			if targetf~=nil then
			use.to:append(targetf)
			end
			use.card = slash
			room:useCard(use, true)
	    end
		end,
		}
lualhcardf = sgs.CreateSkillCard
{--技能卡
        name="lualhcardf",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if #targets > 1  then return false end
				if to_select:isKongcheng() and to_select:hasSkill("kongcheng") then return false end
                if to_select:objectName() == player:objectName() then return false end
                if not sgs.Self:hasFlag("sm") then
                return sgs.Self:canSlash(to_select,true)
				end
				return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		room:setPlayerFlag(source, "fslash")
		local targetf = targets[1]
		local targett = targets[2]
		local cdid = self:getEffectiveId()
		local cardx = sgs.Sanguosha:getCard(cdid)
        if targetf ~= nil and targett ~= nil then		
		local slash = cardx
		    slash:setSkillName("lualhx")
			slash:addSubcard(self)
			local use = sgs.CardUseStruct()
			use.from = source
			local y=0
			for var=1,2,1 do
			y=y+1
			use.to:append(targets[y])
			end
			use.card = slash
			room:useCard(use, true)
        elseif targetf ~= nil and targett == nil then
            local slash = cardx
		    slash:setSkillName("lualhx")
			slash:addSubcard(self)
			local use = sgs.CardUseStruct()
			use.from = source
			use.to:append(targetf)
			use.card = slash
			room:useCard(use, true)
	    else
		    local slash = cardx
		    slash:setSkillName("lualhx")
			slash:addSubcard(self)
			local use = sgs.CardUseStruct()
			use.from = source
			use.to:append(targett)
			use.card = slash
			room:useCard(use, true)
		end
        		
		end,
		}
lualhcard = sgs.CreateSkillCard
{--技能卡
        name="lualhcard",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if #targets > 1  then return false end
				if to_select:isKongcheng() and to_select:hasSkill("kongcheng") then return false end
                if to_select:objectName() == player:objectName() then return false end
				if not sgs.Self:hasFlag("sm") then
                return sgs.Self:canSlash(to_select,true)
				end
				return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local targetf = targets[1]
		local targett = targets[2]
		local cdid = self:getEffectiveId()
		local cardx = sgs.Sanguosha:getCard(cdid)
        if targetf ~= nil and targett ~= nil then		
		local slash = sgs.Sanguosha:cloneCard("fire_slash", cardx:getSuit(), cardx:getNumber())
		    slash:setSkillName("lualhx")
			slash:addSubcard(self)
			local use = sgs.CardUseStruct()
			use.from = source
			local y=0
			for var=1,2,1 do
			y=y+1
			use.to:append(targets[y])
			end
			use.card = slash
			room:useCard(use, true)
        elseif targetf ~= nil and targett == nil then
            local slash = sgs.Sanguosha:cloneCard("fire_slash", cardx:getSuit(), cardx:getNumber())
		    slash:setSkillName("lualhx")
			slash:addSubcard(self)
			local use = sgs.CardUseStruct()
			use.from = source
			use.to:append(targetf)
			use.card = slash
			room:useCard(use, true)
	    else
		    local slash = sgs.Sanguosha:cloneCard("fire_slash", cardx:getSuit(), cardx:getNumber())
		    slash:setSkillName("lualhx")
			slash:addSubcard(self)
			local use = sgs.CardUseStruct()
			use.from = source
			use.to:append(targett)
			use.card = slash
			room:useCard(use, true)
		end       			
		end,
		}
lualhx = sgs.CreateViewAsSkill
{  
name = "lualhx",
n = 1,
view_filter = function(self, selected, to_select)
 if to_select:inherits("ThunderSlash") then return false end
 if to_select:inherits("Slash")	then return true end
end,
view_as = function(self, cards)
	if #cards==1 then
	    local card = cards[1]
	 if card:inherits("FireSlash") then
		if (sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Halberd") and sgs.Self:getHandcardNum() == 1 then 
		acard=lualhcardff:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
		else
		acard=lualhcardf:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
		end
	 else
	    if (sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Halberd") and sgs.Self:getHandcardNum() == 1 then
		acard=lualhcardft:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
		else
		acard=lualhcard:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
		end
	 end
	end
end,
enabled_at_play = function()
		return ((sgs.Self:canSlashWithoutCrossbow()) or (sgs.Self:getWeapon() and sgs.Self:getWeapon():className()=="Crossbow")) or (sgs.Self:hasFlag("sm") and not sgs.Self:hasFlag("jcused")) or (not sgs.Self:hasFlag("fsslash") and sgs.Self:hasFlag("oshh"))
end,
enabled_at_response=function(self,player,pattern)
    return false
end,
}

lualihuox = sgs.CreateTriggerSkill{
 name="lualihuox",
 view_as_skill = lualhx,
 events={sgs.CardFinished,sgs.Damage},
 frequency = sgs.Skill_Frequency,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local cardd=data:toDamage().card
  
  if event == sgs.Damage and cardd:inherits("Slash") and not player:hasFlag("fslash") and cardd:getSkillName() == "lualhx" then     
	    player:addMark("lhd")
  end
  if event == sgs.CardFinished and player:hasFlag("fslash") then
      room:setPlayerFlag(player, "-fslash")
  end
  if event == sgs.CardFinished then
     if (player:getMark("lhd")) > 0 then
	  player:setMark("lhd",0)
	   room:loseHp(player,1)
     end	   
  end
	 
  end,
  }
  
  luacmvcard = sgs.CreateSkillCard
{
	name = "luacmvcard",	
	target_fixed = true,	
	will_throw = false,
on_use = function(self, room, source, targets)
        local room = source:getRoom()
	for _,card in sgs.qlist(self:getSubcards()) do
		source:addToPile("cmx", card, true)
    end		
end,
}

luacmv=sgs.CreateViewAsSkill{
name="luacmv",
n=999,
view_filter=function(self, selected, to_select)
	return to_select:inherits("Slash")
end,
view_as = function(self, cards)
   local x = #cards
		if #cards>0 then
		acard=luacmvcard:clone()
		local y=0
		for var=1,x,1 do
		y=y+1
		acard:addSubcard(cards[y])
		end
		acard:setSkillName(self:objectName())
		return acard
	end
end,
enabled_at_play = function()
	return false
end,
enabled_at_response = function()
	return false
end,
}
  luachunmiux = sgs.CreateTriggerSkill
{
name = "luachunmiux",
view_as_skill = luacmv,
frequency = sgs.Skill_Frequency,
events = {sgs.PhaseChange,sgs.Dying},
can_trigger= function()
	return true 
end,
on_trigger = function(self, event, player, data)
	local room = player:getRoom()
	local luacpx=room:findPlayerBySkillName(self:objectName())
	if luacpx == nil then return false end
	  if  event==sgs.PhaseChange and player:getPhase()== sgs.Player_Finish then
	     if not player:hasSkill("luachunmiux") then return false end
		 local fields = sgs.IntList()
		fields = player:getPile("cmx")
		if fields:length() > 0 then return false end
        if not room:askForSkillInvoke( player,"luachunmiux") then return false end	  
		qcuse = room:askForUseCard(player, "@@luachunmiux", "@luachunmiux:")
	  end
	 if event==sgs.Dying then
	    local dying=data:toDying()
		local fields = sgs.IntList()
		fields = luacpx:getPile("cmx")
		if fields:isEmpty() then return false end
        if not room:askForSkillInvoke(luacpx,"luachunmiux") then return false end
	      if fields:length() == 1 then
			card_id = fields:first()
			local cardx = sgs.Sanguosha:getCard(card_id)
		    room:moveCardTo(cardx,nil,sgs.Player_DiscardedPile,true)
			local use=sgs.CardUseStruct()
		local card=sgs.Sanguosha:cloneCard("analeptic",cardx:getSuit(),cardx:getNumber()) 
		card:addSubcard(cardx:getEffectiveId())
        card:setSkillName("luachunmiux")
        use.card = card
        use.from = dying.who
        use.to:append(dying.who)
        room:useCard(use)
		  else
		    while (luacpx:getMark("cmj")) < 1 do
			room:fillAG(fields, luacpx)
			card_id = room:askForAG(luacpx,fields,true,"luachunmiux")
			luacpx:invoke("clearAG")
			 if card_id == -1 then break end
			  fields:removeOne(card_id)
			  cardx = sgs.Sanguosha:getCard(card_id)			 
			  room:moveCardTo(cardx,nil,sgs.Player_DiscardedPile,true)
              luacpx:addMark("cmj")			  
		   end
		   luacpx:setMark("cmj",0)
		   local use=sgs.CardUseStruct()
		      local card=sgs.Sanguosha:cloneCard("analeptic",cardx:getSuit(),cardx:getNumber()) 
		      card:addSubcard(cardx:getEffectiveId())
              card:setSkillName("luachunmiux")
              use.card = card
              use.from = dying.who
              use.to:append(dying.who)
              room:useCard(use)
			  
		 end
	end
end
}
luachenpux:addSkill(lualihuox)
luachenpux:addSkill(luachunmiux)

sgs.LoadTranslationTable{
	["luachenpux"] = "程普",
	["lualihuox"] = "疠火",	
	["lualhx"] = "疠火",	
	["lualhcardf"] = "疠火",
	["lualhcard"] = "疠火",
	["cmx"] = "醇",
	["luachunmiux"] = "醇醪",
	[":lualihuox"] = "你可以将一张普通【杀】当火【杀】使用。若以此法使用的【杀】造成了伤害，则此【杀】结算后你失去1点体力；你使用火【杀】时，可以额外指定一个目标(使用原牌火杀需额外指定目标时请点击本技能按钮使用)。",
	[":luachunmiux"] ="回合结束阶段开始时，若你的武将牌上没有牌，你可以将任意数量的【杀】置于你的武将牌上，称为“醇”。当一名角色处于濒死状态时，你可以将一张“醇”置入弃牌堆，视为该角色使用一张【酒】。",
	["@luachunmiux"] ="请选择任意数量的【杀】加入【醇】。"
} 
--华雄
luahuaxiongx=sgs.General(extension, "luahuaxiongx", "qun",6)
luashiyongx = sgs.CreateTriggerSkill
{
name = "luashiyongx",
frequency = sgs.Skill_Compulsory,
events = {sgs.Damaged,sgs.Damage,sgs.CardUsed,sgs.SlashMissed},
can_trigger = function(self, player)
		return true
	end,
on_trigger = function(self, event, player, data)
	local room = player:getRoom()
    local damage = data:toDamage()
    local card = damage.card
    local to = damage.to
	if (event == sgs.CardUsed) then
		  local card = data:toCardUse().card
		  if  card:inherits("Analeptic") then
		      room:setPlayerFlag(player, "syx")
		  end
		end
    if event == sgs.Damaged then
	   if not to:hasSkill("luashiyongx") then return false end
	   if (card:inherits("Slash") and card:isRed()) then
	       room:loseMaxHp(to,1)
	   end
	end	
	 if event == sgs.Damage and player:hasFlag("syx") and card:inherits("Slash") and card:isBlack() then
	       if not to:hasSkill("luashiyongx") then return false end
	       room:loseMaxHp(to,1)
		   room:setPlayerFlag(player, "-syx")
	 end
	 if event == sgs.SlashMissed and player:hasFlag("syx") then
		   room:setPlayerFlag(player, "-syx")
	 end
	    
end
}
luahuaxiongx:addSkill(luashiyongx)
sgs.LoadTranslationTable{
	["luahuaxiongx"] = "华雄",
	["luashiyongx"] = "恃勇",
	[":luashiyongx"] = "<b>锁定技，</b>你每受到一次红色【杀】或【酒】【杀】造成的伤害后，减少1点体力上限。",
} 	
--刘表
lualiubiaox=sgs.General(extension, "lualiubiaox", "qun",4)
luazishoux = sgs.CreateTriggerSkill{
 name="luazishoux",
 events={sgs.DrawNCards,sgs.PhaseChange},
 frequency = sgs.Skill_Frequency,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  if(event == sgs.DrawNCards) then
    if not player:isWounded() then return false end
    if (not room:askForSkillInvoke(player,"luazishoux")) then return false end
    local x = player:getLostHp()
	data:setValue(data:toInt()+x)
	 room:setPlayerFlag(player, "zsx")
  end
  if (event==sgs.PhaseChange) and (player:getPhase()== sgs.Player_Play) then
      if player:hasFlag("zsx") then
	  return true
	  end
  end
  end,
 }
	      
luazongshix = sgs.CreateTriggerSkill{
 name="luazongshix",
 events={sgs.PhaseChange},
 frequency = sgs.Skill_Compulsory,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local getKingdoms=function() --可以在函数中定义函数
			local kingdoms={}
			local kingdom_number=0
			local players=room:getAlivePlayers()
			for _,aplayer in sgs.qlist(players) do
				if not kingdoms[aplayer:getKingdom()] then
					kingdoms[aplayer:getKingdom()]=true
					kingdom_number=kingdom_number+1
				end
			end
			return kingdom_number
		end
local y=getKingdoms() 
  if (event==sgs.PhaseChange) and (player:getPhase()== sgs.Player_Discard) then
  local x=player:getHp()
   local z = player:getHandcardNum()
   if z <= (y+x) then
   return true
   else
       local e = z-(y+x)
      room:askForDiscard(player,"luakuanhou",e,false,false)
	  return true
  end
  end
  end,
  }
 lualiubiaox:addSkill(luazishoux) 
 lualiubiaox:addSkill(luazongshix)
 
 sgs.LoadTranslationTable{
	["lualiubiaox"] = "刘表",
	["luazishoux"] = "自守",
	[":luazishoux"] = "摸牌阶段，你可以额外摸X张牌（X为你已损失的体力值），然后跳过你此回合的出牌阶段。",
	["luazongshix"] = "宗室",
	[":luazongshix"] = "<b>锁定技，</b>你的手牌上限为当前体力值加上场上现存势力数。",
} 	

--法正
luanyjfazheng = sgs.General(extension, "luanyjfazheng", "shu", 3, true,false)
luaenyuancard = sgs.CreateSkillCard
{--技能卡
        name="luaenyuancard",
        target_fixed=true,
        will_throw=true,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local luanfz = room:findPlayerBySkillName("luaenyuan")
		room:moveCardTo(self, luanfz, sgs.Player_Hand, false)
		end,
		}
luaenyuanv=sgs.CreateViewAsSkill{
name="luaenyuanv",
n=1,
view_filter=function(self,selected,to_select)
return not to_select:isEquipped()
end,
view_as = function(self, cards)
if #cards==1 then
		acard=luaenyuancard:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
end
end,

enabled_at_play = function()
		return false
end,
enabled_at_response=function()
        return false
end,
}
luaenyuan = sgs.CreateTriggerSkill
{
	name = "luaenyuan",
	view_as_skill = luaenyuanv,
	events = {sgs.Damaged,sgs.CardGot,sgs.CardGotDone},
	frequency = sgs.Skill_NotFrequent,
	can_trigger = function(self, player)
		return true
	end,
on_trigger = function(self, event, player, data)
		 local room=player:getRoom()
		 local luanfzx = room:findPlayerBySkillName("luaenyuan")
		 if luanfzx == nil then return false end
 if event==sgs.CardGot then
local move=data:toCardMove()
if not move.to:hasSkill("luaenyuan") then return false end
if move.from then
room:setPlayerFlag(move.from, "cfrom")
end
move.to:addMark("drw")
end
if event==sgs.CardGotDone then
    if luanfzx:getMark("drw") <2 then
     luanfzx:setMark("drw",0)
	end
   if luanfzx:getMark("drw") >1 then
      if (not room:askForSkillInvoke(player,"luaenyuan")) then return false end
      for _,p in sgs.qlist(room:getOtherPlayers(player)) do
		    if p:hasFlag("cfrom") then
			p:drawCards(1)
			room:setPlayerFlag(p, "-cfrom")
			luanfzx:setMark("drw",0)
			end
	 end
   end
end

if event == sgs.Damaged then
   local damage = data:toDamage()
   if not damage.to:hasSkill("luaenyuan") then return false end
    if (not room:askForSkillInvoke(player,"luaenyuan")) then return false end		
   local choice=room:askForChoice(damage.from, self:objectName(), "givecard+losehp")
   if choice=="givecard" then
     local geip = room:askForUseCard(damage.from, "@@luaenyuan", "@luaenyuanv1ts:")
	    if not geip then
		  room:loseHp(damage.from,1)
		end
   elseif choice=="losehp" then
     room:loseHp(damage.from,1)
   end
end
end
}
luaxuanhuo = sgs.CreateTriggerSkill
{
	name = "luaxuanhuo",
	events = {sgs.PhaseChange},
	frequency = sgs.Skill_NotFrequent,
on_trigger = function(self, event, player, data)
		 local room=player:getRoom()
		 if event == sgs.PhaseChange and player:getPhase()==sgs.Player_Draw then
		    if (not room:askForSkillInvoke(player,"luaxuanhuo")) then return false end
			    local targets = room:getOtherPlayers(player)
				local target = room:askForPlayerChosen(player, targets, "@luaxuanhuo")
				if not target then return false end
				target:drawCards(2)
				local targetsc = sgs.SPlayerList()
                 for _, aplayer in sgs.qlist(room:getAllPlayers()) do
                 if target:canSlash(aplayer) then targetsc:append(aplayer) end
                 end
				local targetcc = room:askForPlayerChosen(player, targetsc, "@luaxuanhuo")
				if targetcc ~= nil then
				local log = sgs.LogMessage()
	            log.type = "#luaxuanhuo"
	            log.from = player
	            log.arg = targetcc:getGeneralName()
	            room:sendLog(log)
				local slash = room:askForCard(target, "slash", "@luaxuanhuo3:")	 			
			    if (slash ~= nil) then
		        slash:setSkillName("luaxuanhuo")
			    local use = sgs.CardUseStruct()
			    use.from = target
			    use.to:append(targetcc)
			    use.card = slash
			    room:useCard(use, false)
				else
				for var=1,2,1 do
				local card_id = room:askForCardChosen(player, target, "he", "luaxuanhuo")
				room:moveCardTo(sgs.Sanguosha:getCard(card_id), player, sgs.Player_Hand, false)
				player:addMark("drwey")
				end
				if player:getMark("drwey") >1 then
				   if (not room:askForSkillInvoke(player,"luaenyuan")) then return false end
				   target:drawCards(1)
				end
				end
				 player:setMark("drwey",0)
				return true
			    else
				for var=1,2,1 do
				local card_id = room:askForCardChosen(player, target, "he", "luaxuanhuo")
				room:moveCardTo(sgs.Sanguosha:getCard(card_id), player, sgs.Player_Hand, false)
				player:addMark("drwey")
				end
				if player:getMark("drwey") >1 then
				   if (not room:askForSkillInvoke(player,"luaenyuan")) then return false end
				   target:drawCards(1)
				end
				player:setMark("drwey",0)
				return true
				end
		end
end
}
luanyjfazheng:addSkill(luaxuanhuo)
luanyjfazheng:addSkill(luaenyuan)      
sgs.LoadTranslationTable{
    ["newyjcm"] = "新一将成名",
	["#luanyjfazheng"] = "蜀汉的辅翼",
    ["luanyjfazheng"] = "法正",
    ["luaxuanhuo"] = "眩惑",
	["luaenyuan"] = "恩怨",
	["luaenyuancard"] = "恩怨",
	[":luaxuanhuo"] = "摸牌阶段开始时，你可以放弃摸牌，改为令一名其他角色摸两张牌，然后该角色需对其攻击范围内，由你选择的另一名角色使用一张【杀】，否则你获得其两张牌。",
	[":luaenyuan"] = "你每次获得一名其他角色两张或更多的牌时，可以令其摸一张牌；每当你受到1点伤害后，你可以令伤害来源选择一项：交给你一张手牌，或失去1点体力。",
	["givecard"] = "给法正一张手牌",
	["losehp"] = "自己流失一点体力",
	["@luaxuanhuo3"] = "请打出一张【 杀】。",
	["@luaenyuanv1ts"] = "请选择一张手牌交给法正。",
	["#luaxuanhuo"] = "法正的【眩惑】技能被触发，法正选择了%arg作为【杀】的目标",
}
--徐庶	 
luanyjxusu = sgs.General(extension, "luanyjxusu", "shu", 3, true,false)
luawuyan = sgs.CreateTriggerSkill
{
	name = "luawuyan",
	events = {sgs.Predamage,sgs.Predamaged},
	frequency = sgs.Skill_Compulsory,
on_trigger = function(self, event, player, data)
		 local room=player:getRoom()
		local damage = data:toDamage()
		local card = damage.card
		if event == sgs.Predamage and card:inherits("TrickCard") then
		        local log = sgs.LogMessage()
	            log.type = "#luawuyan"
	            log.from = player
	            room:sendLog(log)
				return true
		end	
        if event == sgs.Predamaged and card:inherits("TrickCard") then
		        local log = sgs.LogMessage()
	            log.type = "#luawuyan"
	            log.from = player
	            room:sendLog(log)
				return true
		end	
end
}

luajujiancard = sgs.CreateSkillCard
{--技能卡
        name="luajujiancard",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if  #targets > 0  then return false end              				 
				if to_select:objectName() == player:objectName() then return false end
                return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		room:throwCard(self)
		local target = targets[1]
		local choice=room:askForChoice(target, self:objectName(), "drawt+rec+cz")
        if choice=="drawt" then
		   target:drawCards(2)
		elseif choice=="rec" then
		   local recov = sgs.RecoverStruct()
		   recov.card = nil
		   recov.who = target
		   recov.recover=1
		   room:recover(target, recov)
		elseif choice=="cz" then
		   if not target:faceUp() then
		   target:turnOver()
		   end
		   if target:isChained() then 
           room:setPlayerProperty(target, "chained", sgs.QVariant(false))
           end
        end
		end
		}
luajujian=sgs.CreateViewAsSkill{
name="luajujian",
n=1,
view_filter=function(self,selected,to_select)
return  not to_select:inherits("BasicCard")
end,
view_as = function(self, cards)
		if #cards==1 then
		acard=luajujiancard:clone()
		acard:addSubcard(cards[1])
		acard:setSkillName(self:objectName())
		return acard
end
end,

enabled_at_play = function()
		return false
end,
enabled_at_response=function()
        return false
end,
}
luajujiantr = sgs.CreateTriggerSkill
{
	name = "luajujiantr",
	view_as_skill = luajujian,
	events = {sgs.PhaseChange},
	frequency = sgs.Skill_NotFrequent,
on_trigger = function(self, event, player, data)
		 local room=player:getRoom()
   if event == sgs.PhaseChange and player:getPhase()==sgs.Player_Finish then
	 if (not room:askForSkillInvoke(player,"luajujiantr")) then return false end	
     room:askForUseCard(player, "@@luajujiantr", "@luajujiantr:")
   end
end
}
luanyjxusu:addSkill(luawuyan)
luanyjxusu:addSkill(luajujiantr) 
sgs.LoadTranslationTable{
    ["luanyjxusu"] = "徐庶",
	["#luanyjxusu"] = "忠孝的侠士",
    ["luawuyan"] = "无言",
	["luajujiantr"] = "举荐",
	["luajujiancard"] = "举荐",	
	[":luawuyan"] = "锁定技，你防止你造成或受到的任何锦囊牌的伤害。",
	[":luajujiantr"] = "回合结束阶段开始时，你可以弃置一张非基本牌，令一名其他角色选择一项：摸两张牌，或回复1点体力，或将其武将牌翻至正面朝上并重置之。",	
	["drawt"] = "摸两张牌",
	["rec"] = "恢复自己一点体力",
	["cz"] = "将武将牌翻回正面面朝上并重置",
	["@luajujiantr"] = "请选择一张【非基本牌】和一名其他玩家。",
	["#luawuyan"] = "徐庶的【无言】被触发，本次伤害无效",
}
--凌统
luanyjlingtong = sgs.General(extension, "luanyjlingtong", "wu", 4, true,false)
luaxuanfengcard = sgs.CreateSkillCard
{--技能卡
        name="luaxuanfengcard",
        target_fixed=false,
        will_throw=true,
        filter = function(self, targets, to_select, player)
                if  #targets > 1  then return false end              				 
				if to_select:objectName() == player:objectName() then return false end
				if to_select:isNude() then return false end
                return true
        end,
		on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local target = targets[1]
		local targett = targets[2]
		if target ~= nil and targett == nil then
		   if target:getCardCount(true) == 1 then
				local card_id = room:askForCardChosen(source, target, "he", "luaxuanfeng")
				room:throwCard(sgs.Sanguosha:getCard(card_id))
		   else
		   local choice=room:askForChoice(source, self:objectName(), "tone+ttwo")
		     if choice=="tone" then
		      local card_id = room:askForCardChosen(source, target, "he", "luaxuanfeng")
			  room:throwCard(sgs.Sanguosha:getCard(card_id))
			 elseif choice=="ttwo" then
		       for var=1,2,1 do
			    local card_id = room:askForCardChosen(source, target, "he", "luaxuanfeng")
			     room:throwCard(sgs.Sanguosha:getCard(card_id))
               end
             end			
		   end
		 end
		 if target == nil and targett ~= nil then
		   if targett:getCardCount(true) == 1 then
				local card_id = room:askForCardChosen(source, targett, "he", "luaxuanfeng")
				room:throwCard(sgs.Sanguosha:getCard(card_id))
		   else
		    local choice=room:askForChoice(source, self:objectName(), "tone+ttwo")
		   if choice=="tone" then
		      local card_id = room:askForCardChosen(source, targett, "he", "luaxuanfeng")
			 room:throwCard(sgs.Sanguosha:getCard(card_id))
			elseif choice=="ttwo" then
		    for var=1,2,1 do
			  local card_id = room:askForCardChosen(source, targett, "he", "luaxuanfeng")
			 room:throwCard(sgs.Sanguosha:getCard(card_id))
            end
            end			
		   end
		 end
		if target ~= nil and targett ~= nil then
		    local card_id = room:askForCardChosen(source, target, "he", "luaxuanfeng")
			room:throwCard(sgs.Sanguosha:getCard(card_id))
			local card_id = room:askForCardChosen(source, targett, "he", "luaxuanfeng")
			room:throwCard(sgs.Sanguosha:getCard(card_id))
		end
		end
		}
luaxuanfeng=sgs.CreateViewAsSkill{
name="luaxuanfeng",
n=1,
view_filter=function(self,selected,to_select)
return false
end,
view_as = function(self, cards)
		return luaxuanfengcard:clone()
end,

enabled_at_play = function()
		return false
end,
enabled_at_response=function()
        return false
end,
}
luaxuanfengtr = sgs.CreateTriggerSkill
{
	name = "luaxuanfengtr",
	view_as_skill = luaxuanfeng,
	events = {sgs.CardLost,sgs.CardDiscarded,sgs.CardLostDone},
	frequency = sgs.Skill_NotFrequent,
on_trigger = function(self, event, player, data)
		 local room=player:getRoom()
		 local move = data:toCardMove()
   if event == sgs.CardDiscarded then
        if player:getPhase() ~= sgs.Player_Discard then return false end  
        local card = data:toCard()
        if (card:subcardsLength() < 2) then return false end
        if not room:askForSkillInvoke(player,"luaxuanfengtr") then return false end
        room:askForUseCard(player, "@@luaxuanfengtr", "@luaxuanfengtr:")
	end
	if event == sgs.CardLost then
       if (move.from_place==sgs.Player_Equip) then
	   room:setPlayerFlag(player,"elost")
	   end
	end
	if event == sgs.CardLostDone and player:hasFlag("elost") then
       room:setPlayerFlag(player,"-elost")
	   if not room:askForSkillInvoke(player,"luaxuanfengtr") then return false end
       room:askForUseCard(player, "@@luaxuanfengtr", "@luaxuanfengtr:")
    end	   		
end
}
luanyjlingtong:addSkill(luaxuanfengtr) 
sgs.LoadTranslationTable{
    ["luanyjlingtong"] = "凌统",
	["#luanyjlingtong"] = "豪情烈胆",
    ["luaxuanfengtr"] = "旋风",
	["luaxuanfengcard"] = "旋风",
	["tone"] = "弃掉对方一张牌",
	["ttwo"] = "弃掉对方二张牌",
	[":luaxuanfengtr"] = "当你失去装备区里的牌时，或于弃牌阶段弃置了两张或更多的手牌后，你可以依次弃置一至两名其他角色的共计两张牌。",	
	["@luaxuanfengtr"] = "请选择1-2名其他有手牌或装备的玩家。",
}
--张春华
luanyjzhangcunhua = sgs.General(extension, "luanyjzhangcunhua", "wei", 3, false,false)
luajueqing = sgs.CreateTriggerSkill
{
	name = "luajueqing",
	events = {sgs.Predamage},
	frequency = sgs.Skill_Compulsory,
on_trigger = function(self, event, player, data)
		 local room=player:getRoom()
		local damage = data:toDamage()
		local card = damage.card
		if event == sgs.Predamage then
		       local x = damage.damage
			   local log = sgs.LogMessage()
	            log.type = "#luajueqing"
	            log.from = player
	            room:sendLog(log)
			   room:loseHp(damage.to,x)
			   return true
		end	
end
}
luashangshi = sgs.CreateTriggerSkill
{
	name = "luashangshi",
	view_as_skill = luaxuanfeng,
	events = {sgs.CardLost,sgs.Damaged,sgs.CardLostDone,sgs.HpChanged},
	frequency = sgs.Skill_NotFrequent,
    on_trigger = function(self, event, player, data)
		 local room=player:getRoom()
		 local luzch = room:findPlayerBySkillName("luashangshi")
		 local move = data:toCardMove()
	if event == sgs.CardLost then
       if (move.from_place==sgs.Player_Hand) then
	   room:setPlayerFlag(player,"hlost")
	   end
	end
	if event == sgs.CardLostDone and player:hasFlag("hlost") then
       room:setPlayerFlag(player,"-hlost")
	   if player:getPhase() == sgs.Player_Discard then return false end
	   local x=player:getLostHp()
	   local y = player:getHandcardNum()
	   local e=x-y
	   if y>=x then return false end
	   if not room:askForSkillInvoke(player,"luashangshi") then return false end
	   if e>2 then
	   player:drawCards(2)
	   else
	   player:drawCards(e)
	   end
	end
	if event == sgs.Damaged then
	   local x=player:getLostHp()
	   local y = player:getHandcardNum()
	   local e=x-y
	   if y>=x then return false end
	   if not room:askForSkillInvoke(player,"luashangshi") then return false end
	   if e>2 then
	   player:drawCards(2)
	   else
	   player:drawCards(e)
	   end
	end
 if event == sgs.HpChanged then
       local x=player:getLostHp()
	   local y = player:getHandcardNum()
	   local e=x-y
	   if y>=x then return false end
	   if not room:askForSkillInvoke(player,"luashangshi") then return false end
	   if e>2 then
	   player:drawCards(2)
	   else
	   player:drawCards(e)
	   end
 end   
 end	 
}

luanyjzhangcunhua:addSkill(luajueqing) 
luanyjzhangcunhua:addSkill(luashangshi) 	
sgs.LoadTranslationTable{
    ["luanyjzhangcunhua"] = "张春华",
	["#luanyjzhangcunhua"] = "冷血的皇后",
    ["luajueqing"] = "绝情",
	["luashangshi"] = "伤逝",
	[":luajueqing"] = "锁定技，你即将造成的伤害均视为失去体力。",
	[":luashangshi"] = "弃牌阶段外，当你的手牌数小于X时，你可以将手牌补至X张（X为你已损失的体力值且最多为2）。",
	["#luajueqing"] = "张春华的【绝情】被触发。",
}

zhonghui_lua = sgs.General(extension, "zhonghui_lua", "wei")

Quanji_trs=sgs.CreateTriggerSkill
{
	name="quanji_trs",
	frequency = sgs.Skill_Frequent,
	events={sgs.Damaged},
	priority = -1,
	--view_as_skill=view_as_skill,
	
	on_trigger=function(self,event,zhonghui,data)
		local room = zhonghui:getRoom()
		local damage = data:toDamage()
		local x = damage.damage
		for i=1, x, 1 do
			if not zhonghui:askForSkillInvoke(self:objectName()) then return end
			
			room:playSkillEffect(self:objectName())
			
			zhonghui:drawCards(1, false)
			if not zhonghui:isKongcheng() then
				local card_id = room:askForCardChosen(zhonghui, zhonghui, "h", self:objectName())
				zhonghui:addToPile("powers", card_id)
			end
		end
	end,
	
	-- can_trigger=function(self,target)
		-- return true
	-- end,
}

Quanji_discard=sgs.CreateTriggerSkill
{
	name="#quanji_discard",
	events={sgs.PhaseChange},
	
	on_trigger=function(self,event,zhonghui,data)
		if zhonghui:getPhase() ~= sgs.Player_Discard then return end
		local num = zhonghui:getHandcardNum() - zhonghui:getMaxCards() - zhonghui:getPile("powers"):length()
		if num <= 0 then return true end
		local room = zhonghui:getRoom()
		room:askForDiscard(zhonghui,"game_rule",num,false,false)
		return true
	end,
}

Zili_wake=sgs.CreateTriggerSkill
{
	name="zili_wake",
	frequency = sgs.Skill_Wake,
	events={sgs.PhaseChange},
	
	on_trigger=function(self,event,zhonghui,data)
		local room = zhonghui:getRoom()
		local log= sgs.LogMessage()
		log.type = "#ziliwake"
		log.from = zhonghui
		log.arg  = tonumber(zhonghui:getPile("powers"):length())
		log.arg2 = self:objectName()
		room:sendLog(log)
		
		room:playSkillEffect(self:objectName())
		
		room:loseMaxHp(zhonghui)
		
		if zhonghui:isWounded() then
			if room:askForChoice(zhonghui, self:objectName(), "recover+draw") == "recover" then
				local recover = sgs.RecoverStruct()
				recover.who = zhonghui;
				room:recover(zhonghui, recover)
			else
				room:drawCards(zhonghui, 2)
			end
		else
			room:drawCards(zhonghui, 2)
		end
		
		room:setPlayerMark(zhonghui, "zili", 1)
		room:acquireSkill(zhonghui, "paiyi_vss")
		
		return false
	end,
	
	can_trigger=function(self,target)
		return target:hasSkill(self:objectName()) and target:isAlive()
		and target:getMark("zili") == 0
        and target:getPile("powers"):length() >= 3
        and target:getPhase() == sgs.Player_Start
	end,
}

PaiyiCard=sgs.CreateSkillCard
{
	name="PaiyiCard",
	once = true,
	filter = function(self, targets, to_select, player)
		if #targets > 0 then return false end	
		return true		
	end,

	on_use = function(self, room, zhonghui, targets)
		local target = targets[1]
		local powers = zhonghui:getPile("powers")
		if powers:isEmpty() then return end
		
		local card_id
		if powers:length() == 1 then
			card_id = powers:first()
		else
			room:fillAG(powers, zhonghui)
			card_id = room:askForAG(zhonghui, powers, true, "paiyi_vss")
			zhonghui:invoke("clearAG")
			
			if card_id == -1 then return end
		end
		
		room:throwCard(card_id)
		room:drawCards(target, 2)
		if target:getHandcardNum() > zhonghui:getHandcardNum() then
			local damage = sgs.DamageStruct()
			damage.card = nil
			damage.from = zhonghui
			damage.to = target
			
			room:damage(damage)
		end
	end,
}

Paiyi_vss=sgs.CreateViewAsSkill
{
	name="paiyi_vss",
	n=0,
	
	view_as = function(self, cards)
		return PaiyiCard:clone()
	end,
	
	enabled_at_play=function(self, player)
		return not player:getPile("powers"):isEmpty() and not player:hasUsed("#PaiyiCard")
	end,
}

zhonghui_lua:addSkill(Quanji_trs)
zhonghui_lua:addSkill(Quanji_discard)
zhonghui_lua:addSkill(Zili_wake)

local skills = sgs.SkillList()
if not sgs.Sanguosha:getSkill("paiyi_vss") then skills:append(Paiyi_vss) end
sgs.Sanguosha:addSkills(skills)

sgs.LoadTranslationTable{
	["yjcmzhonghui"] = "一将成名·钟会",
	
	["#zhonghui_lua"] = "桀骜的野心家",
	["zhonghui_lua"] = "钟会",
	["quanji_trs"] = "权计",
	[":quanji_trs"] = "每当你受到1点伤害后，你可以摸一张牌，然后将一张手牌置于你的武将牌上，称为“权”；每有一张“权”，你的手牌上限便+1。",
	["zili_wake"] = "自立",
	[":zili_wake"] = "<b>觉醒技</b>，回合开始阶段开始时，若“权”的数量达到3或更多，你须减1点体力上限，然后回复1点体力或摸两张牌，并获得技能“排异”（出牌阶段，你可以将一张“权”置入弃牌堆，令一名角色摸两张牌，然后若该角色的手牌数大于你的手牌数，你对其造成1点伤害。每阶段限一次）。",
	["#ziliwake"] = "%from 的权的数量达到 %arg 个，触发觉醒技【%arg2】",
	["zili_wake:draw"] = "摸2张牌",
	["zili_wake:recover"] = "回复1点体力",
	["paiyi_vss"] = "排异",
	["PaiyiCard"] = "排异",
	[":paiyi_vss"] = "出牌阶段，你可以将一张“权”置入弃牌堆，令一名角色摸两张牌，然后若该角色的手牌数大于你的手牌数，你对其造成1点伤害。",
	["powers"] = "权",
	
	["designer:zhonghui_lua"] = "LUA:高达一号|韩旭",
	["~zhonghui_lua"] = "",
	["illustrator:zhonghui_lua"] = "雪君S",
}