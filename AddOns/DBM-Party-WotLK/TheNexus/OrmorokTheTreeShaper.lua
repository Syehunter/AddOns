local mod	= DBM:NewMod(620, "DBM-Party-WotLK", 8, 281)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 220 $"):sub(12, -3))
mod:SetCreatureID(26794)
mod:SetEncounterID(524, 525)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 47958 57082 57083 48017 57086",
	"SPELL_AURA_APPLIED 47981",
	"SPELL_AURA_REMOVED 47981",
	"SPELL_SUMMON 61564"
)

local warningFrenzy			= mod:NewSpellAnnounce(48017, 3, nil, "Tank|Healer", 2)
local warningAdd			= mod:NewSpellAnnounce(61564, 2)

local specWarnReflection	= mod:NewSpecialWarningReflect(47981, "SpellCaster", nil, nil, 1, 2)
local specWarnSpikes		= mod:NewSpecialWarningDodge(47958, nil, nil, nil, 2, 2)

local timerReflection		= mod:NewBuffActiveTimer(15, 47981, nil, "SpellCaster", 2, 5)
local timerReflectionCD		= mod:NewCDTimer(30, 47981, nil, "SpellCaster", 2, 5)
local timerSpikesCD			= mod:NewCDTimer(14, 47958, nil, nil, nil, 2)--Health based or CD?

local voiceSpikes			= mod:NewVoice(47958)
local voiceReflection		= mod:NewVoice(47981, "SpellCaster")

function mod:OnCombatStart(delay)
	timerSpikesCD:Start(10-delay)
	timerReflectionCD:Start(20-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(47958, 57082, 57083) then
		specWarnSpikes:Show()
		timerSpikesCD:Start()
		voiceSpikes:Play("watchstep")
	elseif args:IsSpellID(48017, 57086) then
		warningFrenzy:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 47981 then
		timerReflection:Start()
		specWarnReflection:Show()
		timerReflectionCD:Start()
		voiceReflection:Play("stopattack")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 47981 then
		timerReflection:Cancel()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 61564 then
		warningAdd:Show()
	end
end
