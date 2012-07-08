-- 神孙尚香
module("extensions.luafemalegod", package.seeall)
extension = sgs.Package("femalegod")
				
luagodssx = sgs.General(extension, "luagodssx", "god", 3, false,false)

luagongshen=sgs.CreateViewAsSkill{

name="luagongshen",

n=1,

view_filter=function(self,selected,to_select)
return to_select:inherits("EquipCard")
end,

view_as=function(self, cards)

if #cards==1 then

local card = cards[1]

local d_card = sgs.Sanguosha:cloneCard("archery_attack",card:getSuit(),card:getNumber())

d_card:addSubcard(card:getId())

d_card:setSkillName(self:objectName())

return d_card

end

end,

enabled_at_play=function()

return true

end,

enabled_at_response=function()

return false

end,

}

luajingguox = sgs.CreateTriggerSkill
{
	name = "luajingguox",
	events = {sgs.Damaged},
	frequency = sgs.Skill_Compulsory, --锁定
    can_trigger = function(self, player)
		return true
	end,	
	on_trigger=function(self,event,player,data)
  local room=player:getRoom()
  local godssx = room:findPlayerBySkillName("luajingguox")
  if godssx == nil then return false end
  local damage=data:toDamage()
  local to = damage.to
  if godssx:getPhase() ~= sgs.Player_NotActive then return false end
  if (event == sgs.Damaged) and (damage.to:getGeneral():isMale()) and (damage.to:getEquips():length() > 0) then
   godssx:drawCards(1)
  end
 end,
} 

sgs.LoadTranslationTable{
    ["femalegod"] = "四女神",
    ["luagodssx"] = "神孙尚香",
	["luagongshen"] = "弓神",
	["luajingguox"] = "巾帼",
	[":luagongshen"] = "出牌阶段，你可以将你的任意装备牌当万箭齐发使用 。",
	[":luajingguox"] = "非自己回合，任一男性角色受到一点伤害 ，若该角色装备区内有牌 ，你立即摸一张牌。",
	["designer:luagodssx"] = "杀神附体"
}

luagodssx:addSkill(luagongshen)
luagodssx:addSkill(luajingguox)

luagodxqx = sgs.General(extension, "luagodxqx", "god", 3, false,false)
cangshancard = sgs.CreateSkillCard
{
	name = "cangshancard",	
	target_fixed = true,	
	will_throw = false,
on_use = function(self, room, source, targets)
        local room = source:getRoom()
		local fields = sgs.IntList()
		fields = source:getPile("shan")
		if fields:isEmpty() then return false end
		local card_id
		local choice=room:askForChoice(source, self:objectName(), "peach+god_salvation")
		if choice == "peach" then
		if fields:length() == 1 then
			card_id = fields:first()
		else
			room:fillAG(fields, source)
			card_id = room:askForAG(source,fields,true,"shants1")
			source:invoke("clearAG")
			if card_id == -1 then return false end
		end
		local card = sgs.Sanguosha:getCard(card_id)
		card = sgs.Sanguosha:cloneCard("peach", card:getSuit(), card:getNumber())
		card:setSkillName("luacangshanv")
		card:addSubcard(card_id)
		local use = sgs.CardUseStruct()
		use.card = card
		use.from = source
		use.to:append(source)
		room:useCard(use)
		source:loseMark("@shanx", 1)
		elseif choice == "god_salvation" then
		if fields:length() == 1 then
			card_id = fields:first()
		else
			room:fillAG(fields, source)
			card_id = room:askForAG(source,fields,true,"shants1")
			source:invoke("clearAG")
			if card_id == -1 then return false end
		end
		local card = sgs.Sanguosha:getCard(card_id)
		card = sgs.Sanguosha:cloneCard("god_salvation", card:getSuit(), card:getNumber())
		card:setSkillName("luacangshanv")
		card:addSubcard(card_id)
		local use = sgs.CardUseStruct()
		use.card = card
		use.from = source
		for _,p in sgs.qlist(room:getAlivePlayers()) do
		    use.to:append(p)
	    end
		room:useCard(use)
		source:loseMark("@shanx", 1)
		end
end,
}
luacangshanv=sgs.CreateViewAsSkill{

name="#luacangshanv",

n=0,

view_filter=function(self,selected,to_select)
return false
end,

view_as=function(self, cards)

return cangshancard:clone()

end,

enabled_at_play=function()

return true

end,

enabled_at_response=function()

return false

end,

}

luacangshan = sgs.CreateTriggerSkill{
 name="luacangshan",
 view_as_skill = luacangshanv,
 events={sgs.GameStart,sgs.Dying,sgs.DrawNCards,sgs.AskForPeaches},
 frequency = sgs.Skill_Frequency,
 can_trigger= function()
	return true 
end,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local luagxq=room:findPlayerBySkillName(self:objectName())
  if luagxq == nil then return false end
  if event == sgs.GameStart then
  if not player:hasSkill("luacangshan") then return false end
     player:drawCards(7)
	local idlist = player:handCards()
                    room:fillAG(idlist,player)					
                    while true do
                            local cd_id=room:askForAG(player,idlist,true,self:objectName())
							idlist:removeOne(cd_id)                           
                            if cd_id == -1 then break end                           							
			                player:addToPile("shan", cd_id, false)
                           	if idlist:length() == 4 then break end						
                    end
		player:invoke("clearAG")
		   for _,id in sgs.qlist(idlist) do
		          local fields = sgs.IntList()
		          fields = player:getPile("shan")
		          local y=fields:length()
				  if y<3 then
                  player:addToPile("shan", id, false)
		          end
		   end
    player:gainMark("@shanx",3)
    local kingdomx = room:askForKingdom(player)
	local data=sgs.QVariant(kingdomx)
    room:setPlayerProperty(player, "kingdom", data)
	return true
end
   if event==sgs.Dying then
	    local dying=data:toDying()
		local fields = sgs.IntList()
		fields = luagxq:getPile("shan")
		if fields:isEmpty() then return false end
		if dying.who:getHp()>0 then return true end
		if not player:hasSkill("luacangshan") then return false end
        if not room:askForSkillInvoke(luagxq,"luacangshan") then return false end
	      if fields:length() == 1 then
			card_id = fields:first()
			local cardx = sgs.Sanguosha:getCard(card_id)
		    room:moveCardTo(cardx,nil,sgs.Player_DiscardedPile,true)
			local use=sgs.CardUseStruct()
		local card=sgs.Sanguosha:cloneCard("peach",cardx:getSuit(),cardx:getNumber()) 
		card:addSubcard(cardx:getEffectiveId())
        card:setSkillName("luacangshan")
        use.card = card
        use.from = dying.who
        use.to:append(dying.who)
        room:useCard(use)
		luagxq:loseMark("@shanx", 1)
		  else
		    while (luagxq:getMark("csx")) < 1 do
			room:fillAG(fields, luagxq)
			card_id = room:askForAG(luagxq,fields,true,"luacangshan")
			luagxq:invoke("clearAG")
			 if card_id == -1 then break end
			  fields:removeOne(card_id)
			  cardx = sgs.Sanguosha:getCard(card_id)			 
			  room:moveCardTo(cardx,nil,sgs.Player_DiscardedPile,true)
              luagxq:addMark("csx")			  
		   end
		   luagxq:setMark("csx",0)
		   local use=sgs.CardUseStruct()
		      local card=sgs.Sanguosha:cloneCard("peach",cardx:getSuit(),cardx:getNumber()) 
		      card:addSubcard(cardx:getEffectiveId())
              card:setSkillName("luacangshan")
              use.card = card
              use.from = dying.who
              use.to:append(dying.who)
              room:useCard(use)	
              luagxq:loseMark("@shanx", 1)			  
		 end	 
	end
	 if event==sgs.AskForPeaches then
	    local dying=data:toDying()
		local fields = sgs.IntList()
		fields = luagxq:getPile("shan")
		if fields:isEmpty() then return false end
		if dying.who:getHp()>0 then return true end
		if not player:hasSkill("luacangshan") then return false end
        if not room:askForSkillInvoke(luagxq,"luacangshan") then return false end
	      if fields:length() == 1 then
			card_id = fields:first()
			local cardx = sgs.Sanguosha:getCard(card_id)
		    room:moveCardTo(cardx,nil,sgs.Player_DiscardedPile,true)
			local use=sgs.CardUseStruct()
		local card=sgs.Sanguosha:cloneCard("peach",cardx:getSuit(),cardx:getNumber()) 
		card:addSubcard(cardx:getEffectiveId())
        card:setSkillName("luacangshan")
        use.card = card
        use.from = dying.who
        use.to:append(dying.who)
        room:useCard(use)
		luagxq:loseMark("@shanx", 1)
		  else
		    while (luagxq:getMark("csx")) < 1 do
			room:fillAG(fields, luagxq)
			card_id = room:askForAG(luagxq,fields,true,"luacangshan")
			luagxq:invoke("clearAG")
			 if card_id == -1 then break end
			  fields:removeOne(card_id)
			  cardx = sgs.Sanguosha:getCard(card_id)			 
			  room:moveCardTo(cardx,nil,sgs.Player_DiscardedPile,true)
              luagxq:addMark("csx")			  
		   end
		   luagxq:setMark("csx",0)
		   local use=sgs.CardUseStruct()
		      local card=sgs.Sanguosha:cloneCard("peach",cardx:getSuit(),cardx:getNumber()) 
		      card:addSubcard(cardx:getEffectiveId())
              card:setSkillName("luacangshan")
              use.card = card
              use.from = dying.who
              use.to:append(dying.who)
              room:useCard(use)
			luagxq:loseMark("@shanx", 1)  
		 end
	end
   if event==sgs.Dying then
   local dying=data:toDying()
   if dying.damage.to:getHp()>0 then return true end
   end
   if event==sgs.AskForPeaches then
   local dying=data:toDying()
   if dying.damage.to:getHp()>0 then return true end
   end
end
 } 

luaqunwu = sgs.CreateTriggerSkill{
 name="luaqunwu",
 events={sgs.CardEffected},
 frequency = sgs.Skill_Compulsory,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local effect = data:toCardEffect()
  local card = effect.card
if event == sgs.CardEffected and effect.multiple and card:inherits("TrickCard") then
   if effect.to:hasSkill("luaqunwu") then
      return true
	end
end
end
}

luahuimou = sgs.CreateTriggerSkill{
 name="luahuimou",
 events={sgs.CardEffected},
 frequency = sgs.Skill_Frequency,
 can_trigger= function()
	return true 
end,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local luagxqx=room:findPlayerBySkillName(self:objectName())
  if luagxqx == nil then return false end
  local effect = data:toCardEffect()
  local card = effect.card
if event == sgs.CardEffected and effect.multiple and card:inherits("TrickCard") then
    if effect.to:hasSkill("luahuimou") then return false end
	if luagxqx:isKongcheng() then return false end
	 if not room:askForSkillInvoke(luagxqx,"luahuimou") then return false end	 
	 room:askForDiscard(luagxqx, "luaqunwu", 1, false,false)
	 return true
end
end
}

luafenshang = sgs.CreateTriggerSkill{
 name="luafenshang",
 events={sgs.Damaged,sgs.DrawNCards},
 frequency = sgs.Skill_Frequency,
 can_trigger = function(self, player)
		return true
end,
 on_trigger=function(self,event,player,data)
  local room = player:getRoom()
  local damage = data:toDamage()
  local card = damage.card
  if event == sgs.DrawNCards and  player:getMark("@fenshangx")>0 then
	 local x = player:getMark("@fenshangx")
     data:setValue(data:toInt()+x)
	 player:loseMark("@fenshangx", x)
  end

  if event == sgs.Damaged and damage.to:hasSkill("luafenshang") then
    if not room:askForSkillInvoke(damage.to,"luafenshang") then return false end
	 for var = 1, damage.damage, 1 do
	  local targets = room:getAlivePlayers()
	  local target = room:askForPlayerChosen(damage.to, targets, "@luafenshangts")
	  target:gainMark("@fenshangx",2)
	end
  end
end,
} 	 
luagodxqx:addSkill(luacangshanv)
luagodxqx:addSkill(luacangshan)
luagodxqx:addSkill(luaqunwu)
luagodxqx:addSkill(luahuimou)
luagodxqx:addSkill(luafenshang)   
sgs.LoadTranslationTable{
    ["luagodxqx"] = "神小乔",
	["luacangshanv"] = "藏扇",
	["luacangshan"] = "藏扇",
	["cangshancard"] = "藏扇",	
	["luaqunwu"] = "裙舞",
	["luahuimou"] = "回眸",
	["luafenshang"] = "粉裳",
	["@fenshangx"] = "裳",
	["@luafenshangts"] = "你每受到一点伤害可指定一名角色，在他的下个摸牌阶段可多模两张牌。",
	["@shanx"] = "扇",
	["shan"] = "扇",
	["peach"] = "桃",
	["god_salvation"] = "桃园结义",
	[":luacangshan"] = "游戏开始时，共发你7张牌，你可以选择3张面朝下置于一旁，称之为【扇】， 你可以把【扇】当【桃】或【桃园结义】使用或打出，其余的牌收为手牌。", 
	[":luaqunwu"] = " 锁定技，当一个锦囊指定了多个目标时，该锦囊对你无效。",
	[":luahuimou"] = "当一个锦囊指定了多个目标时，你可以在该锦囊对任意目标生效前弃掉一张手牌，使该锦囊对其无效。",
	[":luafenshang"] = "你每受到一点伤害可指定一名角色，在他的下个摸牌阶段可多模两张牌。",
	["designer:luagodxqx"] = "杀神附体"
}
shendiaochan = sgs.General(extension, "shendiaochan", "god", 3, false)

jiusecard = sgs.CreateSkillCard
{
	name = "jiusecard",
	
	filter = function(self, targets, to_select)
		if #targets == 0 then
			return to_select:getGeneral():isMale()
		end
		if #targets == 1 then
			return targets[1]:inMyAttackRange(to_select)
		end
	end,
	
	on_use = function(self, room, source, targets)
		room:throwCard(self)
		local from = targets[1]
		local to = targets[2]
		local slash = sgs.Sanguosha:getCard(self:getSubcards():first())
		room:setPlayerFlag(to, "jiuse")
		room:cardEffect(slash, from, to)
	end,
}

jiusevs = sgs.CreateViewAsSkill
{
	name = "jiusevs",
	n = 1,
	
	view_filter = function(self, selected, to_select)
		return to_select:inherits("Slash") and not to_select:isEquipped()
	end,
	
	view_as = function(self, cards)
		if #cards ~= 1 then return nil end
		local acard = jiusecard:clone()
		acard:setSkillName("jiuse")
		acard:addSubcard(cards[1])
		return acard
	end,
	
	enabled_at_play = function(self, player)
		return not player:hasUsed("#jiusecard")
	end,
}

jiuse = sgs.CreateTriggerSkill
{
	name = "jiuse",
	events = {sgs.SlashHit, sgs.CardFinished},
	view_as_skill = jiusevs,
	
	can_trigger = function(self, player)
		return player:getRoom():findPlayerBySkillName(self:objectName())
	end,
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.SlashHit then
			local effect = data:toSlashEffect()
			if effect.to:hasFlag("jiuse") then
				room:setPlayerFlag(effect.to, "-jiuse")
				local damage = sgs.DamageStruct()
				damage.card = effect.card
				damage.from = effect.from
				damage.to = effect.to
				damage.damage = 2
				damage.nature = effect.nature
				room:damage(damage)
				return true
			end
		elseif event == sgs.CardFinished then
			local use = data:toCardUse()
			for _,p in sgs.qlist(room:getAllPlayers()) do
				if p:hasFlag("jiuse") then
					room:setPlayerFlag(p, "-jiuse")
				end
			end
		end
	end,			
}	

manwucards = {}

manwu = sgs.CreateTriggerSkill
{
	name = "manwu",
	events = {sgs.CardFinished, sgs.PhaseChange},
	
	can_trigger = function(self, player)
		return player:getRoom():findPlayerBySkillName(self:objectName())
	end,
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local skillowner = room:findPlayerBySkillName(self:objectName())
		if not skillowner then return false end
		if event == sgs.PhaseChange then
			if skillowner:getPhase() == sgs.Player_Finish then
				if #manwucards > 0 then
					for _, id in ipairs(manwucards) do
						if room:getCardPlace(id) ~= sgs.Player_DiscardedPile then
							local card = sgs.Sanguosha:getCard(id)
							room:throwCard(card)
							manwucards:removeOne(id)
						end
					end
				end
			elseif skillowner:getPhase() == sgs.Player_Start then
				if skillowner:getPile("manwu"):length() > 0 then
					manwucards = sgs.QList2Table(skillowner:getPile("manwu"))
					for _, id in sgs.qlist(skillowner:getPile("manwu")) do
						local card = sgs.Sanguosha:getCard(id)
						room:moveCardTo(card, skillowner, sgs.Player_Hand, true)
					end
				end
			end
		end
		if event == sgs.CardFinished then
			local current = room:getCurrent()
			if current:hasFlag("manwu") then return false end
			local use = data:toCardUse()
			if not use.from:getGeneral():isMale() or use.from:objectName() == skillowner:objectName() then return false end
			if room:getCardPlace(use.card:getEffectiveId()) ~= sgs.Player_DiscardedPile then return false end
			if not skillowner:askForSkillInvoke(self:objectName(), data) then return false end
			if not use.card:isVirtualCard() then
				skillowner:addToPile("manwu", use.card:getEffectiveId(), true)
			else
				local ids = use.card:getSubcards()
				room:fillAG(ids, skillowner)
				local id = room:askForAG(skillowner, ids, false, self:objectName())
				skillowner:invoke("clearAG")
				skillowner:addToPile("manwu", id, true)
			end
			current:setFlags("manwu")
		end
	end,
}

meihuo = sgs.CreateTriggerSkill
{
	name = "meihuo",
	events = {sgs.CardEffected, sgs.CardFinished},
	frequency = sgs.Skill_Compulsory,
	
	can_trigger = function(self, player)
		return player:getRoom():findPlayerBySkillName(self:objectName())
	end,
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local skillowner = room:findPlayerBySkillName(self:objectName())
		if not skillowner then return false end
		if event == sgs.CardEffected then
			local effect = data:toCardEffect()
			if not effect.card:inherits("Slash") or not effect.from:getGeneral():isMale() or effect.to:objectName() ~= skillowner:objectName() then return false end
			effect.from:getGeneral():setGender(sgs.General_Female)
			local value = sgs.QVariant()
			value:setValue(effect.from)
			room:setTag("meihuoTarget", value)
		elseif event == sgs.CardFinished then
			local target = room:getTag("meihuoTarget"):toPlayer()
			if target then
				target:getGeneral():setGender(sgs.General_Male)
			end
		end
	end,
}

shenyou = sgs.CreateTriggerSkill
{
	name = "shenyou",
	events = {sgs.Predamage, sgs.Predamaged},
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local shenlubu = room:findPlayer("shenlubu")
		if not shenlubu then return false end
		local damage = data:toDamage()
		if event == sgs.Predamage then
			if shenlubu:getMark("@wrath") > 0 then
				shenlubu:loseMark("@wrath", math.min(shenlubu:getMark("@wrath"), damage.damage))
			end
		elseif event == sgs.Predamaged then
			shenlubu:gainMark("@wrath", damage.damage)
		end
	end,
}

shendiaochan:addSkill(jiuse)
shendiaochan:addSkill(manwu)
shendiaochan:addSkill(meihuo)
shendiaochan:addSkill(shenyou)

sgs.LoadTranslationTable{
	["shendiaochan"] = "神貂蝉",
	["jiuse"] = "酒色",
	["jiusecard"] = "酒色",
	[":jiuse"] = "出牌阶段，你可以弃置一张【杀】并指定任一男性角色攻击范围内的一名角色，视为该男性角色对其使用了该【杀】若该【杀】命中，则造成2点伤害。每阶段限一次。",
	["manwu"] = "曼舞",
	[":manwu"] = "其他男性角色的回合内，你可获得任意一名男性角色使用过并结算完时进入弃牌堆的一张牌，将该牌置于自己面前，必须在自己下一个回合内使用，否则弃置该牌。每回合限一次。",
	["shenyou"] = "神佑",
	[":shenyou"] = "<b>锁定技，</b>你每受到或造成1点伤害，神吕布获得或失去一枚暴怒标记。",
	["meihuo"] = "魅惑",
	[":meihuo"] = "<b>锁定技，</b>当你成为【杀】的目标时，杀的来源始终视为女性。",
	["designer:shendiaochan"] = "杀神附体"
}

