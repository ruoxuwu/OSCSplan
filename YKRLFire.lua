--SANGUOSHA EXTENSION-RETURN OF LEGEND--FIRE--
--Design: YOKA (2011)
--Code: 【群】皇叔
--Version：16.12 (After Taqing 16)
--Last Update：July 5 2012 23:50 UTC+8

module("extensions.YKRLFire", package.seeall)

extension = sgs.Package("YKRLFire")

--0111 卧龙
luahuoji=sgs.CreateViewAsSkill
{--火计 by 【群】皇叔
	name="luahuoji",
	n=1,
	view_filter=function(self, selected, to_select)
		return to_select:isRed() and not to_select:isEquipped()
 	end,
	view_as=function(self, cards)
		if #cards==0 then return nil end
		if #cards==1 then         
			local card = cards[1]
			local hj_card=sgs.Sanguosha:cloneCard("fire_attack",card:getSuit(),card:getNumber()) 
			hj_card:addSubcard(card:getId())
			hj_card:setSkillName(self:objectName())
	        return hj_card
        end
 	end,
 	enabled_at_play=function() 
        return true
 	end,
	enabled_at_response=function(self,player,pattern)
		return false
	end,
}

luabazhen = sgs.CreateTriggerSkill
{--八阵 by 【群】皇叔
	name = "luabazhen",
	frequency = sgs.Skill_Compulsory,
	events={sgs.CardAsked},
	can_trigger=function(self,player)
		return not player:getArmor() and player:getMark("qinggang")==0 and player:getMark("wuqian") == 0
	end,
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		if(data:toString() ~= "jink") then return false end
		if(room:askForSkillInvoke(player, self:objectName())) then 
			local judge=sgs.JudgeStruct()
			judge.pattern=sgs.QRegExp("(.*):(heart|diamond):(.*)")
			judge.good=true
			judge.reason=self:objectName()
			judge.who=player
			room:judge(judge)
			if (judge:isGood()) then
				local jink_card = sgs.Sanguosha:cloneCard ("jink",sgs.Card_NoSuit,0)
				jink_card:setSkillName(self:objectName())
				room:provide(jink_card)
				room:setEmotion(player, "good")
				return true
			else room:setEmotion(player, "bad")
			end
		end
	end,
}

--0110 庞统
lualianhuan=sgs.CreateViewAsSkill
{--连环 by 【群】皇叔
	name="lualianhuan",
	n=1,
	view_filter=function(self, selected, to_select)
		return to_select:getSuit() == sgs.Card_Club and not to_select:isEquipped()
	end,
	view_as=function(self, cards)
		if #cards==0 then return nil end
		if #cards==1 then         
			local card = cards[1]
			local lh_card=sgs.Sanguosha:cloneCard("iron_chain",card:getSuit(),card:getNumber()) 
			lh_card:addSubcard(card:getId())
			lh_card:setSkillName(self:objectName())
			return lh_card
		end
 	end,
 	enabled_at_play=function() 
		return true
	end,
	enabled_at_response=function(self,player,pattern)
		return false
	end,
}


luaniepan=sgs.CreateTriggerSkill
{--涅槃 by 【群】皇叔
	name = "luaniepan",
	frequency = sgs.Skill_Limited,
	events = {sgs.AskForPeaches},
	can_trigger=function(self,player)
		return player:hasSkill("luaniepan") and (player:getMark("luaniepan")==0)
	end,
	on_trigger=function(self,event,player,data)
		local room = player:getRoom()
		local dying = sgs.DyingStruct()
		if ( room:askForSkillInvoke(player,self:objectName())) then 
			room:playSkillEffect(self:objectName())
			player:addMark("luaniepan")   
			local x = player:getMaxHP()
			if x > 3 then x = 3 end
			local data=sgs.QVariant(x)
			room:setPlayerProperty(player, "hp", data)
			player:throwAllCards()
			player:drawCards(3)
			if player:isChained() then 
				if (not dying.damage) or dying.damage.nature == sgs.DamageStruct_Normal then
					room:setPlayerProperty(player, "chained", sgs.QVariant(false))
				end
			end
			if (not player:faceUp()) then
				player:turnOver()
			end
			return true 
		end
	end,
}

--0111
luawolong = sgs.General(extension, "luawolong", "shu", 3)
luawolong:addSkill(luahuoji)
luawolong:addSkill(luabazhen)

--0110
luapangtong = sgs.General(extension, "luapangtong", "shu", 3)
luapangtong:addSkill(lualianhuan)
luapangtong:addSkill(luaniepan)

sgs.LoadTranslationTable{
	["#luaxunyu"] = "0213",
	["#luadianwei"] = "0212",
	["#luawolong"] = "0111",
	["#luapangtong"] = "0110",
	["#luataishici"] = "0312",
	["#luayuanshao"] = "0404",
	["#luashuangxiong"] = "0405",
	["#luapangde"] = "0408",
}