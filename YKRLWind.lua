--SANGUOSHA EXTENSION-RETURN OF LEGEND--WIND--
--Design: YOKA (2011)
--Code: ibicdlcod 【群】皇叔
--Version：14.11 (After Chibi 14)
--Last Update：Dec 7 2011 23:50 UTC+8

module("extensions.YKRLWind", package.seeall)

extension = sgs.Package("YKRLWind")

--0108 黄忠
lualiegong = sgs.CreateTriggerSkill
{--烈弓 by 【群】皇叔
	name = "lualiegong",
	--frequency = sgs.Skill_Frequent, 由于张角的关系，这句取消
	events = {sgs.SlashProceed},
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local effect = data:toSlashEffect()
		if (room:askForSkillInvoke(player, self:objectName()) ~= true) then return false end
		if (effect.to:getHandcardNum() >= player:getHp()) or (effect.to:getHandcardNum() <= player:getAttackRange()) then
			room:slashResult(effect, nil) 
			return true
		end
	end,
}

--0109 魏延
luakuanggu = sgs.CreateTriggerSkill
{--狂骨 by 【群】皇叔
	name = "luakuanggu",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.DamageDone, sgs.Damage},
	
	can_trigger = function()
		return true
	end,
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local damage = data:toDamage()
		if event == sgs.Damage and (damage.from:distanceTo(damage.to) < 2) and (damage.from:hasSkill(self:objectName())) then
			local recover = sgs.RecoverStruct()
			recover.who = damage.from
			recover.reason = self:objectName()
			recover.recover = damage.damage
			room:recover(damage.from,recover)
		end
	end,
}

--0208 夏侯渊
luashensu_viewas = sgs.CreateViewAsSkill
{--神速视为技 by ibicdlcod UNF
	name = "luashensu_viewas",
	n = 1,
	
	enabled_at_play = function()
		return false
	end,
	
	enabled_at_response = function(self, player, pattern)
		return string.find(pattern, "@@luashensu")
	end,
	
	view_filter = function()
	end
}

sgs.LoadTranslationTable{
	["#luahuangzhong"] = "0108",
	["#luaweiyan"] = "0109",
	["#luaxiahouyuan"] = "0208",
	["#luacaoren"] = "0211",
	["#luaxiaoqiao"] = "0311",
	["#luazhoutai"] = "0313",
	["#luazhangjiao"] = "0410",
	["#luayuji"] = "0411",
}