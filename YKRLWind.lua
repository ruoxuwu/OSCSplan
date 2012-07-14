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

-- 于吉 by 晴儿雨儿
-- 无懈可击接口
--module("extensions.aaskfornull",package.seeall)
--extension=sgs.Package("aaskfornull")
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
				if not t and (theplayer:getMark("cannull")==1 or theplayer:hasNullification()) then--手里有无懈或者拥有无懈技能
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
temp=sgs.General(extension,"temp","hide","0",true,true)
temp:addSkill(askfornull)

function askforLUAGuHuoQuery(room,player,oldcard,newcard,suit)
	local query=false
	for _,theplayer in sgs.qlist(room:getOtherPlayers(player)) do--循环，逐一检视所有角色
		room:setPlayerFlag(theplayer,"-LUAGuHuoQuery")
		if theplayer:getHp()>0 then
			if room:askForSkillInvoke(theplayer,"LUAGuHuoQuery") then
				room:setPlayerFlag(theplayer,"LUAGuHuoQuery")
				query=true
			end
		end
	end
	if not query then return false end
	local istrue=false
	if newcard==oldcard then istrue=true end
	for _,theplayer in sgs.qlist(room:getOtherPlayers(player)) do--循环，逐一检视所有角色
		if theplayer:hasFlag("LUAGuHuoQuery") then
			if istrue then
				room:loseHp(theplayer)
			else
				theplayer:drawCards(1)--摸牌
			end
		end
		room:setPlayerFlag(theplayer,"-LUAGuHuoQuery")
	end
	return not (suit==sgs.Card_Heart and istrue)
end
LUAGuHuoCard=sgs.CreateSkillCard{
	name="LUAGuHuoCard",
	target_fixed=true,--应该是不用选对象
	on_use=function(self,room,source,targets)
		local choices="cancel"
		local card=nil
		local n=0
		local new=false
		local choicetable={}
		for cardid=0,159,1 do
			card=nil
			card=sgs.Sanguosha:getCard(cardid)
			if card and (card:inherits("BasicCard") or card:isNDTrick()) and not(card:inherits("Nullification") or card:inherits("Jink") or (card:inherits("Peach") and source:getLostHp()==0)) then
				choicetable={}
				choicetable=choices:split("+");
				n=#choicetable
				new=true
				for var=1,n,1 do
					if choicetable[var]==card:objectName() then new=false end
				end
				if new then choices=choices.."+"..card:objectName() end
			end
		end
		local choice=room:askForChoice(source,"LUAGuHuo",choices)
		local marknum=0
		for cardid=0,159,1 do
			card=nil
			card=sgs.Sanguosha:getCard(cardid)
			if card and card:objectName()==choice then 
				marknum=cardid+1
				break
			end
		end
		room:setPlayerMark(source,"@LUAGuHuo",marknum)--把这张卡的id记录一下，以便在vs中恢复
		if marknum~=0 then
			room:acquireSkill(source,"LUAGuHuoFT")
			local carduse=sgs.CardUseStruct()
			room:activate(source,carduse)--让玩家自由出牌，对ai同样，记录在card_use里
			room:setPlayerMark(source,"@LUAGuHuo",0)
			room:detachSkillFromPlayer(source,"LUAGuHuoFT")
			if carduse:isValid() and not (carduse.card:inherits("IronChain") and carduse.to:isEmpty()) then
				local carda=sgs.Sanguosha:getCard(carduse.card:getSubcards():at(0))
				carduse.card=sgs.Sanguosha:cloneCard(choice,sgs.Card_NoSuit,0)
				carduse.card:setSkillName("LUAGuHuoForLog")
				room:useCard(carduse,false)
				carduse.card=sgs.Sanguosha:cloneCard(choice,carda:getSuit(),carda:getNumber())
				carduse.card:addSubcard(carda:getId())
				carduse.card:setSkillName("LUAGuHuo")
				local useless=askforLUAGuHuoQuery(room,source,choice,carda:objectName(),carda:getSuit())
				room:throwCard(carda)
				if not useless then room:useCard(carduse) end
			end
		end
	end,
}
LUAGuHuo=sgs.CreateViewAsSkill{
	name="LUAGuHuo",
	n=0,
	view_as=function()
		acard=LUAGuHuoCard:clone()--复制一张卡的效果
		return acard--返回一张新卡
	end,
}
LUAGuHuoFT=sgs.CreateFilterSkill{
	name="LUAGuHuoFT",
	view_filter=function(self,to_select)
		return not to_select:isEquipped()
	end,
	view_as=function(self,card)
		local mark=sgs.Self:getMark("@LUAGuHuo")
		if mark==0 then return card end
		local oldcard=sgs.Sanguosha:getCard(mark-1)
		local newcard=sgs.Sanguosha:cloneCard(oldcard:objectName(),card:getSuit(),card:getNumber())
		newcard:addSubcard(card:getId())
		newcard:setSkillName("LUAGuHuo")
		return newcard
	end,
}
LUAGuHuoTR=sgs.CreateTriggerSkill{
	name="#LUAGuHuoTR",
	events={sgs.CardAsked,sgs.CardUsed,sgs.AskForPeaches,sgs.GameStart},
	on_trigger=function(self,event,player,data)
		local room=player:getRoom()
		if event==sgs.GameStart then
			player:gainMark("cannull",1)--获得一枚标记，询问无懈时一定问你
			return false
		end
		if event==sgs.CardUsed then
			local use=data:toCardUse()
			return use.card:getSkillName()=="LUAGuHuoForLog"
		end
		local str=""
		if event==sgs.CardAsked then
			str=data:toString()
			if str=="slash" then str="slash+fire_slash+thunder_slash" end
		end
		local dying=nil
		if event==sgs.AskForPeaches then
			dying=data:toDying()
			if dying.who:getSeat()==player:getSeat() then
				str="peach+analeptic"
			else
				str="peach"
			end
		end
		if player:isKongcheng() or not room:askForSkillInvoke(player,"LUAGuHuo") then return false end
		local choice=""
		local choicetable={}
		choicetable=str:split("+");
		n=#choicetable
		if n==1 then choice=str else choice=room:askForChoice(player,"LUAGuHuo",str) end
		local canvs=0
		local card=nil
		for cardid=0,159,1 do
			card=nil
			card=sgs.Sanguosha:getCard(cardid)
			if card and card:objectName()==choice then 
				canvs=1
				break
			end
		end
		if canvs==0 then return false end
		if marknum~=0 then
			while true do
				local carda=room:askForCardShow(player,player,"LUAGuHuo")
				local carduse=sgs.CardUseStruct()
				carduse.card=sgs.Sanguosha:cloneCard(choice,sgs.Card_NoSuit,0)
				carduse.card:setSkillName("LUAGuHuoForLog")
				carduse.from=player
				room:useCard(carduse)
				local useless=askforLUAGuHuoQuery(room,player,choice,carda:objectName(),carda:getSuit())
				room:throwCard(carda)
				if not useless then
					local s=sgs.Sanguosha:cloneCard(choice,carda:getSuit(),carda:getNumber())
					s:addSubcard(carda:getId())
					s:setSkillName("LUAGuHuo")
					if event==sgs.CardAsked then room:provide(s) end
					if event==sgs.AskForPeaches then
						local recover=sgs.RecoverStruct()
						recover.recover=1
						recover.who=player
						room:recover(dying.who,recover)--回复
					end
					return false
				else
					if player:isKongcheng() or not room:askForSkillInvoke(player,"LUAGuHuo") then return false end
				end
			end
		end
	end,
}
LUAYuJi=sgs.General(extension,"LUAYuJi","qun","3",true)
LUAYuJi:addSkill(LUAGuHuo)
local skill=sgs.Sanguosha:getSkill("LUAGuHuoFT")
if not skill then
	local skillList=sgs.SkillList()
	skillList:append(LUAGuHuoFT)
	sgs.Sanguosha:addSkills(skillList)
end
LUAYuJi:addSkill(LUAGuHuoTR)
LUAYuJi:addSkill("#askfornull")
sgs.LoadTranslationTable{
	["luayuji"]="lua于吉by晴儿雨儿",
	["LUAYuJi"]="于吉",
	["designer:LUAYuJi"]="晴儿雨儿",
	["LUAGuHuo"]="蛊惑",
	["LUAGuHuoCard"]="蛊惑",
	["LUAGuHuoFT"]="蛊惑",
	["LUAGuHuoQuery"]="质疑",
	["LUAGuHuoForLog"]="蛊惑",
	[":LUAGuHuo"]="你可以说出任何一种基本牌或非延时类锦囊牌，并正面朝下使用或打出一张手牌。若无人质疑，则该牌按你所述之牌结算。若有人质疑则亮出验明；若为真，质疑者各失去1点体力；若为假，质疑者各摸1张牌。无论真假，弃置被质疑的牌。仅当被质疑的牌为红桃且为真时，该牌仍然可以进行结算。",
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