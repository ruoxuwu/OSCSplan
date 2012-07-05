-- Register of OSCS official packages
-- NOTICE: DO NOT CHANGE THIS FILE IF YOU DO NOT WANT CONFLICTS!
--QSanguosha 
--YK YOKA BG 桌游志 MS 神杀官方 TS 测试
--QSanguoshaBeautified(Zhanliguigongzi)		ZB 战栗贵公子美化版
--QSanguoshaBeautified(Alcatraz)				AB Alcatraz美化版
--QSanguoshaHeroSlash(Zhanliguigongzi)			ZH 战栗贵公子英雄杀
--QSanguoshaIndex(Donle)						DI Donle魔禁杀
--QSanguoshaTouhou(Hypercross)					HT Hypercross东方杀
--QSanguoshaOmegaEra(Ibicdlcod)				OE ibicdlcod欧米茄计划
--QSanguoshaColorful(Ubun)						UC 宇文天启缤纷太阳神
--QSanguoshaNiubiSlash(Ubun)					UN 宇文天启牛逼神装
--QSanguoshaMingshen(Donle)					DM Donle冥神杀
--QSanguoshaYin(Hypercross)					HY Hypercross阴包
--QSanguoshaSeintoSlash(Ubun)					US 宇文天启冥神杀StarmK23
--QSanguoshaSeintoViva(Ubun)					UV 宇文天启冥神杀游神Viva
--太阳神大乱斗,roxiel等等尚未注册
--编号系统：16^4 对于卡牌：倒数第二位♠~A ♥~B ♦~C ♣~D 最后一位A~1 10~A J~B Q~C K~D
--卡牌：0~9+A~F+ABCD(♠♥♦♣)+2~E(A,2~10,JQK)
--武将：0~9+0~9+0~9+0~9
--剧情：A~F+0~9+0~F+0~F（前两位剧情代号,后两位00为剧情本身,其他空位留作剧情相关卡牌武将）
return{

--Cards

["YKStdCard"] = "YOKA标准版卡牌",
--104张,0A♠A-0B♣K
["YKExCard"] = "YOKA标准EX卡牌",
--4张,  0C♠2♥Q♦Q♣2
["YKRLMan"] = "YOKA神话再临军争",
--52张, 0D♠A-0D♣K
["BGSPCard"] = "桌游志SP卡牌",
--1张,  0C♦QEXA(与0C♦Q公用编号,不可同时存在)
["YKNostalgia"] = "YOKA怀旧卡牌",
--1张,  0C♦QEXB(同上)
["MSJoy"] = "神杀欢乐卡牌",
--4张,  1A♠10♥8♦K♣A
["MSJoyEquip"] = "神杀欢乐装备",
--3张,  1A♥A♦5♣9
["MSJoyDisa"] = "神杀欢乐天灾",
--5张,  1A♠A♠4♥K♥7♣10

["ZHCard"] = "英雄杀卡牌",
--104张,7A♠A-7B♣K
["ZHCardEx"] = "英雄杀Ex卡牌",
--4张,  7C♠2♥Q♦Q♣2
["DICard"] = "魔禁杀卡牌",
--28张, 6A-6B
--♠A,2,2,3,3,7,K,♥A,2,2,7,9,Q,K,♦A,3,7,9,9,Q,K
["HTCard"] = "东方杀卡牌",
--108张,5A♠A-5B♣K+5C♠2♥Q♦Q♣2(作者误把一张♥Q当做♦Q)
["UCJoyCard"] = "缤纷太阳神小笼包",
--7张,1B♠2,9♥5,K♦7♣3,J（为啥跟神杀都有重复？）
["UNNBEquip"] = "牛逼神装",
--84张,2A~2C
--♠2,2,3,3,4,4,4,5,6,6,7,8,8,9,10,10,J,J,Q,Q,K,A
--♥2,3,4,4,5,5,6,7,8,8,9,10,10,J,J,Q,Q,Q,K,A,A,A
--♦2,2,3,4,5,5,6,7,8,9,9,10,J,J,Q,Q,K,K,K,A
--♣2,2,3,3,4,5,6,7,7,8,9,9,10,J,J,J,Q,Q,K

--合509

--Generals

["YKStdGeneral"] = "YOKA标准版武将",
--25将 蜀7魏7吴8群3,0101~0107 0201~0207 0301~0308 0401~0403
["YKRLWind"] = "YOKA神话再临风包",
["YKRLFire"] = "YOKA神话再临火包",
["YKRLThicket"] = "YOKA神话再临林包",
["YKRLMountain"] = "YOKA神话再临山包",
--四包合32将 蜀8魏8吴7群9,0108~0115 0208~0215 0309~0315 0404~0412
--另左慈（女）9409
["YKRLGod"] = "YOKA神话再临神武将",
--8神,0901~0908
["BGSP"] = "桌游志SP武将",
--9将（除SP庞德）,蜀1魏3群3神2 0801~0809
["YKYJCM"] = "YOKA一将成名",
--11将 蜀3魏3吴3群2 2201~2210,2211（张春华占用）
["MSYitian"] = "神杀倚天武将包",
--17将（33魏武帝未出）蜀1魏8（包括夏侯涓）吴2群4神2
--3300（33魏武帝占用）,3301~3316
--另陆伯言（女）9307
["MSYitianNew"] = "神杀新倚天武将包", --已坑
--暂时不明
["MSWisdom"] = "神杀智武将包",
--8将 魏1蜀2吴2群3 2501~2508
["TSTest"] = "仅供测试",
--4将 蜀1吴1神2 9104,9301,9901,9902

["OETanA"] = "欧米茄坛包A",
["OETanB"] = "欧米茄坛包B",
["OETanC"] = "欧米茄坛包C",
["OETanD"] = "欧米茄坛包D",
["OETanE"] = "欧米茄坛包E",
["OETanF"] = "欧米茄坛包F",
["OETanG"] = "欧米茄坛包G",
["OETanH"] = "欧米茄坛包H",
["OETanI"] = "欧米茄坛包I",
["OETanS"] = "欧米茄坛包SP",
--截至62月6日11将,但计划全武将远多于此,占用31,32号段

["ABHuanjin"] = "Alcatraz黄巾之乱",
--10将,黄巾10,包括黄巾-张角 3510~3519
["ZBYin"] = "战栗贵公子阴包",
--8将,蜀3魏2群3,3521-3528
["ZBLightning"] = "战栗贵公子雷包",
--8将,蜀1魏4吴3,3531-3538

["ZHHeros"] = "英雄杀标准版",
--33将,11君12臣10民,7001-7033
["ZHCyan"] = "英雄杀青龙之章",
--10将,3君3臣4民,7101-7110
["ZHWhite"] = "英雄杀白虎之章",
--24将,8君7臣9民,7201-7224
["ZHRed"] = "英雄杀朱雀之章",
--2将,1君1臣,7301-7302？

["DIGeneral"] = "魔禁杀武将",
--49将,11英国清教16学园都市11暗部组织11机构未明,6101~6111 6201~6216 6301~6311 6401~6411 
["DIGod"] = "魔禁杀神武将",
--3神 6901~6903

["HTGeneral"] = "东方杀武将",
--27将 地灵殿5011-5014 妖妖梦5021-5024 永夜抄5031-5034 红魔乡5041-5045 绯想天5051
--自机组5061-5064 风神录5071-5075

["UCRed"] = "缤纷太阳神朱雀",
--9将蜀3魏2吴2群2 3611-3618(南蛮王隐藏，9616)
["UCCyan"] = "缤纷太阳神青龙",
--8将蜀3（包括范疆张达）魏2吴1群2 3621-3628
["UCGreen"] = "缤纷太阳神绿？",
--未出
["UCJoyGenerals"] = "缤纷太阳神灌汤包",
--3神 3691-3693

["UNNewBiGeneral"] = "牛逼神将",
--9将  蜀2魏1吴2群2神2 3701-3709
["UNFangji"] = "方技传",
--4神 3901-3904

["DMViva"] = "冥神杀Donle",
--20将 圣12冥8 4101~4112 4201~4208 

["HYGeneral"] = "阴包Hypercross",
--7将,包括2211在内,占用34号段

["USSeinto"] = "冥神篇",
--12圣 4401~4412
["USGold"] = "黄金圣斗士",
--12圣 4501~4512
["USBronze"] = "青铜圣斗士",
--5青 4601~4605

["UVGeneral"] = "圣斗士星矢",
--12黄金 4301~4312

--合400

--Scenarios
["MSCouple"] = "神杀夫妻协战",
--B100
["ZHCouple"] = "英雄杀夫妻协战",
--C100
["MSFancheng"] = "神杀樊城之战",
--B200
["ZHJinke"] = "英雄杀荆轲刺秦",--真瞎,楚汉之争同。。。
--C200
["MSLesbian"] = "神杀红颜百合赛",
--B300
["ZHLesbian"] = "英雄杀红颜百合",
--C300
["MSZombie"] = "神杀僵尸模式",--僵尸,绝境,魔王同样可适用于英雄杀
--B400
["MSChuanqi"] = "神杀传奇模式",
--B500
["MSGuandu"] = "神杀官渡之战",
--B000
["ZHChuHan"] = "英雄杀楚汉之争",
--C000
["MSImpasse"] = "神杀绝境之战",
--B600
["MSBoss"] = "神杀魔王模式",
--B700
["MSSame"] = "神杀同将模式",
--F100
["YKHulao"] = "YOKA虎牢关模式",
--A300
["YKKOF"] = "YOKA2人KOF模式",
--A200
["YK33"] = "YOKA3v3模式",
--A100
["MSScene"] = "神杀场景模式",
--B800

["ZBChallenge"] = "闯关模式",--36将
--D000,D001~D036

["UNRunaway"] = "跑路模式",
--B900
}