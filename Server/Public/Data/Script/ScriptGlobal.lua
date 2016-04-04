--生活技能id 编号

	OR_OK								= 0		-- 成功,如果返回0即为成功,返回下面的其他值都为失败
	OR_ERROR							= -1	-- 未知错误
	OR_DIE								= -2	-- 你已死亡
	OR_INVALID_SKILL					= -3	-- 无效技能
	OR_TARGET_DIE						= -4	-- 目标已死亡
	OR_LACK_MANA						= -5	-- MANA不足
	OR_COOL_DOWNING						= -6	-- 冷确时间未到
	OR_NO_TARGET						= -7	-- 没有目标
	OR_INVALID_TARGET					= -8	-- 无效目标
	OR_OUT_RANGE						= -9	-- 超出射程
	OR_IN_RANGE							= -10	-- 距离太近
	OR_NO_PLATFORM						= -11	-- 没有操作平台
	OR_OUT_PLATFORM						= -12	-- 离操作平台太远
	OR_NO_TOOL							= -13	-- 没有操作工具
	OR_STUFF_LACK						= -14	-- 缺少材料
	OR_BAG_OUT_OF_SPACE					= -15	-- 背包缺少空间
	OR_WARNING							= -16	-- 理论上这些错误将被客户端过滤，所以如果出现，可能来自于一些外挂
	OR_BUSY								= -17	-- 正在做其它事情
	OR_MISSION_HAVE						= -18	-- 已经拥有该任务
	OR_MISSION_LIST_FULL				= -19	-- 任务记录已满
	OR_MISSION_NOT_FIND					= -20	-- 没找到该任务
	OR_EXP_LACK							= -21	-- 熟练度不够
	OR_CHAR_DO_NOT_KNOW_THIS_SKILL		= -22	-- 角色还不会这种技能
	OR_NO_SCRIPT						= -23	-- 目标角色无脚本
	OR_NOT_ENOUGH_HP					= -24	-- 没有足够的生命值
	OR_NOT_ENOUGH_RAGE					= -25	-- 没有足够的怒气值
	OR_NOT_ENOUGH_STRIKE_POINT			= -26	-- 没有足够的连击点
	OR_NOT_ENOUGH_ITEM					= -27	-- 没有足够的道具
	OR_NOT_ENOUGH_VIGOR					= -28	-- 没有足够的活力
	OR_NO_LEVEL							= -29 	-- 技能等级不够
	OR_CANNOT_UPGRADE					= -30	-- 宝石无法再升级
	OR_FAILURE							= -31	-- 操作失败
	OR_GEM_CONFLICT						= -32	-- 一件装备上不允许装备同类型的宝石
	OR_NEED_IN_FURY_STANCE				= -33	-- 需要在狂暴状态下使用
	OR_INVALID_TARGET_POS				= -34	-- 无效目标点
	OR_GEM_SLOT_LACK					= -35	-- 缺乏宝石插口
	OR_LIMIT_MOVE						= -36	-- 无法移动
	OR_LIMIT_USE_SKILL					= -37	-- 无法使用技能
	OR_INACTIVE_SKILL					= -38	-- 使用尚未激活的技能
	OR_TOO_MUCH_HP						= -39	-- HP大于限定数值
	OR_NEED_A_WEAPON					= -40	-- 需要一把武器
	OR_NEED_HIGH_LEVEL_XINFA			= -41	-- 心法等级不够
	OR_NEED_LEARN_SKILL_FIRST			= -42	-- 尚未学会此技能
	OR_NEED_MENPAI_FOR_LEVELUP			= -43	-- 你必须拜师进入一个门派才能继续升级
	OR_U_CANNT_DO_THIS_RIGHT_NOW		= -44 	-- 你现在无法这样做
	OR_ROBOT_TIMEOUT					= -45  -- 挂机时间超时
	OR_NEED_HAPPINESS					= -46  -- 你的宠物快乐度不足60，不能出战，需要驯养
	OR_NEED_HIGH_LEVEL					= -47	-- 你的等级不够
	OR_CANNOT_GETEXP					= -48	-- 你的宠物已无法等到经验
	OR_NEED_LIFE						= -49  -- 你的宠物寿命为0，无法再召唤，请为其增加寿命
	OR_EXP_FULL							= -50  -- 您的经验已经到达上限
	OR_TOO_MANY_TRAPS					= -51 	-- 无法设置更多的此类陷阱
	OR_PET_PLACARD_ISSUE_FAILED			= -52	-- 发布失败
	OR_PET_PLACARD_NOT_APPOINT_PET		= -53	-- 未指定宠物
	OR_PET_PLACARD_ONLY_CAN_ISSUE_ONE	= -54	-- 对不起，同时只能发布一只宠
	OR_PET_PLACARD_NEED_PET_TYPE		= -55	-- 对不起，你的宠好像不是宝宝哦
	OR_PET_PLACARD_NEED_PET_LEVEL		= -56	-- 对不起，你的宠级别还不够哦
	OR_PET_PLACARD_NEED_PET_HAPPINESS	= -57	-- 对不起，你的宠快乐值不够高
	OR_PET_PLACARD_NEED_PET_LIFE		= -58	-- 对不起，你的宠寿命不够
	OR_NEED_IN_STEALTH_MODE				= -59	-- 需要在隐身状态下使用
	OR_NOT_ENOUGH_ENERGY				= -60	-- 对不起，你的精力不足
	OR_CAN_NOT_MOVE_STALL_OPEN			= -61	-- 无法在摆摊中移动
	OR_NEED_IN_SHIELD_MODE				= -62	-- 需要在护体保护下
	OR_PET_DIE							= -63	-- 你的宠物已经死亡
	OR_PET_HADRECALL_NEEDHAPPINESS		= -64	-- 你的宠物快乐度不足60，已被收回
	OR_PET_HADRECALL_NEEDLIFE			= -65	-- 你的宠物寿命为0，已被收回
	OR_GEM_NOT_FIT_EQUIP				= -66	-- 这种宝石不能镶嵌在这种装备上

--使用StoreMap 返回类型
	USEITEM_SUCCESS			=	0
	USEITEM_CANNT_USE		=	1
	USEITEM_LEVEL_FAIL		=	2
	USEITEM_TYPE_FAIL		=	3
	USEITEM_SKILL_FAIL		=	4
	USEITEM_INVALID			=	5

--生活技能导师相关变量
ABILITY_TEACHER_SHOP = 11	--导师买工具商店
ABILITY_STUDY = 0			--学习技能
ABILITY_STUDY_OK = 2		--学习技能确认
ABILITY_STUDY_CANCEL = 3	--学习技能取消
ABILITY_DIALOG = {21,22,23,24,25}	--技能说明对话

--洛阳的种植标志，0 没人种  1还有一块庄稼未回收		2二块未回收  3三块未回收  4 四块未回收
--大理36个,洛阳36个,苏州36个，顺序是大理，洛阳，苏州
PLANTFLAG = {0,0,0,0,0,0,0,0,0,0,
			 0,0,0,0,0,0,0,0,0,0,
			 0,0,0,0,0,0,0,0,0,0,
			 0,0,0,0,0,0,
						 0,0,0,0,
			 0,0,0,0,0,0,0,0,0,0,
			 0,0,0,0,0,0,0,0,0,0,
			 0,0,0,0,0,0,0,0,0,0,
			 0,0,
				 0,0,0,0,0,0,0,0,
			 0,0,0,0,0,0,0,0,0,0,
			 0,0,0,0,0,0,0,0,0,0,
			 0,0,0,0,0,0,0,0}

--种植稻草人坐标
--大理36个,洛阳36个,苏州36个，顺序是大理，洛阳，苏州
PLANTNPC_ADDRESS ={{X=37,Z=87,Scene=2,X_MIN=35,X_MAX=41,Z_MIN=84,Z_MAX=91},
					{X=45,Z=88,Scene=2,X_MIN=43,X_MAX=49,Z_MIN=85,Z_MAX=91},
					{X=37,Z=95,Scene=2,X_MIN=35,X_MAX=40,Z_MIN=91,Z_MAX=99},
					{X=45,Z=96,Scene=2,X_MIN=43,X_MAX=49,Z_MIN=93,Z_MAX=99},
					{X=37,Z=103,Scene=2,X_MIN=35,X_MAX=40,Z_MIN=101,Z_MAX=107},
					{X=46,Z=104,Scene=2,X_MIN=43,X_MAX=48,Z_MIN=100,Z_MAX=106},
					{X=37,Z=110,Scene=2,X_MIN=35,X_MAX=40,Z_MIN=108,Z_MAX=113},
					{X=45,Z=110,Scene=2,X_MIN=43,X_MAX=48,Z_MIN=108,Z_MAX=113},
					{X=37,Z=118,Scene=2,X_MIN=35,X_MAX=41,Z_MIN=115,Z_MAX=121},
					{X=46,Z=118,Scene=2,X_MIN=43,X_MAX=48,Z_MIN=115,Z_MAX=121},
					{X=37,Z=126,Scene=2,X_MIN=35,X_MAX=40,Z_MIN=123,Z_MAX=129},
					{X=45,Z=126,Scene=2,X_MIN=43,X_MAX=48,Z_MIN=123,Z_MAX=129},
						{X=264,Z=175,Scene=2,X_MIN=262,X_MAX=266,Z_MIN=172,Z_MAX=178},
						{X=270,Z=175,Scene=2,X_MIN=268,X_MAX=272,Z_MIN=172,Z_MAX=178},
						{X=277,Z=175,Scene=2,X_MIN=275,X_MAX=279,Z_MIN=173,Z_MAX=178},
						{X=287,Z=175,Scene=2,X_MIN=285,X_MAX=289,Z_MIN=172,Z_MAX=178},
						{X=270,Z=183,Scene=2,X_MIN=268,X_MAX=272,Z_MIN=180,Z_MAX=186},
						{X=277,Z=183,Scene=2,X_MIN=275,X_MAX=279,Z_MIN=180,Z_MAX=186},
						{X=287,Z=183,Scene=2,X_MIN=285,X_MAX=289,Z_MIN=180,Z_MAX=186},
						{X=270,Z=192,Scene=2,X_MIN=268,X_MAX=272,Z_MIN=189,Z_MAX=195},
						{X=277,Z=192,Scene=2,X_MIN=275,X_MAX=279,Z_MIN=189,Z_MAX=195},
						{X=287,Z=192,Scene=2,X_MIN=285,X_MAX=289,Z_MIN=189,Z_MAX=195},
						{X=287,Z=200,Scene=2,X_MIN=285,X_MAX=289,Z_MIN=197,Z_MAX=203},
						{X=287,Z=209,Scene=2,X_MIN=285,X_MAX=289,Z_MIN=206,Z_MAX=212},
					{X=134,Z=272,Scene=2,X_MIN=132,X_MAX=136,Z_MIN=269,Z_MAX=274},
					{X=141,Z=272,Scene=2,X_MIN=139,X_MAX=143,Z_MIN=269,Z_MAX=274},
					{X=148,Z=272,Scene=2,X_MIN=146,X_MAX=150,Z_MIN=269,Z_MAX=275},
					{X=173,Z=271,Scene=2,X_MIN=171,X_MAX=175,Z_MIN=268,Z_MAX=274},
					{X=181,Z=271,Scene=2,X_MIN=179,X_MAX=183,Z_MIN=268,Z_MAX=274},
					{X=188,Z=271,Scene=2,X_MIN=186,X_MAX=190,Z_MIN=268,Z_MAX=273},
					{X=134,Z=279,Scene=2,X_MIN=132,X_MAX=136,Z_MIN=276,Z_MAX=281},
					{X=141,Z=279,Scene=2,X_MIN=139,X_MAX=143,Z_MIN=276,Z_MAX=281},
					{X=148,Z=279,Scene=2,X_MIN=146,X_MAX=150,Z_MIN=276,Z_MAX=282},
					{X=173,Z=279,Scene=2,X_MIN=171,X_MAX=175,Z_MIN=276,Z_MAX=281},
					{X=181,Z=279,Scene=2,X_MIN=179,X_MAX=183,Z_MIN=276,Z_MAX=281},
					{X=188,Z=279,Scene=2,X_MIN=186,X_MAX=190,Z_MIN=276,Z_MAX=281},
						{X=47,Z=160,Scene=0,X_MIN=44,X_MAX=50,Z_MIN=156,Z_MAX=164},
						{X=41,Z=170,Scene=0,X_MIN=38,X_MAX=44,Z_MIN=166,Z_MAX=174},
						{X=48,Z=170,Scene=0,X_MIN=45,X_MAX=51,Z_MIN=166,Z_MAX=174},
						{X=56,Z=170,Scene=0,X_MIN=53,X_MAX=59,Z_MIN=166,Z_MAX=174},
						{X=63,Z=170,Scene=0,X_MIN=60,X_MAX=66,Z_MIN=166,Z_MAX=174},
						{X=41,Z=179,Scene=0,X_MIN=38,X_MAX=44,Z_MIN=175,Z_MAX=183},
						{X=48,Z=179,Scene=0,X_MIN=45,X_MAX=51,Z_MIN=175,Z_MAX=183},
						{X=56,Z=179,Scene=0,X_MIN=53,X_MAX=59,Z_MIN=175,Z_MAX=183},
						{X=63,Z=179,Scene=0,X_MIN=60,X_MAX=66,Z_MIN=175,Z_MAX=183},
						{X=44,Z=188,Scene=0,X_MIN=41,X_MAX=47,Z_MIN=184,Z_MAX=192},
						{X=51,Z=188,Scene=0,X_MIN=48,X_MAX=54,Z_MIN=184,Z_MAX=192},
						{X=51,Z=197,Scene=0,X_MIN=48,X_MAX=54,Z_MIN=193,Z_MAX=201},
					{X=269,Z=162,Scene=0,X_MIN=266,X_MAX=272,Z_MIN=158,Z_MAX=166},
					{X=276,Z=162,Scene=0,X_MIN=273,X_MAX=279,Z_MIN=158,Z_MAX=166},
					{X=255,Z=170,Scene=0,X_MIN=252,X_MAX=258,Z_MIN=166,Z_MAX=174},
					{X=262,Z=170,Scene=0,X_MIN=259,X_MAX=265,Z_MIN=166,Z_MAX=174},
					{X=269,Z=170,Scene=0,X_MIN=266,X_MAX=272,Z_MIN=166,Z_MAX=174},
					{X=276,Z=170,Scene=0,X_MIN=273,X_MAX=279,Z_MIN=166,Z_MAX=174},
					{X=255,Z=178,Scene=0,X_MIN=252,X_MAX=258,Z_MIN=174,Z_MAX=182},
					{X=262,Z=178,Scene=0,X_MIN=259,X_MAX=265,Z_MIN=174,Z_MAX=182},
					{X=269,Z=179,Scene=0,X_MIN=266,X_MAX=272,Z_MIN=175,Z_MAX=183},
					{X=276,Z=179,Scene=0,X_MIN=273,X_MAX=279,Z_MIN=175,Z_MAX=183},
					{X=262,Z=187,Scene=0,X_MIN=259,X_MAX=265,Z_MIN=183,Z_MAX=191},
					{X=269,Z=187,Scene=0,X_MIN=263,X_MAX=272,Z_MIN=183,Z_MAX=191},
						{X=77,Z=251,Scene=0,X_MIN=74,X_MAX=80,Z_MIN=247,Z_MAX=255},
						{X=83,Z=251,Scene=0,X_MIN=80,X_MAX=86,Z_MIN=247,Z_MAX=255},
						{X=89,Z=251,Scene=0,X_MIN=86,X_MAX=92,Z_MIN=247,Z_MAX=255},
						{X=94,Z=251,Scene=0,X_MIN=91,X_MAX=97,Z_MIN=247,Z_MAX=255},
						{X=100,Z=251,Scene=0,X_MIN=97,X_MAX=103,Z_MIN=247,Z_MAX=255},
						{X=77,Z=259,Scene=0,X_MIN=74,X_MAX=80,Z_MIN=255,Z_MAX=264},
						{X=83,Z=259,Scene=0,X_MIN=80,X_MAX=86,Z_MIN=255,Z_MAX=264},
						{X=89,Z=259,Scene=0,X_MIN=86,X_MAX=92,Z_MIN=255,Z_MAX=264},
						{X=94,Z=259,Scene=0,X_MIN=91,X_MAX=97,Z_MIN=255,Z_MAX=264},
						{X=100,Z=259,Scene=0,X_MIN=97,X_MAX=103,Z_MIN=255,Z_MAX=264},
						{X=227,Z=251,Scene=0,X_MIN=224,X_MAX=230,Z_MIN=247,Z_MAX=255},
						{X=235,Z=251,Scene=0,X_MIN=232,X_MAX=238,Z_MIN=247,Z_MAX=255},
							{X=64,Z=98,Scene=1,X_MIN=61,X_MAX=66,Z_MIN=95,Z_MAX=102},
							{X=63,Z=110,Scene=1,X_MIN=61,X_MAX=66,Z_MIN=106,Z_MAX=113},
							{X=56,Z=121,Scene=1,X_MIN=53,X_MAX=58,Z_MIN=117,Z_MAX=124},
							{X=64,Z=121,Scene=1,X_MIN=61,X_MAX=66,Z_MIN=117,Z_MAX=124},
							{X=63,Z=133,Scene=1,X_MIN=61,X_MAX=66,Z_MIN=130,Z_MAX=137},
							{X=64,Z=145,Scene=1,X_MIN=61,X_MAX=66,Z_MIN=141,Z_MAX=148},
							{X=52,Z=216,Scene=1,X_MIN=49,X_MAX=54,Z_MIN=212,Z_MAX=219},
							{X=62,Z=212,Scene=1,X_MIN=60,X_MAX=65,Z_MIN=208,Z_MAX=215},
							{X=51,Z=223,Scene=1,X_MIN=49,X_MAX=54,Z_MIN=220,Z_MAX=227},
							{X=63,Z=222,Scene=1,X_MIN=60,X_MAX=65,Z_MIN=218,Z_MAX=225},
							{X=51,Z=232,Scene=1,X_MIN=49,X_MAX=54,Z_MIN=228,Z_MAX=235},
							{X=63,Z=232,Scene=1,X_MIN=20,X_MAX=65,Z_MIN=228,Z_MAX=235},
						{X=119,Z=54,Scene=1,X_MIN=116,X_MAX=121,Z_MIN=50,Z_MAX=57},
						{X=126,Z=54,Scene=1,X_MIN=124,X_MAX=129,Z_MIN=50,Z_MAX=57},
						{X=136,Z=54,Scene=1,X_MIN=133,X_MAX=138,Z_MIN=50,Z_MAX=57},
						{X=145,Z=54,Scene=1,X_MIN=142,X_MAX=147,Z_MIN=50,Z_MAX=57},
						{X=154,Z=54,Scene=1,X_MIN=151,X_MAX=156,Z_MIN=50,Z_MAX=57},
						{X=162,Z=54,Scene=1,X_MIN=160,X_MAX=165,Z_MIN=50,Z_MAX=57},
						{X=194,Z=53,Scene=1,X_MIN=192,X_MAX=197,Z_MIN=49,Z_MAX=56},
						{X=204,Z=53,Scene=1,X_MIN=200,X_MAX=205,Z_MIN=49,Z_MAX=56},
						{X=209,Z=53,Scene=1,X_MIN=207,X_MAX=212,Z_MIN=49,Z_MAX=56},
						{X=218,Z=53,Scene=1,X_MIN=216,X_MAX=221,Z_MIN=49,Z_MAX=56},
						{X=227,Z=53,Scene=1,X_MIN=224,X_MAX=229,Z_MIN=49,Z_MAX=56},
						{X=235,Z=53,Scene=1,X_MIN=232,X_MAX=237,Z_MIN=49,Z_MAX=56},
							{X=114,Z=252,Scene=1,X_MIN=111,X_MAX=116,Z_MIN=248,Z_MAX=255},
							{X=122,Z=252,Scene=1,X_MIN=119,X_MAX=124,Z_MIN=248,Z_MAX=255},
							{X=129,Z=252,Scene=1,X_MIN=127,X_MAX=132,Z_MIN=248,Z_MAX=255},
							{X=137,Z=252,Scene=1,X_MIN=135,X_MAX=140,Z_MIN=248,Z_MAX=255},
							{X=145,Z=252,Scene=1,X_MIN=143,X_MAX=148,Z_MIN=248,Z_MAX=255},
							{X=153,Z=252,Scene=1,X_MIN=151,X_MAX=156,Z_MIN=248,Z_MAX=255},
							{X=217,Z=251,Scene=1,X_MIN=215,X_MAX=220,Z_MIN=247,Z_MAX=254},
							{X=223,Z=251,Scene=1,X_MIN=221,X_MAX=226,Z_MIN=247,Z_MAX=254},
							{X=229,Z=251,Scene=1,X_MIN=227,X_MAX=232,Z_MIN=247,Z_MAX=254},
							{X=217,Z=259,Scene=1,X_MIN=215,X_MAX=220,Z_MIN=255,Z_MAX=262},
							{X=223,Z=259,Scene=1,X_MIN=221,X_MAX=226,Z_MIN=255,Z_MAX=262},
							{X=229,Z=259,Scene=1,X_MIN=227,X_MAX=232,Z_MIN=255,Z_MAX=262}}
--种植产品在commonitem中的编号
V_ZHONGZHI_ID = {20104001,20104002,20104003,20104004,20104005,20104006,20104007,20104008,20104009,20104010,
				20104011,20104012,20105001,20105002,20105003,20105004,20105005,20105006,20105007,20105008,
				20105009,20105010,20105011,20105012}
--种植产品的等级
V_ZHONGZHI_NEEDLEVEL = {1,2,3,4,5,6,7,8,9,10,
						11,12,1,2,3,4,5,6,7,8,
						9,10,11,12}
--种植产品的名称
V_ZHONGZHI_NAME = {"小麦","大米","玉米","花生","红薯","高粱","芝麻","绿豆","黄豆","蚕豆",
					"马铃薯","芋头","麻","棉","绸","帛","绢","丝","缎","绫",
					"罗","绒","纱","锦"}
--种植时放入的幼苗生长点在growpoint.txt中的编号
V_ZHONGZHI_ITEMBOX_ID = {501,504,507,510,513,516,519,522,525,528,
					531,534,537,540,543,546,549,552,555,558,
					561,564,567,570}
randomseed(clock());

--门派ID号宏定义
OR_SHAOLIN  = 0
OR_MINGJIAO = 1
OR_GAIBANG  = 2
OR_WUDANG   = 3
OR_EMEI     = 4
OR_XINGSU   = 5
OR_DALI     = 6
OR_TIANSHAN = 7
OR_XIAOYAO  = 8
OR_WUMENPAI = 9

--场景数量宏定义
SCENE_NUMBER  = 42

--场景名称宏定义
SCENE_NAME ={ "洛阳", "苏州", "大理", "嵩山", "太湖", "镜湖", "无量山","剑阁","敦煌","少林寺","丐帮总舵","光明顶","武当山", "天龙寺", "凌波洞", "峨嵋山", "星宿海", "天山", "雁南", "雁北", "草原", "辽西", "长白山", "黄龙府", "苍山", "洱海", "石林", "玉溪", "南诏", "苗疆", "西湖", "龙泉", "武夷", "梅岭", "南海", "琼洲", "聚贤庄", "燕子坞", "一品堂", "预留1", "预留2", "预留3"}

--种植牌子NPC是否已种宏定义
--ZHONGZHIPAI_1 = 0	--0没人种，1正在生长，2土地休整不能种植

MISSION_4006=4006
MISSION_4007=4007
MISSION_4008=4008
MISSION_4009=4009
MISSION_4013=4013
MISSION_4022=4022
MISSION_4028=4028
MISSION_547=547
MISSION_564=564
MISSION_561=561

--*******************************************************************************
--定义Msg2player中最后一个变量
--*******************************************************************************
MSG2PLAYER_PARA=8

--*******************************************************************************
--可执行邮件 param0 的可能值
--*******************************************************************************
MAIL_REPUDIATE				= 1			--强制离婚
MAIL_BETRAYMASTER			= 2			--叛师
MAIL_EXPELPRENTICE			= 3			--开除徒弟
MAIL_UPDATE_ATTR			= 4			--属性刷新
--*******************************************************************************
--配方用宏定义
--*******************************************************************************
USERECIPE_SCRIPT	= 713501			--使用配方的脚本编号

--*******************************************************************************
--生活技能
--*******************************************************************************

ABILITY_PENGREN	= 1		--烹饪技能对应编号
ABILITY_ZHIYAO	= 2		--制药技能对应编号
ABILITY_XIANGQIAN	= 3		--镶嵌技能对应编号
ABILITY_ZHUZAO= 4		--铸造技能对应编号
ABILITY_FENGREN	= 5		--缝纫技能对应编号
ABILITY_GONGYI	= 6		--工艺制作技能对应编号
ABILITY_CAIKUANG	= 7		--采矿技能对应编号
ABILITY_CAIYAO	= 8		--采药技能对应编号
ABILITY_DIAOYU	= 9		--钓鱼技能对应编号
ABILITY_ZHONGZHI	= 10		--种植技能对应编号
ABILITY_KAIGUANG	= 11		--开光技能对应编号
ABILITY_SHENGHUOSHU	= 12		--圣火术技能对应编号
ABILITY_NIANGJIU	= 13		--酿酒技能对应编号
ABILITY_XUANBINGSHU	= 14		--玄冰术技能对应编号
ABILITY_ZHIGU	= 15		--制蛊技能对应编号
ABILITY_ZHIDU	= 16		--制毒技能对应编号
ABILITY_ZHIFU	= 17		--制符技能对应编号
ABILITY_LIANDAN	= 18		--炼丹技能对应编号
ABILITY_QIMENDUNJIA	= 19		--奇门遁甲技能对应编号
ABILITY_GONGCHENGXUE	= 20		--工程学技能对应编号
ABILITY_QUGUI	= 21		--驱鬼技能对应编号
ABILITY_WABAO	= 22		--挖宝技能对应编号
ABILITY_PAOSHANG	= 23		--跑商技能对应编号
ABILITY_SHAJIA	= 24		--杀价技能对应编号
ABILITY_REMAI	= 25		--热卖技能对应编号
ABILITY_CAOZUOZHONG	= 26		--操作中技能对应编号
ABILITY_YAOLI = 27		--药理技能对应编号
ABILITY_YANGSHENGFA = 28 --养生法
ABILITY_FOFA = 29	--佛法					少林 用于辅助	开光
ABILITY_CAIHUOSHU = 30	--采火术			明教 用于辅助	圣火术
ABILITY_LIANHUALUO = 31	--莲花落			丐帮 用于辅助	酿酒
ABILITY_CAIBINGSHU = 32	--采冰术			天山 用于辅助	玄冰术
ABILITY_JINGMAIBAIJUE = 33	--经脉百决		大理 用于辅助	制蛊
ABILITY_YINCHONGSHU = 34	--引虫术		星宿 用于辅助	制毒
ABILITY_LINGXINSHU = 35	--灵心术			峨嵋 用于辅助	制符
ABILITY_DAOFA = 36	--道法					武当 用于辅助	炼丹
ABILITY_LIUYIFENGGU = 37	--六艺风骨		逍遥 用于辅助	奇门遁甲


--*******************************************************************************
--生活技能升级相关
--*******************************************************************************
--Money 升到本级需要的钱	HumanExp 需要的经验	AbilityExpLimit必须有这么多熟练度才能升到本级
--AbilityExpLimitTop 本级获得熟练度的上限	HumanLevelLimit 升到本级对人物等级的限制
--第一行是从0级升到1级需要的
LEVELUP_ABILITY		={{Money=100,HumanExp=1000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=1000,HumanLevelLimit=10},
					{Money=200,HumanExp=2000,AbilityExpLimit=1000,AbilityExpLimitShow=10,AbilityExpLimitTop=3000,HumanLevelLimit=15},
					{Money=300,HumanExp=3000,AbilityExpLimit=3000,AbilityExpLimitShow=30,AbilityExpLimitTop=6000,HumanLevelLimit=20},
					{Money=400,HumanExp=4000,AbilityExpLimit=6000,AbilityExpLimitShow=60,AbilityExpLimitTop=10000,HumanLevelLimit=25},
					{Money=500,HumanExp=5000,AbilityExpLimit=10000,AbilityExpLimitShow=100,AbilityExpLimitTop=15000,HumanLevelLimit=30},
					{Money=600,HumanExp=6000,AbilityExpLimit=15000,AbilityExpLimitShow=150,AbilityExpLimitTop=21000,HumanLevelLimit=35},
					{Money=700,HumanExp=7000,AbilityExpLimit=21000,AbilityExpLimitShow=210,AbilityExpLimitTop=28000,HumanLevelLimit=40},
					{Money=800,HumanExp=8000,AbilityExpLimit=28000,AbilityExpLimitShow=280,AbilityExpLimitTop=36000,HumanLevelLimit=45},
					{Money=900,HumanExp=9000,AbilityExpLimit=36000,AbilityExpLimitShow=360,AbilityExpLimitTop=45000,HumanLevelLimit=50},
					{Money=1000,HumanExp=10000,AbilityExpLimit=45000,AbilityExpLimitShow=450,AbilityExpLimitTop=550000,HumanLevelLimit=55},
					{Money=0,HumanExp=0,AbilityExpLimit=550000,AbilityExpLimitShow=550,AbilityExpLimitTop=550000,HumanLevelLimit=60},
					{Money=0,HumanExp=0,AbilityExpLimit=550000,AbilityExpLimitShow=550,AbilityExpLimitTop=550000,HumanLevelLimit=60}
						}
--辅助类生活技能升级，辅助类生活技能100级满，1-30级在城市或者门派npc学，
LEVELUP_ABILITY_ASSISTANT ={{Money=1000,HumanExp=0,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=2000,HumanExp=100,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=4000,HumanExp=200,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=6000,HumanExp=300,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=5},
							{Money=8000,HumanExp=400,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=10000,HumanExp=500,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=12000,HumanExp=600,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=14000,HumanExp=700,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=16000,HumanExp=800,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=18000,HumanExp=900,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
								{Money=20000,HumanExp=1000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
								{Money=22000,HumanExp=1100,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
								{Money=24000,HumanExp=1200,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
								{Money=26000,HumanExp=1300,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
								{Money=28000,HumanExp=1400,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
								{Money=30000,HumanExp=1500,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
								{Money=32000,HumanExp=1600,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
								{Money=34000,HumanExp=1700,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
								{Money=36000,HumanExp=1800,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
								{Money=38000,HumanExp=1900,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=20000,HumanExp=1000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=22000,HumanExp=1100,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=24000,HumanExp=1200,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=26000,HumanExp=1300,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=28000,HumanExp=1400,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=30000,HumanExp=1500,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=32000,HumanExp=1600,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=34000,HumanExp=1700,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=36000,HumanExp=1800,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0},
							{Money=38000,HumanExp=1900,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=0}
						}
--镶嵌技能的数据
LEVELUP_ABILITY_XIANGQIAN			={{Money=100,HumanExp=1000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=10},
									{Money=200,HumanExp=2000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=15},
									{Money=300,HumanExp=3000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=20},
									{Money=400,HumanExp=4000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=25},
									{Money=500,HumanExp=5000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=30},
									{Money=600,HumanExp=6000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=35},
									{Money=700,HumanExp=7000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=40},
									{Money=800,HumanExp=8000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=45},
									{Money=900,HumanExp=9000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=50},
									{Money=1000,HumanExp=10000,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=55},
									{Money=0,HumanExp=0,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=60},
									{Money=0,HumanExp=0,AbilityExpLimit=0,AbilityExpLimitShow=0,AbilityExpLimitTop=0,HumanLevelLimit=60}
									}
--*******************************************************************************
--合成材料分类
--*******************************************************************************
ZHIYAO_CHUJICAILIAO = 1
ZHIYAO_ZHONGJICAILIAO = 2
ZHIYAO_GAOJICAILIAO =3
PENGREN_CHUJICAILIAO = 4
PENGREN_ZHONGJICAILIAO = 5
PENGREN_GAOJICAILIAO = 6

--*******************************************************************************
--生活技能使用相关
--*******************************************************************************
--Vigor  活力   Energy   精力
CONSUME_ABILITY_CAIYAO={{Vigor=10,Energy=0},
						{Vigor=20,Energy=0},
						{Vigor=30,Energy=0},
						{Vigor=40,Energy=0},
						{Vigor=50,Energy=0},
						{Vigor=60,Energy=0},
						{Vigor=70,Energy=0},
						{Vigor=80,Energy=0},
						{Vigor=90,Energy=0},
						{Vigor=100,Energy=0},
						{Vigor=110,Energy=0},
						{Vigor=120,Energy=0},
						}

--*******************************************************************************
--ABILITYLOGIC
--*******************************************************************************
ABILITYLOGIC_ID = 701601


--*******************************************************************************
--MissionData中各个数据的定义
--*******************************************************************************
MD_PINPAN_DAYCOUNT		= 0		--100000的倍数是当前完成的环数，小于100000的数是时间
MD_PINPAN_HUAN			= 1		--平叛
MD_WABAO_DAYCOUNT		= 2		--100000的倍数是当前完成的环数，小于100000的数是时间
MD_WABAO_HUAN			= 3		--挖宝
MD_BAIMASI_DAYCOUNT		= 4		--100000的倍数是当前完成的环数，小于100000的数是时间
MD_BAIMASI_HUAN			= 5		--白马寺
MD_SHUILAO_DAYCOUNT		= 6		--100000的倍数是当前完成的环数，小于100000的数是时间
MD_SHUILAO_HUAN			= 7		--水牢
MD_MURENXIANG_DAYCOUNT	= 8		--100000的倍数是当前完成的环数，小于100000的数是时间
MD_MURENXIANG_HUAN		= 9		--木人巷
MD_WENDA_DAYCOUNT		=10		--100000的倍数是当前完成的环数，小于100000的数是时间
MD_WENDA_HUAN			=11		--问答
MD_LINGLONG_DAYCOUNT	=12		--100000的倍数是当前完成的环数，小于100000的数是时间
MD_LINGLONG_HUAN		=13		--玲珑
MD_CAOYUN_DAYCOUNT		=14		--100000的倍数是当前完成的环数，小于100000的数是时间
MD_CAOYUN_HUAN			=15		--漕运


--*******************************************************************************
--场景号
--*******************************************************************************
SCENE_SCRIPT_ID		= 888888
SCENE_LUOYANG			= 0		-- 洛阳
SCENE_SUZHOU			= 1		-- 苏州
SCENE_DALI				= 2		-- 大理
SCENE_SONGSHAN			= 3		-- 嵩山
SCENE_TAIHU				= 4		-- 太湖
SCENE_JINGHU			= 5		-- 镜湖
SCENE_WULIANG			= 6		-- 无量山
SCENE_JIANGE			= 7		-- 剑阁
SCENE_DUNHUANG			= 8		-- 敦煌
SCENE_SHAOLIN			= 9		-- 少林寺
SCENE_GAIBANG			= 10	-- 丐帮总舵


--*******************************************************************************
--装备代号表
--*******************************************************************************
HEQUIP_WEAPON			= 0		-- 武器	WEAPON
HEQUIP_CAP				= 1		-- 帽子	DEFENCE
HEQUIP_ARMOR			= 2		-- 盔甲	DEFENCE
HEQUIP_CUFF				= 3		-- 护腕	DEFENCE
HEQUIP_BOOT				= 4		-- 鞋	DEFENCE
HEQUIP_SASH				= 5		-- 腰带	ADORN
HEQUIP_RING				= 6		-- 戒子	ADORN
HEQUIP_NECKLACE			= 7		-- 项链	ADORN

-- 宠物脚本
PETCOMMON				= 335000

-- 任务脚本
MISSION_SCRIPT	=	888890
MISSION_PROMULGATOR								= 1 -- 任务发布人
MISSION_SUBMITOR	  							= 2 -- 任务接收人
MISSION_PROMULGATOR_AND_SUBMITOR	= 3 -- 同时发布、接收任务

--副本类型
FUBEN_EXAMPLE		= 999
FUBEN_MURENXIANG_7 	= 998
FUBEN_MURENXIANG_9	= 997
FUBEN_MURENXIANG	= 996
FUBEN_SHUILAO		= 995
FUBEN_ZHENGLONG		= 994

--漕运货商事件
PRE_TIME = 0
DUA_TIME = 0
EVENT_NOW = 0
