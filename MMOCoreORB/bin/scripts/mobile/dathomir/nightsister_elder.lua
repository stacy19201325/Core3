nightsister_elder = Creature:new {
	objectName = "@mob/creature_names:nightsister_elder",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 278,
	chanceHit = 27.25,
	damageMin = 1520,
	damageMax = 2750,
	baseXp = 26654,
	baseHAM = 321000,
	baseHAMmax = 392000,
	armor = 3,
	resists = {200,25,25,200,200,200,200,200,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + HEALER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_dathomir_nightsister_elder.iff"},
	lootGroups = {
		{
			groups = {
<<<<<<< HEAD
				{group = "nightsister_rare", chance = 1200000},
				{group = "crystals_premium", chance = 800000},
				{group = "nightsister_common", chance = 3500000},
				{group = "armor_attachments", chance = 1750000},
				{group = "clothing_attachments", chance = 1750000},
				{group = "deed_voucher", chance = 1000000}
			},
			lootChance = 6500000
=======
				{group = "power_crystals", chance = 800000},
				{group = "nightsister_common", chance = 2200000},
				{group = "junk", chance = 1000000},
				{group = "armor_attachments", chance = 500000},
				{group = "clothing_attachments", chance = 500000},
				{group = "pistols", chance = 800000},
				{group = "rifles", chance = 800000},
				{group = "carbines", chance = 900000},
				{group = "melee_weapons", chance = 2000000},
				{group = "wearables_scarce", chance = 500000}
			}
>>>>>>> publish9
		}
	},
	weapons = {},
	conversationTemplate = "",
	attacks = merge(tkamaster,brawlermaster,forcepowermaster)
}

CreatureTemplates:addCreatureTemplate(nightsister_elder, "nightsister_elder")
