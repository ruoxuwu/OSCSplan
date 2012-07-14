--SANGUOSHA EXTENSION-RETURN OF LEGEND--THICKET--
--Design: YOKA (2011)
--Code: 【群】皇叔
--Version：16.12 (After Taqing 16)
--Last Update：July 5 2012 23:50 UTC+8

module("extensions.YKRLThicket", package.seeall)

extension = sgs.Package("YKRLThicket")

--0114 孟获
luahuoshou=sgs.CreateTriggerSkill
{--祸首 by 【群】皇叔
	name="luahuoshou",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.Predamage,sgs.CardEffected},
	can_trigger=function(self,player)
		return true 
	end,
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		local target = room:findPlayerBySkillName(self:objectName())
		if event == sgs.CardEffected then 
			local effect = data:toCardEffect()
			if effect.card:inherits("SavageAssault") and effect.to:hasSkill(self:objectName()) then 
				return true 
			end
		end
		if event == sgs.Predamage then
			local damage = data:toDamage()
			if damage.card:inherits("SavageAssault") then
				damage.from = target
				data:setValue(damage)
				return false 
			end
		end
	end,
}


luazaiqi = sgs.CreateTriggerSkill
{--再起 by 【群】皇叔
	luazaiqi = sgs.CreateTriggerSkill{
	name = "luazaiqi",
	frequency = sgs.Skill_Frequent,
	events = {sgs.PhaseChange},
	can_trigger=function(self,target)
		return target:hasSkill(self:objectName()) and target:isWounded() 
	end,
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		if event == sgs.PhaseChange and player:getPhase()==sgs.Player_Draw then
			if ( room:askForSkillInvoke(player,self:objectName())) then 
				room:playSkillEffect(self:objectName())
				local x = player:getLostHp()
				for i=1,x do
					local card_Id = room:drawCard()
					local card = sgs.Sanguosha:getCard(card_Id)
					room:moveCardTo(card,nil,sgs.Player_Special,true)
					room:getThread():delay()
					if card:getSuit()== sgs.Card_Heart then
						local recover = data:toRecover()
						recover.card = card
						recover.who = player
						room:recover(player,recover)
						room:throwCard(card)
					else 
						room:obtainCard(player, card)
					end
				end
				return true	
			end
		end
	end,
}

--0111
luamenghuo = sgs.General(extension, "luamenghuo", "shu", 4)
luamenghuo:addSkill(luahuoshou)
luamenghuo:addSkill(luazaiqi)

-- 完杀by佚名
LUAWanSha=sgs.CreateTriggerSkill{
	name="LUAWanSha",
	events=sgs.AskForPeaches,
	frequency=sgs.Skill_Compulsory,
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		local current=room:getCurrent()
		if current:isAlive() and current:hasSkill("LUAWanSha") then
			local dying=data:toDying()
			local who=dying.who
			return not (player:getSeat()==current:getSeat() or player:getSeat()==who:getSeat())
		end
	end,
	can_trigger=function(self,player)
		return player and player:isAlive()
	end,
}

LUAJiaXu=sgs.General(extension,"LUAJiaXu","qun","3",true)
LUAJiaXu:addSkill(LUAWanSha)


sgs.LoadTranslationTable{
	["#luacaopi"] = "0214",
	["#luaxuhuang"] = "0210",
	["#luamenghuo"] = "0114",
	["#luazhurong"] = "0115",
	["#luasunjian"] = "0309",
	["#lualusu"] = "0314",
	["#luajiaxu"] = "0407",
	["#luadongzhuo"] = "0406",
}