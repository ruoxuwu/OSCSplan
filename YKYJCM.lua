--SANGUOSHA YJCM Generals--
--Design: YOKA (2011)
--Code: 阴酆主人
--Version：16.12 (After Taqing 16)
--Last Update：July 5 2012 23:50 UTC+8

module("extensions.YKYJCM", package.seeall)

extension = sgs.Package("YKYJCM")

--2211 张春华 by 阴酆主人
zhangchunhua=sgs.Sanguosha:getGeneral("zhangchunhua")
if zhangchunhua~=nil then
	jhangchunhua=sgs.General(extension, "jhangchunhua", "wei","3",false,true)
else
	jhangchunhua=sgs.General(extension, "jhangchunhua", "wei","3",false,false)
end

shangshih=sgs.CreateTriggerSkill{
	name="shangshih",
	events={sgs.HpChanged,sgs.CardLost,sgs.CardGot,sgs.CardLostDone,sgs.CardGotDone, sgs.CardDrawnDone, sgs.CardDiscarded}, --sgs.PhaseChange},
	priority=1,
	frequency = sgs.Skill_Frequent,
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		local lostHp = player:getLostHp()
		local maxHp = player:getMaxHP()
		local HandcardNum = player:getHandcardNum()
		local CanInvoke = false

		if (event == sgs.CardLost) then 
			local move=data:toCardMove()
			if (move.from_place==sgs.Player_Hand) then
				player:setFlags("HandCardChanged")
			end
		end
		if (event == sgs.CardGot) then 
			local move=data:toCardMove()
			if (move.to_place==sgs.Player_Hand) then
				player:setFlags("HandCardChanged")
			end
		end
		
		if (event ~= sgs.CardLost and event ~= sgs.CardGot) then
			if(event == sgs.CardLostDone or event == sgs.CardGotDone) then
				if  player:hasFlag("HandCardChanged") then
					player:setFlags("-HandCardChanged")
				else
					return
				end
				if (event == sgs.CardLostDone and player:getPhase() == sgs.Player_Discard) or (event == sgs.CardGotDone and player:getPhase() ==sgs.Player_Draw) then
					return
				end
			end
			if (lostHp <= HandcardNum) or (lostHp >= maxHp) then return end
			if lostHp > maxHp then lostHp = maxHp end
			if not room:askForSkillInvoke(player,self:objectName()) then return end
			local log=sgs.LogMessage()
			log.type ="#InvokeSkill"
			room:playSkillEffect("shangshih")
			player:drawCards(lostHp-HandcardNum)
		end
	end,
}

jyuecing=sgs.CreateTriggerSkill{
	name="jyuecing",
	events={sgs.SlashHit,sgs.Predamage},
	priority=2,
	frequency=sgs.Skill_Compulsory,
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		local log=sgs.LogMessage()
		if(room:findPlayerBySkillName("huoshou") and event==sgs.Predamage) then--?D????ê×
			local damage=data:toDamage()
			if	(damage.card and damage.card:inherits("SavageAssault")) then
				return false
			end
		end
		log.type = "#TriggerSkill"
		log.from  = player
		log.arg = "jyuecing"
		room:sendLog(log)
		room:playSkillEffect("jyuecing")
		if(event==sgs.SlashHit)	then
			local slashEffect=data:toSlashEffect()
			if(slashEffect.drank) then
				room:loseHp(slashEffect.to,2)
			else
				room:loseHp(slashEffect.to,1)
			end
			return true
		elseif (event==sgs.Predamage) then 
			local damage=data:toDamage()
			room:loseHp(damage.to,damage.damage)
			return true
		end 
	end,
}

cioushih=sgs.CreateTriggerSkill{
	name="cioushih",
	events={sgs.GameStart},
	priority=0,
	frequency=sgs.Skill_Compulsory,
	on_trigger=function(self,event,player,data)
	local room=player:getRoom()
	room:transfigure(player,"jhangchunhua",true,true)
	end,
}

if zhangchunhua~=nil then
	zhangchunhua:addSkill(cioushih)
end
jhangchunhua:addSkill(jyuecing)
jhangchunhua:addSkill(shangshih)

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