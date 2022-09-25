-- ------------------------------------------------------------------------- --
-- Project: Executive Assistant - To-Do/Task List Manager
-- Author:  VincentSDSH				
-- Localisation.lua for English
-- ------------------------------------------------------------------------- --
local AddonName = ...
local L = LibStub('AceLocale-3.0'):NewLocale(AddonName, 'enUS', true)

L.appName = "File Cabinet"
L.appNameC = 'Executive Assistant'
L.versionData = "Addon version %s updated to WoW version %s"
L.MakeNewBackup = "%s Click Here to Backup %s Groups and Tasks"
L.eafc_Import = "Import"
L.eafc_Restore = "Restore"
L.eafc_Update = "Update"
L.eafc_Delete = "Delete"
L.eafc_tooltipTip_Backup = "Creates a new backup of %s Groups and Tasks"
L.eafc_tooltipTip_Restore = "Copies Backup to %s, Replacing All Existing Groups and Tasks"
L.eafc_tooltipTip_Update = "Copies Backup to %s, WITHOUT Replacing Existing Groups and Tasks"
L.eafc_tooltipTip_Delete = "Removes This Backup"
L.HideMapIcon = "Hide Minimap Icon"
L.mainOpts_intro = "%s is a backup and restore utility for %s.\n\nThe backups and restores from this utility are real-time which gives the user some flexibility in its use.\n\nFor users who don't run regular backups of their addons and saved variables directories (seriously back up these directories regularly!) this can serve as a backstop against loss of Group, Task, and Character configuration.\n\nThe real-time nature also allows the user to backup a configuration, try something new, and revert if it doesn't work out as planned.\n\nTaking that a bit further, one may work on a new layout bits and pieces at at time. Backup the Working configuration then begin work on the New. Backup unfinished New and restore Working. Then restore the New when you want to work on it some more, back it up and restore the Working copy, etc, until complete. (NB: Character Task Completion is stored but not Account Wide. Completion data was originally intended to be purged however it was requested that the error be retained to facilitate this process...The developer is still deciding if this is a 'bug' or a 'feature')" 
L.RestoreComplete = "Restore Complete for %s"
L.ImportComplete = "Import Complete for %s [%s]"
L.Deleted = "Deleted Archive: %s"
