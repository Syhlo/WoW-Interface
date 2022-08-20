local dontHideOnEscape = {
	"RESURRECT",
	"RESURRECT_NO_SICKNESS",
	"RESURRECT_NO_TIMER",
	"SKINNED_REPOP",
	"CONFIRM_SUMMON",
	"BFMGR_INVITED_TO_QUEUE_WARMUP",
	"BFMGR_INVITED_TO_QUEUE",
	"BFMGR_INVITED_TO_ENTER",
	"ARENA_TEAM_INVITE",
	"PARTY_INVITE",
	"AREA_SPIRIT_HEAL",
}

for _,v in ipairs(dontHideOnEscape) do
	if (StaticPopupDialogs[v]) then
		StaticPopupDialogs[v].hideOnEscape = false
	end
end