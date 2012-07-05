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